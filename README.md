# FigCLIGen

Generate Julia code that provide functions to run CLI programs.

The specification to generate this code is similar to what [Fig](https://fig.io/) uses, but in JSON format. So for popular CLIs, a starting point can be the spec found in the [Fig autocomplete repo](https://github.com/withfig/autocomplete). Remember to convert from `js` to `json` format.

An example that generates a CLI for `grep` is included:
- `grep` [specs](test/specs/grep.json)
- `grep` [generated code](examples/grep.jl)
- `grep` [example use of generated code](test/greptest.jl)

A more complex spec is that of Open Policy Agent:
- `opa` [specs](test/specs/opa.json)
- `opa` [generated code](examples/opa.jl)