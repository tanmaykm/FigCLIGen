"""
CLI for grep.
Matches patterns in input text. Supports simple patterns and regular expressions

Generated via @__MODULE__. Do not edit directly.
Edit the specification file and run the generator instead.
"""
module CLI

const OptsType = Base.Dict{Base.Symbol,Base.Any}

"""
CommandLine execution context.

`exec`: a no argument function that provides the base command to execute in a julia `do` block.
`cmdopts`: keyword arguments that should be used to further customize the `Cmd` creation
`pipelineopts`: keyword arguments that should be used to further customize the `pipeline` creation
"""
Base.@kwdef struct CommandLine
    exec::Base.Function = (f) -> f("grep")
    cmdopts::OptsType = OptsType()
    pipelineopts::OptsType = OptsType()
    runopts::OptsType = OptsType()
end

""" grep
Run the grep command.
Matches patterns in input text. Supports simple patterns and regular expressions

Options:
- help::Bool - Print a usage message briefly summarizing these command-line options and the bug-reporting address, then exit
- extended_regexp::Bool - Interpret PATTERN as an extended regular expression (-E is specified by POSIX.)
- fixed_string::Bool - Interpret PATTERN as a list of fixed strings, separated by newlines, any of which is to be matched. (-F is specified by POSIX.)
- basic_regexp::Bool - Interpret PATTERN as a basic regular expression (BRE, see below). This is the default
- regexp::AbstractString - Use PATTERN as the pattern. This can be used to specify multiple search patterns, or to protect a pattern beginning with a hyphen (-). (-e is specified by POSIX.)
- ignore_case::Bool - Ignore case distinctions in both the PATTERN and the input files. (-i is specified by POSIX.)
- invert_match::Bool - Invert the sense of matching, to select non-matching lines. (-v is specified by POSIX.)
- word_regexp::Bool - Select only those lines containing matches that form whole words. The test is that the matching substring must either be at the beginning of the line, or preceded by a non-word constituent character. Similarly, it must be either at the end of the line or followed by a non-word constituent character. Word-constituent characters are letters, digits, and the underscore
- line_regexp::Bool - Select only those matches that exactly match the whole line. (-x is specified by POSIX.)
- count::Bool - Suppress normal output; instead print a count of matching lines for each input file. With the -v, --invert-match option, count non-matching lines. (-c is specified by POSIX.)
- color::AbstractString - Surround the matched (non-empty) strings, matching lines, context lines, file names, line numbers, byte offsets, and separators (for fields and groups of context lines) with escape sequences to display them in color on the terminal. The colors are defined by the environment variable GREP_COLORS. The deprecated environment variable GREP_COLOR is still supported, but its setting does not have priority
- files_without_match::Bool - Suppress normal output; instead print the name of each input file from which no output would normally have been printed. The scanning will stop on the first match
- files_with_matches::Bool - Suppress normal output; instead print the name of each input file from which output would normally have been printed. The scanning will stop on the first match. (-l is specified by POSIX.)
- max_count::AbstractString - Stop reading a file after NUM matching lines. If the input is standard input from a regular file, and NUM matching lines are output, grep ensures that the standard input is positioned to just after the last matching line before exiting, regardless of the presence of trailing context lines. This enables a calling process to resume a search. When grep stops after NUM matching lines, it outputs any trailing context lines. When the -c or --count option is also used, grep does not output a count greater than NUM. When the -v or --invert-match option is also used, grep stops after outputting NUM non-matching lines
- only_matching::Bool - Print only the matched (non-empty) parts of a matching line, with each such part on a separate output line
- quiet::Bool - Quiet; do not write anything to standard output. Exit immediately with zero status if any match is found, even if an error was detected. Also see the -s or --no-messages option. (-q is specified by POSIX.)
- no_messages::Bool - Suppress error messages about nonexistent or unreadable files. Portability note: unlike GNU grep, 7th Edition Unix grep did not conform to POSIX, because it lacked -q and its -s option behaved like GNU grep's -q option. USG -style grep also lacked -q but its -s option behaved like GNU grep. Portable shell scripts should avoid both -q and -s and should redirect standard and error output to /dev/null instead. (-s is specified by POSIX.)
- byte_offset::Bool - Print the 0-based byte offset within the input file before each line of output. If -o (--only-matching) is specified, print the offset of the matching part itself
- with_filename::Bool - Print the file name for each match. This is the default when there is more than one file to search
- no_filename::Bool - Suppress the prefixing of file names on output. This is the default when there is only one file (or only standard input) to search
- label::AbstractString - Display input actually coming from standard input as input coming from file LABEL. This is especially useful when implementing tools like zgrep, e.g., gzip -cd foo.gz | grep --label=foo -H something
- line_number::Bool - Prefix each line of output with the 1-based line number within its input file. (-n is specified by POSIX.)
- initial_tab::Bool - Make sure that the first character of actual line content lies on a tab stop, so that the alignment of tabs looks normal. This is useful with options that prefix their output to the actual content: -H,-n, and -b. In order to improve the probability that lines from a single file will all start at the same column, this also causes the line number and byte offset (if present) to be printed in a minimum size field width
- unix_byte_offsets::Bool - Report Unix-style byte offsets. This switch causes grep to report byte offsets as if the file were a Unix-style text file, i.e., with CR characters stripped off. This will produce results identical to running grep on a Unix machine. This option has no effect unless -b option is also used; it has no effect on platforms other than MS-DOS and MS -Windows
- null::Bool - Output a zero byte (the ASCII NUL character) instead of the character that normally follows a file name. For example, grep -lZ outputs a zero byte after each file name instead of the usual newline. This option makes the output unambiguous, even in the presence of file names containing unusual characters like newlines. This option can be used with commands like find -print0, perl -0, sort -z, and xargs -0 to process arbitrary file names, even those that contain newline characters
- after_context::AbstractString - Print num lines of trailing context after each match
- before_context::AbstractString - Print num lines of leading context before each match. See also the -A and -C options
- context::AbstractString - Print NUM lines of output context. Places a line containing a group separator (--) between contiguous groups of matches. With the -o or --only-matching option, this has no effect and a warning is given
- text::Bool - Treat all files as ASCII text. Normally grep will simply print ``Binary file ... matches'' if files contain binary characters. Use of this option forces grep to output lines matching the specified pattern
- binary_files::AbstractString - Controls searching and printing of binary files
- devices::AbstractString - Specify the demanded action for devices, FIFOs and sockets
- directories::AbstractString - Specify the demanded action for directories
- exclude::AbstractString - Note that --exclude patterns take priority over --include patterns, and if no --include pattern is specified, all files are searched that are not excluded. Patterns are matched to the full path specified, not only to the filename component
- exclude_dir::AbstractString - If -R is specified, only directories matching the given filename pattern are searched.  Note that --exclude-dir patterns take priority over --include-dir patterns
- I::Bool - Ignore binary files. This option is equivalent to --binary-file=without-match option
- include::AbstractString - If specified, only files matching the given filename pattern are searched. Note that --exclude patterns take priority over --include patterns. Patterns are matched to the full path specified, not only to the filename component
- include_dir::AbstractString - If -R is specified, only directories matching the given filename pattern are searched. Note that --exclude-dir patterns take priority over --include-dir patterns
- recursive::Bool - Recursively search subdirectories listed
- line_buffered::Bool - Force output to be line buffered. By default, output is line buffered when standard output is a terminal and block buffered otherwise
- binary::Bool - Search binary files, but do not attempt to print them
- J::Bool - Decompress the bzip2(1) compressed file before looking for the text
- version::Bool - Print version number of grep to the standard output stream
- perl_regexp::Bool - Interpret pattern as a Perl regular expression
- file::AbstractString - Obtain patterns from FILE, one per line. The empty file contains zero patterns, and therefore matches nothing. (-f is specified by POSIX.)
 """
function grep(ctx::CommandLine, _args...; help::Union{Nothing,Bool} = false, extended_regexp::Union{Nothing,Bool} = false, fixed_string::Union{Nothing,Bool} = false, basic_regexp::Union{Nothing,Bool} = false, regexp::Union{Nothing,AbstractString} = nothing, ignore_case::Union{Nothing,Bool} = false, invert_match::Union{Nothing,Bool} = false, word_regexp::Union{Nothing,Bool} = false, line_regexp::Union{Nothing,Bool} = false, count::Union{Nothing,Bool} = false, color::Union{Nothing,AbstractString} = "auto", files_without_match::Union{Nothing,Bool} = false, files_with_matches::Union{Nothing,Bool} = false, max_count::Union{Nothing,AbstractString} = nothing, only_matching::Union{Nothing,Bool} = false, quiet::Union{Nothing,Bool} = false, no_messages::Union{Nothing,Bool} = false, byte_offset::Union{Nothing,Bool} = false, with_filename::Union{Nothing,Bool} = false, no_filename::Union{Nothing,Bool} = false, label::Union{Nothing,AbstractString} = nothing, line_number::Union{Nothing,Bool} = false, initial_tab::Union{Nothing,Bool} = false, unix_byte_offsets::Union{Nothing,Bool} = false, null::Union{Nothing,Bool} = false, after_context::Union{Nothing,AbstractString} = nothing, before_context::Union{Nothing,AbstractString} = nothing, context::Union{Nothing,AbstractString} = nothing, text::Union{Nothing,Bool} = false, binary_files::Union{Nothing,AbstractString} = "binary", devices::Union{Nothing,AbstractString} = "read", directories::Union{Nothing,AbstractString} = "read", exclude::Union{Nothing,AbstractString} = nothing, exclude_dir::Union{Nothing,AbstractString} = nothing, I::Union{Nothing,Bool} = false, include::Union{Nothing,AbstractString} = nothing, include_dir::Union{Nothing,AbstractString} = nothing, recursive::Union{Nothing,Bool} = false, line_buffered::Union{Nothing,Bool} = false, binary::Union{Nothing,Bool} = false, J::Union{Nothing,Bool} = false, version::Union{Nothing,Bool} = false, perl_regexp::Union{Nothing,Bool} = false, file::Union{Nothing,AbstractString} = nothing, )
    ctx.exec() do cmdstr
        cmd = [cmdstr]
        !Base.isnothing(help) && help && Base.push!(cmd, "--help")
        !Base.isnothing(extended_regexp) && extended_regexp && Base.push!(cmd, "--extended-regexp")
        !Base.isnothing(fixed_string) && fixed_string && Base.push!(cmd, "--fixed-string")
        !Base.isnothing(basic_regexp) && basic_regexp && Base.push!(cmd, "--basic-regexp")
        Base.isnothing(regexp) || Base.push!(cmd, "--regexp=$(regexp)")
        !Base.isnothing(ignore_case) && ignore_case && Base.push!(cmd, "--ignore-case")
        !Base.isnothing(invert_match) && invert_match && Base.push!(cmd, "--invert-match")
        !Base.isnothing(word_regexp) && word_regexp && Base.push!(cmd, "--word-regexp")
        !Base.isnothing(line_regexp) && line_regexp && Base.push!(cmd, "--line-regexp")
        !Base.isnothing(count) && count && Base.push!(cmd, "--count")
        Base.isnothing(color) || Base.push!(cmd, "--color=$(color)")
        !Base.isnothing(files_without_match) && files_without_match && Base.push!(cmd, "--files-without-match")
        !Base.isnothing(files_with_matches) && files_with_matches && Base.push!(cmd, "--files-with-matches")
        Base.isnothing(max_count) || Base.push!(cmd, "--max-count=$(max_count)")
        !Base.isnothing(only_matching) && only_matching && Base.push!(cmd, "--only-matching")
        !Base.isnothing(quiet) && quiet && Base.push!(cmd, "--quiet")
        !Base.isnothing(no_messages) && no_messages && Base.push!(cmd, "--no-messages")
        !Base.isnothing(byte_offset) && byte_offset && Base.push!(cmd, "--byte-offset")
        !Base.isnothing(with_filename) && with_filename && Base.push!(cmd, "--with-filename")
        !Base.isnothing(no_filename) && no_filename && Base.push!(cmd, "--no-filename")
        Base.isnothing(label) || Base.push!(cmd, "--label=$(label)")
        !Base.isnothing(line_number) && line_number && Base.push!(cmd, "--line-number")
        !Base.isnothing(initial_tab) && initial_tab && Base.push!(cmd, "--initial-tab")
        !Base.isnothing(unix_byte_offsets) && unix_byte_offsets && Base.push!(cmd, "--unix-byte-offsets")
        !Base.isnothing(null) && null && Base.push!(cmd, "--null")
        Base.isnothing(after_context) || Base.push!(cmd, "--after-context=$(after_context)")
        Base.isnothing(before_context) || Base.push!(cmd, "--before-context=$(before_context)")
        Base.isnothing(context) || Base.push!(cmd, "--context=$(context)")
        !Base.isnothing(text) && text && Base.push!(cmd, "--text")
        Base.isnothing(binary_files) || Base.push!(cmd, "--binary-files=$(binary_files)")
        Base.isnothing(devices) || Base.push!(cmd, "--devices=$(devices)")
        Base.isnothing(directories) || Base.push!(cmd, "--directories=$(directories)")
        Base.isnothing(exclude) || Base.push!(cmd, "--exclude=$(exclude)")
        Base.isnothing(exclude_dir) || Base.push!(cmd, "--exclude-dir=$(exclude_dir)")
        !Base.isnothing(I) && I && Base.push!(cmd, "-I")
        Base.isnothing(include) || Base.push!(cmd, "--include=$(include)")
        Base.isnothing(include_dir) || Base.push!(cmd, "--include-dir=$(include_dir)")
        !Base.isnothing(recursive) && recursive && Base.push!(cmd, "--recursive")
        !Base.isnothing(line_buffered) && line_buffered && Base.push!(cmd, "--line-buffered")
        !Base.isnothing(binary) && binary && Base.push!(cmd, "--binary")
        !Base.isnothing(J) && J && Base.push!(cmd, "-J")
        !Base.isnothing(version) && version && Base.push!(cmd, "--version")
        !Base.isnothing(perl_regexp) && perl_regexp && Base.push!(cmd, "--perl-regexp")
        Base.isnothing(file) || Base.push!(cmd, "--file=$(file)")
        Base.append!(cmd, Base.string.(_args))
        Base.run(Base.pipeline(Base.Cmd(Cmd(cmd); ctx.cmdopts...); ctx.pipelineopts...); ctx.runopts...)
    end
end

end # module CLI

