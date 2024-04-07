addphizero(x::Array{Float64}) = hcat(ones(size(x)[1]), x)


include("linear.jl")
include("ridge.jl")