# Definition and constructors
mutable struct RidgeRegression <: LinearRidgeModel
    w::Array{Float64}
    λ::Float64
end
RidgeRegression(λ::T) where {T<:Real} = RidgeRegression([0], convert(Float64, λ))

# Design matrix for RidgeRegression
function _design_matrix(model::RidgeRegression, x::Array{T}) where {T<:Real}
    return addphizero(x)
end