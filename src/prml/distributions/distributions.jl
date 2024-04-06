module distributions

include("bernoulli.jl")
include("binomial.jl")


export
    #Structs
    Bernoulli,
    Binomial,

    #Functions
    pdf,
    cdf,
    mle,
    fit,
    sample



end