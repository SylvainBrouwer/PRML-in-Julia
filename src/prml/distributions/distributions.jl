module distributions

# Inclusion for import TODO: Find out how this should be done neatly.
include("../../maths/sylvainsmaths.jl")
import Distributions         #We only cover distributions Bishop covers, we may thus need this at some points.
using SpecialFunctions
using LinearAlgebra
using .SylvainsMaths


# Inclusion for export
include("bernoulli.jl")
include("binomial.jl")
include("beta.jl")
include("categorical.jl")
include("multinomial.jl")
include("dirichlet.jl")
include("gaussian.jl")
include("multivariate_gaussian.jl")


export
    #Structs
    Bernoulli,
    Binomial,
    Beta,
    Categorical,
    Multinomial,
    Dirichlet,
    Gaussian,
    MultivariateGaussian,

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