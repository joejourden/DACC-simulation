generate_data <- function(M, W) {
prefarrayM <- array(dim = c(M, W, 30))
prefarrayW <- array(dim = c(W, M, 30))
  for (i in 1:30){
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
    pref_M <- matrix(nrow = M, ncol = W)
    for(m in 1:M){
      for(w in 1:W){
        pref_M[m,w] <- which(order(U_M[m,]) == w)
      }
    }
    # Women's preference matrix
    # the (w,m) entry is woman w's ranking of man m
    pref_W <- matrix(nrow = W, ncol = M)
    for(w in 1:W){
      for(m in 1:M){
        pref_W[w,m] <- which(order(U_W[w,]) == m)
      }
    }
    prefarrayM[,,i] <- pref_M
    prefarrayW[,,i] <- pref_W
  }
  return(list(prefarrayM, prefarrayW))
}