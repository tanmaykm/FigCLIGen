using Test
using FigCLIGen

function rungen()
    mktempdir() do tmpdir
        for file in readdir(joinpath(@__DIR__, "specs"))
            if endswith(file, ".json")
                testname = replace(file, ".json" => "")
                specfile = joinpath(@__DIR__, "specs", file)
                outputfile = joinpath(tmpdir, testname * ".jl")
                @info("testing", specfile, outputfile)

                @eval @testset $testname begin
                    FigCLIGen.generate($specfile, $outputfile)
                    @test isfile($outputfile)
                end
            end
        end
    end
end

function test_grep()
    mktempdir() do tmpdir
        specfile = joinpath(@__DIR__, "specs", "grep.json")
        outputfile = joinpath(tmpdir, "grep.jl")
        FigCLIGen.generate(specfile, outputfile)
        @test isfile(outputfile)

        cp(joinpath(@__DIR__, "greptest.jl"), joinpath(tmpdir, "greptest.jl"))
        cd(tmpdir) do
            proc = run(`julia greptest.jl`)
            @test proc.exitcode == 0
        end
    end
end

@testset "FigCLIGen" begin
    rungen()

    # run test_grep only on Linux
    if Sys.islinux()
        test_grep()
    end
end