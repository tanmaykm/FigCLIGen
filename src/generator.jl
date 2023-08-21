const sdir = @__DIR__
const SPEC = joinpath(sdir, "opa.json")
const CLIMODULE = joinpath(sdir, "cli.jl")

const RESERVED_WORDS = [
    "if", "else", "elseif", "while", "for", "begin", "end", "quote",
    "try", "catch", "return", "local", "function", "macro", "ccall", "finally", "break", "continue",
    "global", "module", "using", "import", "export", "const", "let", "do", "baremodule",
    "Type", "Enum", "Any", "DataType", "Base"
]

function default_base_command(spec::Dict{String,Any})
    return """
    \"\"\"
    The base CLI command.
    $(spec["description"])
    \"\"\"
    function $(spec["name"])()
        return `$(spec["name"])`
    end
    """
end

function wrap_module(f, io::IO, spec::Dict{String,Any}; custom_include::AbstractString=nothing, ignore_base_command::Bool=false)
    println(io, """
    \"\"\"
    CLI for $(spec["name"]).
    $(spec["description"])

    Generated via @__MODULE__. Do not edit directly.
    Edit the specification file and run the generator instead.
    \"\"\"
    module CLI

    """)

    if !isnothing(custom_include)
        println(io, custom_include)
    end

    if !ignore_base_command
        println(io, default_base_command(spec))
    end

    f(io, spec)

    println(io, """
    end # module CLI
    """)
end

function strip_leading_dashes(s::AbstractString)
    if startswith(s, "--")
        return strip_leading_dashes(s[3:end])
    elseif startswith(s, "-")
        return strip_leading_dashes(s[2:end])
    else
        return s
    end
end

function convert_dashes_to_underscores(s::AbstractString)
    return replace(s, "-" => "_")
end

function escape_reserved_word(s::AbstractString)
    if s in RESERVED_WORDS
        return "_$(s)"
    else
        return s
    end
end

function get_option_name(option::Dict{String,Any})
    optname = optname_spec = option["name"]
    if isa(optname_spec, Vector)
        for n in optname
            if startswith(n, "--")
                optname = n
                break
            end
        end
        if isa(optname, Vector)
            optname = first(optname_spec)
        end
    end

    julia_optname = escape_reserved_word(convert_dashes_to_underscores(strip_leading_dashes(optname)))

    return julia_optname, optname
end

function gen_command(io::IO, spec::Dict{String,Any}; parent::Union{Nothing,String}=nothing)
    name = spec["name"]
    description = get(spec, "description", "")
    options = get(spec, "options", Dict{String,Any}())

    docstring = """$(name)
    Run the $(name)"""

    if !isnothing(parent)
        docstring *= " subcommand of $(parent) command."
    else
        docstring *= " command."
    end

    if !isempty(description)
        docstring *= "\n$(description)"
    end

    kwargs_str = ""
    kwargs = []
    if !isempty(options)
        docstring *= "\n\nOptions:\n"
        kwargs_str = "; "
        for option in options
            julia_optname, optname = get_option_name(option)
            isbool = !(haskey(option, "args") && !isempty(option["args"]))
            opttype = isbool ? "Bool" : "AbstractString"
            opt_default = if isbool
                "false"
            else
                default = get(option["args"], "default", nothing)
                if isnothing(default)
                    "nothing"
                else
                    "\"$(default)\""
                end
            end
            docstring *= "    $(julia_optname)::$(opttype) - $(option["description"])\n"
            kwargs_str *= "$(julia_optname)::Union{Nothing,$(opttype)} = $(opt_default), "
            push!(kwargs, (optname, julia_optname, isbool))
        end
    end

    println(io, """\"\"\" $(docstring) \"\"\"
    function $(name)(parent::Cmd$(kwargs_str))
        cmd = parent""")
    for (optname, julia_optname, isbool) in kwargs
        if isbool
            println(io, """
                if !isnothing($(julia_optname)) && $(julia_optname)
                    cmd = `\$(cmd) $(optname)`
                end
            """)
        else
            println(io, """
                if !isnothing($(julia_optname))
                    cmd = `\$(cmd) $(optname)=$(julia_optname)`
                end
            """)
        end
    end
    println(io, """
        return cmd
    end
    """)
end

"""
Generate a Julia module for a CLI based on a specification file.

Arguments:
- `specfile`: path to the specification file
- `outputfile`: path to the output file

Keyword arguments:
- `custom_include`: a string to include at the top of the generated module
- `ignore_base_command`: if `true`, do not generate the base command.
                        The base command must be made available by the caller,
                        either by including it in `custom_include` or by
                        defining it in the module before calling `generate`.
"""

function generate(specfile::AbstractString, outputfile::AbstractString; kwargs...)
    spec = JSON.parsefile(specfile)
    generate(spec, outputfile)
end

function generate(spec::Dict{String,Any}, outputfile::AbstractString; kwargs...)
    open(outputfile, "w") do io
        generate(spec::Dict{String,Any}, io)
    end
end

function generate(spec::Dict{String,Any}, io::IO; kwargs...)
    wrap_module(io, spec; kwargs...) do io, spec
        gen_command(io, spec)

        subcommands = get(spec, "subcommands", Dict{String,Any}())
        for subcommand in subcommands
            gen_command(io, subcommand; parent=spec["name"])
        end
    end
end
