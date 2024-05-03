# Definition and constructors
mutable struct LinearRegression <: LinearUnregularizedModel
    w::Vector{Float64}
end
LinearRegression() = LinearRegression([0])


# Create design matrix for linear regression
function _design_matrix(model::LinearRegression, x::Array{T}) where {T<:Real}
    return addphizero(x)
end