# Definition & constuctors
mutable struct Binomial{T<:Real} 
    mu::T
    N::Integer

    Binomial{T}(mu, N) where {T<:Real} = new{T}(mu, N)
end

#TODO: Implement Binomial dist
Binomial(mu::T, N::Integer) where {T<:Real} = Binomial{T}(mu, N)




#Densities
function pdf(dist::Binomial, x::Real)

end