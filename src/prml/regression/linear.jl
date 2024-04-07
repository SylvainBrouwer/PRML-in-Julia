# Definition and constructors
mutable struct LinearRegression
    w::Vector{Float64}
end
LinearRegression() = LinearRegression([0])


# Fit regressor
function fit!(model::LinearRegression, x::AbstractArray, t::AbstractVector)
    phi = addphizero(x)
    model.w = pseudoinv(phi)*t
end


# Predict for array of data points
function predict(model::LinearRegression, x::AbstractArray)
    phi = addphizero(x)
    return phi*model.w
end