module distributions

using SpecialFunctions

include("bernoulli.jl")
include("binomial.jl")
include("beta.jl")


export
    #Structs
    Bernoulli,
    Binomial,
    Beta,

    #Functions
    pdf,
    cdf,
    mle,
    fit,
    mean,
    variance,
    sample,
    calibrate



end