library(hitandrun)

# alternative packages to use?
# library(lpSolve)
# https://cran.r-project.org/web/packages/rcdd/vignettes/vinny.pdf
# https://github.com/thiloklein/matchingMarkets

pref_M <- preflists[[1]][[1]][,,1]
pref_W <- preflists[[2]][[1]][,,1]
M <- dim(pref_M)[1]; W <- dim(pref_M)[2]
# We will represent the matching matrix as a vector x:
# The first W elements of x represent the first row of the matching matrix,
# elements W + 1 to 2W represent the second row of the matching matrix,
# ...
# elements (M - 1)*W + 1 to M*W represent the last row of the matching matrix.


?findVertices

# there are M*W variables
# there are M + W + 2*M*W constraints
A <- matrix(rep(0, (M*W)*(M + W + 2*M*W)), nrow = M + W + 2*M*W, ncol = M*W)

# constraint (1) LHS var coefficients
for (i in 1:M){
  A[i, ((i - 1)*W + 1):(i*W)] <- 1
}
# constraint (2) LHS var coefficients
for (w in 1:W){
  for (k in 1:M){
    A[w + M, (k - 1)*W + w] <- 1
  }
}
# constraint (3) LHS var coefficients
for (i in 1:(M*W)) {
  A[i + M + W, i] <- -1
}
# constraint (4) LHS var coefficients
for (i in 1:(M*W)) {
  m <- ceiling(i/W)
  w <- ifelse(i%%W == 0, W, i%%W)
  A[i + M + W + M*W, ((m - 1)*W + 1):((m - 1)*W + W)] <- -1*(pref_M[m,] < pref_M[m, w])
  for (j in 1:M) {
    A[i + M + W + M*W, (j - 1)*W + w] <- -1*(pref_W[w, j] < pref_W[w, m])
  }
  A[i + M + W + M*W, (m - 1)*W + w] <- -1
}
# define RHS constants
b <- c(rep(1, M + W), rep(0, M*W), rep(-1,M*W))
# direction of inequalities
d <- rep("<=", M + W + 2*M*W)

# compute vertices
verticies <- findVertices(list(constr=A, rhs=b, dir=d))