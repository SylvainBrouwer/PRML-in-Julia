addphizero(x::Array{Float64}) = hcat(ones(size(x)[1]), x)


# Inclusion for import TODO: Find out how this should be done neatly.
include("../../maths/sylvainsmaths.jl")
using .SylvainsMaths


# Inclusion for export
include("linear.jl")
include("ridge.jl")


# TODO: Make a module 