mutable struct LinearRegression
    w::Vector{Float64}
end
LinearRegression() = LinearRegression([0])

function fit!(model::LinearRegression, x::Array{Float64}, t::Vector{Float64})
    phi = addphizero(x)
    model.w = pseudoinv(phi)*t
end


function predict(model::LinearRegression, x::Array{Float64})
    phi = addphizero(x)
    return phi*model.w
end