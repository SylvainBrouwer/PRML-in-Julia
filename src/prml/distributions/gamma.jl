# Definition and constructors
mutable struct Gamma{T<:Real}
    a::T
    b::T
    function Gamma{T}(a, b) where {T<:Real}
        if a <= 0 || b <= 0
            error("Invalid parameter: a > 0 and b > 0 required.")
        end
        new(a, b)
    end
end

function Gamma(a::Real, b::Real)
    args = promote(a, b)
    return Gamma{typeof(args[1])}(args...)
end

# Sampling
# TODO: implement own sampling -> Marsaglia-Tsang (Bishop does not cover this)
sample(dist::Gamma) = rand(Distributions.Gamma(dist.a, 1/dist.b))


# Densities
function pdf(dist::Gamma, lambda::Real)
    if lambda > 0
        return (1 / gamma(dist.a)) * (dist.b^dist.a) * (lambda^(dist.a-1)) * exp(-dist.b*lambda)
    end
    error("Invalid parameter: λ>0 required.")
end


# Statistics
expectation(dist::Gamma) = dist.a / dist.b
variance(dist::Gamma) = dist.a / (dist.b^2)


# Bayesian calibration
function calibrate(prior::Gamma, x::AbstractVector)
    N = length(x)
    likelihood = mle(Gaussian, x)
    a_n = prior.a + (N/2)
    b_n = prior.b + (N/2) * variance(likelihood)
    return Gamma(a_n, b_n)
end
