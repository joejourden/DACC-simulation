# DA example
M_in <- 15
W_in <- 8
P_in <- sample(1:W_in)
for (i in 1:(M_in - 1)) {
  P_in <- rbind(P_in, sample(1:W_in))
}

# test DA
DA_M(M_in, W_in, P_in, R_in)
DA_W(M_in, W_in, P_in, R_in)

# DACC example
M <- 60
W <- 100
Pref_M <- sample(1:W)
for (i in 1:(M - 1)) {
  Pref_M <- rbind(Pref_M, sample(1:W))
}
Pref_W <- sample(1:M)
for (i in 1:(W - 1)) {
  Pref_W <- rbind(Pref_W, sample(1:M))
}
Phi <- sample(c(1:M,-1:-W), 50 * M * W, replace = T)

# Pref_M <- matrix(as.integer(c(1,2,3,3,1,2,2,3,1)), nrow = 3, byrow = T)
# Pref_W <- matrix(as.integer(c(3,1,2,2,3,1,1,2,3)), nrow = 3, byrow = T)
# Phi <- sample(c(1:3,-1:-3), 200, replace = T)

DA_M(Pref_M, Pref_W)
DA_W(Pref_M, Pref_W)
DACC(Pref_M, Pref_W, Phi)



Mu <- matrix(rep(0L, M * W), nrow = M, ncol = W)
CC <- c()
Budget_M <- matrix(rep(1L, M * W), nrow = M, ncol = W)
Budget_W <- matrix(rep(1L, M * W), nrow = W, ncol = M)
A_M <- matrix(rep(0L, M * W), nrow = M, ncol = W)
A_W <- matrix(rep(0L, M * W), nrow = W, ncol = M)

A_M; A_W; Budget_M; Budget_W; Mu
typeof(A_M); typeof(A_W); typeof(Budget_M); typeof(Budget_W); typeof(Mu)



