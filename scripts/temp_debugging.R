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



M <- 5
W <- 6
err <- rlogis(M, location = 0, scale = 1)
for (k in 2:W){
  err <- cbind(err,rlogis(M, location = 0, scale = 1))
}
age_M <- rnorm(M, mean = 26, sd = 2)
income_M <- rnorm(M, mean = 50, sd = 10)
height_M <- rnorm(M, mean = 70.6, sd = 2)
bmi_M <- rnorm(M, mean = 26, sd = 2)
bmi2_M <- bmi_M^2

age_W <- rnorm(W, mean = 25, sd = 2)
income_W <- rnorm(W, mean = 50, sd = 10)
height_W <- rnorm(W, mean = 65, sd = 2)
bmi_W <- rnorm(W, mean = 22.8, sd = 2)
bmi2_W <- bmi_W^2

D_M <- cbind(age_M,income_M,height_M,bmi_M,bmi2_M)
D_W <- cbind(age_W,income_W,height_W,bmi_W,bmi2_W)

beta_M <- as.numeric(c(-0.0598, 0.0053, -0.1421, -0.3962, 0.0043))
beta_W <- as.numeric(c(-0.0098, 0.0164, 0.1831, 0.1332, -0.0007))

# U_M[m,w] is man m's utility from matching with woman w
U_M <- matrix(nrow = M, ncol = W)
for(m in 1:M){
  for(w in 1:W){
    U_M[m,w] = D_W[w,]%*%beta_M + err[m,w]
  }
}
# U_W[w,m] is woman w's utility from matching with man m
U_W <- matrix(nrow = W, ncol = M)
for(w in 1:W){
  for(m in 1:M){
    U_W[w,m] = D_M[m,]%*%beta_W + err[m,w]
  }
}

# Men's preference matrix
# the (m,w) entry is man m's ranking of woman w
pref_M <- t(apply(-U_M, 1, function(x) rank(x, ties.method = "random")))
# Women's preference matrix
# the (w,m) entry is woman w's ranking of man m
pref_W <- t(apply(-U_W, 1, function(x) rank(x, ties.method = "random")))