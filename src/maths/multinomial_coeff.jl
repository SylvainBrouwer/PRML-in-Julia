# Calculate multinomial coefficiënt
function multinomial(trials::Integer, groups::AbstractVector{T}) where {T<:Integer}
    numerator = factorial(trials)
    denominator = prod(factorial.(groups))
    return numerator/denominator
end