abstract type GeneralizedLinearModel end
abstract type LinearUnregularizedModel <: GeneralizedLinearModel end
abstract type LinearRidgeModel <: GeneralizedLinearModel end

include("linear.jl")
include("ridge.jl")
include("polynomial.jl")


# Add "dummy" basis function for bias
addphizero(x::Array{Float64}) = hcat(ones(size(x)[1]), x)


# General
function predict(model::GeneralizedLinearModel, x::Array{T}) where {T<:Real}
    phi = _design_matrix(model, x)
    return phi * model.w
end


# Non-regularized models
function fit!(model::LinearUnregularizedModel, x::Array{T}, t::Array{Q}) where {T<:Real, Q<:Real}
    phi = _design_matrix(model, x)
    model.w = pseudoinv(phi) * t
end


# Ridge models
function fit!(model::LinearRidgeModel, x::Array{T}, t::Array{Q}) where {T<:Real, Q<:Real}
    phi = _design_matrix(model, x)
    model.w =  inv(model.λ * I + transpose(phi) * phi) * transpose(phi) * t
end