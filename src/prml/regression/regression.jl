module regression
include("../../maths/sylvainsmaths.jl")
using LinearAlgebra
using .SylvainsMaths


# Inclusion for export
include("regression_base.jl")


export
# Structs
LinearRegression,
RidgeRegression,
PolynomialRegression,

# Functions
fit!,
predict



# FIXME: I'm not very happy with the unregularized / ridge split as implemented right now -> _design_matrix is duplicated
# Maybe go the sklearn route -> "feature" transforms + a single regression object for linear / ridge


end