# Definition and constuctors
mutable struct Gaussian{T<:Real}
    mu::T
    std::T
    function Gaussian{T}(mu, std) where {T<:Real}
        if std < 0
            error("Standard deviation must be 0 or larger.")
        end
        new(mu, std)
    end
end

function Gaussian(mu::Real, std::Real)
    args = promote(mu, std)
    return Gaussian{typeof(args[1])}(args...)
end


# Sampling
function sample(dist::Gaussian, N::Integer=1)
    results = []
    for i in 1:div(N, 2)
        x0, x1 = dist.mu .+ dist.std.*box_muller()
        push!(results, x0)
        push!(results, x1)
    end
    if N%2 == 1
        z, _ = box_muller()
        x = dist.mu + dist.std*z
        push!(results, x)
    end
    return results
end

function box_muller()
    u1, u2 = rand(2)
    z0 = sqrt(-2*log(u1)) * cos(2*pi*u2)
    z1 = sqrt(-2*log(u1)) * sin(2*pi*u2)
    return z0, z1
end


# Densities (cdf does not have a closed form solution)
function pdf(dist::Gaussian, x::Real) 
    coeff = sqrt(1 / (2 * pi * dist.std^2))
    return coeff * exp(-(x-dist.mu)^2/(2*dist.std^2))
end


# Statistics
expectation(dist::Gaussian) = dist.mu
variance(dist::Gaussian) = dist.std^2


