using LinearAlgebra

# Calculate the approximate Moore-Penrose inverse of a matrix
function pseudoinv(A::Array{T}) where {T<:Real}
    A = Float64.(A)
    U, S, V = svd(A)
    ϵ = eps(Float64)
    θ = ϵ * maximum(S)
    S_inv = map(x -> x > θ ? 1/x : 0, S)
    A_pinv = V*Diagonal(S_inv)*transpose(U)
    return A_pinv
end