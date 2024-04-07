# Definition and constructors
mutable struct RidgeRegression
    w::Array{Float64}
    λ::Float64
end
RidgeRegression(λ::T) where {T<:Real} = RidgeRegression([0], convert(Float64, λ))


# Fit regressor, closed form solution
function fit!(model::RidgeRegression, x::AbstractArray, t::AbstractArray)
    phi = addphizero(x)
    model.w = inv(model.λ*I+transpose(phi)*phi)*transpose(phi)*t
end


# Predit for array of data points
function predict(model::RidgeRegression, x::AbstractArray)
    phi = addphizero(x)
    return phi*model.w
end