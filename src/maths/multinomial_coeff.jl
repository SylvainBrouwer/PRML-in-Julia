# Calculate multinomial coefficiënt
function multinomial(trials::Integer, groups::AbstractVector{T}) where {T<:Integer}
    if sum(groups) == trials
        numerator = factorial(trials)
        denominator = prod(factorial.(groups))
        return numerator/denominator
    end
    error("The group counts must add up to the number of trials.")
end