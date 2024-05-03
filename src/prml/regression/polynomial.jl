mutable struct PolynomialRegression <: LinearUnregularizedModel
    w::Array{Float64}
    order::Int64
end
PolynomialRegression() = PolynomialRegression([0], 3)


# Create design matrix for PolynomialRegression
function _design_matrix(model::PolynomialRegression, x::Array{T}) where {T<:Real}
    phi = x
    for pow in 2:model.order
        phi = hcat(phi, x.^pow)
    end
    phi = addphizero(phi)
end