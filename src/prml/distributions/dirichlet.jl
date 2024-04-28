# Definition and constuctors
mutable struct Dirichlet{T<:Real}
    a::Vector{T}
    function Dirichlet{T}(a) where {T<:Real}
        if !all(x -> x > 0, a)
            error("All parameters αₖ of a Dirichlet distribution must be larger than 0.")
        end
        new(a)
    end
end

Dirichlet(a::Vector{T}) where {T<:Real} = Dirichlet{T}(a)


# Sampling
# TODO: use own gamma
function sample(dist::Dirichlet)
    gammas = []
    for α in dist.a
        g = Distributions.Gamma(α)
        push!(gammas, rand(g))
    end
    return gammas./sum(gammas)
end


# Densities (Bishop does not cover a cdf)
function pdf(dist::Dirichlet, x::AbstractVector{T}) where {T<:Real}
    if length(x) != length(dist.a) 
        error("Dimension of input vector x must match dimension of distribution parameters.") 
    end
    if sum(x) != one(T) || !all(x -> (0 <= x <= 1), x)
        error("Vector x must be a valid distribution: Σx=1 and ∀x 0 <= x <= 1 required.")
    end
    
    a_0 = sum(dist.a)
    coeff_norm = gamma(a_0)/prod(gamma.(dist.a))
    return coeff_norm * prod(x.^(dist.a.-1))
end


# Statistics
mean(dist::Dirichlet) = dist.a./sum(dist.a)
function variance(dist::Dirichlet)
    a_0 = sum(dist.a)
    a_tilde = dist.a./a_0
    return @. (a_tilde*(1-a_tilde))/(a_0+1)
end


# Bayesian calibration
function calibrate(prior::Dirichlet, likelihood::Multinomial)
    if length(prior.a) == length(likelihood.mu)
        coeffs = prior.a + expectation(likelihood)
        return Dirichlet(coeffs)
    end
    error("Dimensions of prior and likelihood do not match.")
end