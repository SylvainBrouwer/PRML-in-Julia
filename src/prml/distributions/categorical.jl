# Definition and constructors
mutable struct Categorical{T<:Real}
    mu::Vector{T}
    Categorical{T}(mu) where {T<:Real} = sum(mu) == one(T) ? new{T}(mu) : error("Invalid parameter: Σμ must add up to 1.") 
end

Categorical(mu::Vector{T}) where {T<:Real} = Categorical{T}(mu)


# Sampling
function sample(dist::Categorical)
    x = rand()
    n_cat = length(dist.mu)
    out = zeros(Int64, n_cat)
    for i in 0:n_cat
        x <= cdf(dist, i) ? (out[i] = 1; break) : continue
    end
    return out
end


# Densities
function pdf(dist::Categorical, x::AbstractVector{T}) where {T<:Real}
    ones = count(z -> z == 1, x)
    if size(x) != size(dist.mu) || !(ones == 1 && sum(x) == 1)
        error("Invalid parameter: x must be a one-hot encoded vector matching the size of dist.mu.")
    end
    return sum(x.*dist.mu)
end
pdf(dist::Categorical, x::Integer) = 0 < x <= length(dist.mu) ? dist.mu[x] : error("Invalid parameter: x must be a valid index for dist.mu.")


function cdf(dist::Categorical, x::Real)
    x = convert(Int64, floor(x))
    #Bishop 1-indexes the categorical dist
    if x < 1
        return 0
    end
    return sum(dist.mu[1:x])
end


# Statistics
expectation(dist::Categorical) = dist.mu
mode(dist::Categorical) = argmax(dist.mu)


# Fitting
function mle(::Type{T}, x::AbstractVector) where {T<:Categorical}
    cats = unique(x)
    N_cats = length(cats)
    N = length(x)
    mu = zeros(Rational, N_cats)
    for i in 1:N_cats
        freq = count(z -> z == cats[i], x)
        mu[i] = freq//N
    end
    return Categorical(mu), cats
end
