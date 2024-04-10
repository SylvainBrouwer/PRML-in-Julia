module distributions

# Inclusion for import TODO: Find out how this should be done neatly.
include("../../maths/sylvainsmaths.jl")
using SpecialFunctions
using .SylvainsMaths


# Inclusion for export
include("bernoulli.jl")
include("binomial.jl")
include("beta.jl")
include("categorical.jl")
include("multinomial.jl")


export
    #Structs
    Bernoulli,
    Binomial,
    Beta,
    Categorical,
    Multinomial,

    #Functions
    pdf,
    cdf,
    mle,
    fit,
    mean,
    expectation,
    variance,
    mode,
    sample,
    calibrate



end