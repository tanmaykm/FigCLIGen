include("grep.jl")

outbuf_stdout = IOBuffer()
outbuf_stderr = IOBuffer()

ctx = CLI.CommandLine(; exec = (f)->f("grep"))
ctx.pipelineopts[:stdout] = outbuf_stdout
ctx.pipelineopts[:stderr] = outbuf_stderr

CLI.grep(ctx, "CLI", "greptest.jl"; ignore_case=true, count=true)

output = strip(string(strip(String(take!(outbuf_stderr))), strip(String(take!(outbuf_stdout)))))
if output != "2"
    error("expected output to be 2, got $output")
end