# Definition & constuctors
mutable struct Bernoulli{T<:Real}
    mu::T
    function Bernoulli{T}(mu::T) where {T<:Real}
        if zero(mu) <= mu <= one(mu)
            new(mu)
        else
            error("Invalid parameter mu: μ ∈ [0,1] required.")
        end
    end
end


Bernoulli(mu::T) where {T<:Real} = Bernoulli{T}(mu)


# Sampling
sample(dist::Bernoulli) = rand() <= dist.mu ? 1 : 0


# Densities
function pdf(dist::Bernoulli, x::Real)
    if x == one(x)
        return dist.mu
    elseif x == zero(x)
        return 1-dist.mu
    end
    error("The PMF of the Bernoulli distribution is only defined for x ∈ {0, 1}")
end


function cdf(dist::Bernoulli, x::Real)
    if x < zero(x)
        return zero(x)
    elseif x < one(x)
        return 1-dist.mu
    else
        return 1
    end
end


# Statistics
mean(dist::Bernoulli) = dist.mu
variance(dist::Bernoulli) = dist.mu*(1-dist.mu)


# Fitting
function mle(::Type{T}, x::AbstractVector{Q}) where {T<:Bernoulli} where {Q<:Real}
    ones = count((i -> i==1), x)
    zeros = count((i -> i==0), x)
    if ones + zeros != length(x)
        error("Argument x may only contain ones and zeros; The PMF of the Bernoulli distribution is only defined for x ∈ {0, 1}.")
    end
    return Bernoulli(ones/length(x))
end
