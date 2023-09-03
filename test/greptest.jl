include("grep.jl")

outbuf = IOBuffer()
ctx = CLI.CommandLine((f)->f("grep"), Dict{Symbol,Any}(), Dict{Symbol,Any}(:stdout=>outbuf, :stderr=>outbuf))
CLI.grep(ctx, "CLI", "greptest.jl"; ignore_case=true, count=true)
output = strip(String(take!(outbuf)))
if output != "2"
    error("expected output to be 2, got $output")
end
