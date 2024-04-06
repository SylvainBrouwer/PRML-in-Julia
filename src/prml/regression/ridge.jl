mutable struct RidgeRegression
    w::Array{Float64}
    λ::Float64
end
RidgeRegression(λ::T) where {T<:Real} = RidgeRegression([0], convert(Float64, λ))


function fit!(model::RidgeRegression, x::Array{Float64}, t::Array{Float64})
    phi = addphizero(x)
    model.w = inv(model.λ*I+transpose(phi)*phi)*transpose(phi)*t
end


function predict(model::RidgeRegression, x)
    phi = addphizero(x)
    return phi*model.w
end