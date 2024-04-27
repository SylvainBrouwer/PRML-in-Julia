# Definition and constructors
mutable struct MultivariateGaussian{T<:Real}
    mu::Vector{T}
    Σ::Matrix{T}
    function MultivariateGaussian{T}(mu, Σ) where {T<:Real}
        if length(mu) != size(Σ)[1]
            error("Dimensions of vector μ and covariance matrix Σ do not line up.")
        end
        new(mu, Σ)
    end
end

function MultivariateGaussian(mu::Vector{T}, Σ::Matrix{T}) where {T<:Real}
    return MultivariateGaussian{T}(mu, Σ)
end


# Sampling TODO: look at cholesky
function sample(dist::MultivariateGaussian)
    normal = Gaussian(0, 1)
    u = sample(normal, 2) 
    L = Matrix(cholesky(dist.Σ).L)
    return L*u+dist.mu
end


# Densities
function pdf(dist::MultivariateGaussian, x::Vector{T}) where {T<:Real}
    if length(x) != length(dist.mu)
        error("Dimensionality of input x does not match the dimensionality of the distribution.")
    end
    coeff = 1 / sqrt(
        (2*pi)^_dimensionality(dist) * det(dist.Σ)
        )
    exponent_term = exp(
        -(transpose(x - dist.mu) * inv(dist.Σ) * (x-dist.mu)) / 2
    ) 
    return coeff * exponent_term
end


# Statistics
expectation(dist::MultivariateGaussian) = dist.mu
variance(dist::MultivariateGaussian) = dist.Σ
_dimensionality(dist::MultivariateGaussian) = length(dist.mu)