mutable struct PolynomialRegression
    w::Array(Float64)
    order::Int64
end
PolynomialRegression() = PolynomialRegression([0], 3)



# TODO: Implement Polynomial Regression
function fit!(model::PolynomialRegression, x::Array{Float64}, t::Array{Float64})
    
end