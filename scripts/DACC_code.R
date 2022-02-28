DACC <- function(Pref_M, Pref_W, Phi) {
  M <- dim(Pref_M)[1]
  W <- dim(Pref_M)[2]
  Mu <- matrix(rep(0L, M * W), nrow = M, ncol = W)
  CC <- c()
  Budget_M <- matrix(rep(1L, M * W), nrow = M, ncol = W) # Budget_M[m,w] == 1 if w is in m's budget set
  Budget_W <- matrix(rep(1L, M * W), nrow = W, ncol = M) # Budget_W[w,m] == 1 if m is in w's budget set
  A_M <- matrix(rep(0L, M * W), nrow = M, ncol = W) # A_M[m,w] == 1 if w has applied to m
  A_W <- matrix(rep(0L, M * W), nrow = W, ncol = M) # A_W[w,m] == 1 if m has applied to w
  k <- 1 # tracks round number
  t <- 1 # tracks time
  
  # stop criterion
  # v1_M gives ranking of current match
  # v2_M gives ranking of best woman in budget set
  # if there is no man with a woman in budget set with higher rank than current match, stop
  # likewise for women
  v1_M <- apply(Mu * Pref_M, 1, function(x) if (sum(x) == 0) 2 * M * W else sum(x))
  v2_M <- apply(Pref_M * Budget_M, 1, function(x) if (sum(x) == 0) 2 * M * W else min(x[x != 0]))
  v1_W <- apply(t(Mu) * Pref_W, 1, function(x) if (sum(x) == 0) 2 * M * W else sum(x))
  v2_W <- apply(Pref_W * Budget_W, 1, function(x) if (sum(x) == 0) 2 * M * W else min(x[x != 0]))
  
  while (max(v1_M - v2_M) > 0 || max(v1_W - v2_W) > 0) {
    if (length(CC) == 0) {
      i <- Phi[k]
      update <- applies(i, Pref_M, Pref_W, Budget_M, Budget_W, A_M, A_W, CC, Mu)
      Budget_M <- update[[1]]
      Budget_W <- update[[2]]
      A_M <- update[[3]]
      A_W <- update[[4]]
      CC <- update[[5]]
      Mu <- update[[6]]
      k <- k + 1
    } else {
      i <- CC[[1]]
      update <- applies(i, Pref_M, Pref_W, Budget_M, Budget_W, A_M, A_W, CC, Mu)
      Budget_M <- update[[1]]
      Budget_W <- update[[2]]
      A_M <- update[[3]]
      A_W <- update[[4]]
      CC <- update[[5]]
      Mu <- update[[6]]
      if (i > 0) { # i is male
        if (sum(Mu[i,]) > 0 || sum(Budget_M[i,] == 0)) {
          CC <- CC[-1]
        }
      } else { # i is female
        if (sum(Mu[,abs(i)]) > 0 || sum(Budget_W[abs(i),] == 0)) {
          CC <- CC[-1]
        }
      }
    }
    # update stop criterion variables
    v1_M <- apply(Mu * Pref_M, 1, function(x) if (sum(x) == 0) 2 * M * W else sum(x))
    v2_M <- apply(Pref_M * Budget_M, 1, function(x) if (sum(x) == 0) 2 * M * W else min(x[x != 0]))
    v1_W <- apply(t(Mu) * Pref_W, 1, function(x) if (sum(x) == 0) 2 * M * W else sum(x))
    v2_W <- apply(Pref_W * Budget_W, 1, function(x) if (sum(x) == 0) 2 * M * W else min(x[x != 0]))
    t <- t + 1
  }
  return(Mu)
}