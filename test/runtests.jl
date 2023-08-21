using Test
using FigCLIGen

function runtests()
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

@testset "FigCLIGen" begin
    runtests()
end