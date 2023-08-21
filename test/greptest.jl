include("grep.jl")

cmd = CLI.grep(CLI.grep(); ignore_case=true, count=true)
outbuf = IOBuffer()
run(pipeline(`$cmd CLI greptest.jl`; stdout=outbuf, stderr=outbuf))
output = strip(String(take!(outbuf)))
if output != "2"
    error("expected output to be 2, got $output")
end
