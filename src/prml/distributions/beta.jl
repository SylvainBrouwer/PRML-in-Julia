# Definition and constuctors
mutable struct Beta{T<:Real}
    a::T
    b::T
    function Beta{T}(a, b) where {T<:Real}
        if a <= 0 || b <= 0
            error("Invalid parameter: a > 0, b > 0 required.")
        end 
        new(a, b)
    end
end

function Beta(a::Real, b::Real)
    args = promote(a, b)
    Beta{typeof(args[1])}(args...)
end


# Statistics
mean(dist::Beta) = dist.a / (dist.a + dist.b)
function variance(dist::Beta) 
    a, b = dist.a, dist.b
    return (a * b) / ((a + b)^2 * (a + b + 1))
end


# Sample
# TODO: Own implementation of inverse cdf, skipping for now as PRML doesn't address it
function sample(dist::Beta)
    x = rand()
    return beta_inc_inv(dist.a, dist.b, x)[1]
end

# Densities
function pdf(dist::Beta, x::Real)
    if 0 <= x <= 1
        a = dist.a
        b = dist.b
        coeff_norm = gamma(a + b)/(gamma(a)*gamma(b))
        return coeff_norm * x^(a-1) * (1-x)^(b-1)
    end
    error("The pdf of the Beta distribution is only defined on x ∈ [0, 1].")
end

# TODO: Own implementation of Beta cdf, skipping for now as PRML doesn't address it
function cdf(dist::Beta, x::Real)
    return beta_inc(dist.a, dist.b, x)[1]
end


# Bayesian calibration
function calibrate(prior::Beta, data::Vector{T}) where {T<:Real}
    ones = count(x -> x==1, data)
    zeros = count(x -> x==0, data)
    if ones + zeros != length(data)
        error("Argument data may only contain ones and zeros")
    end
    return Beta(prior.a+ones, prior.b+zeros)
end


function calibrate(prior::Beta, likelihood::Binomial)
    exp_succ = mean(likelihood)
    return Beta(prior.a + exp_succ, prior.b + (likelihood.N- exp_succ))
end