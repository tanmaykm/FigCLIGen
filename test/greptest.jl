include("grep.jl")

outbuf = IOBuffer()

ctx = CLI.CommandLine(; exec = (f)->f("grep"))
ctx.pipelineopts[:stdout] = outbuf
ctx.pipelineopts[:stderr] = outbuf

CLI.grep(ctx, "CLI", "greptest.jl"; ignore_case=true, count=true)

output = strip(String(take!(outbuf)))
if output != "2"
    error("expected output to be 2, got $output")
end
