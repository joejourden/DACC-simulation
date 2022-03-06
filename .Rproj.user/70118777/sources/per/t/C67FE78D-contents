DA_M <- function(P, R) {
  M <- dim(P)[1]
  W <- dim(P)[2]
  Mu <- matrix(rep(0L, M * W), nrow=M, ncol=W)
  free <- 1:M # unmatched men
  while (length(free) > 0) {
    m <- free[1]
    free <- free[free != m]
    w <- which(P[m,] == min(P[m,][P[m,] != 0]))
    P[m,w] <- 0L
    if (sum(Mu[,w]) == 0) { # if w is free
      Mu[m,w] <- 1L # match m and w
    } else {
      t <- which(Mu[,w] == 1) # w is currently matched to t
      if (R[w,m] < R[w,t]) { # w prefers m
        Mu[m,w] <- 1L
        Mu[t,w] <- 0L
        if (sum(P[t,]) > 0) {
          free <- c(t, free) # t proposes next
        }
      } else { # w prefers t
        if (sum(P[m,]) > 0) {
          free <- c(m, free) # m proposes next
        }
      }
    }
  }
  return(Mu)
}
DA_W <- function(P, R) {
  t(DA_M(R, P))
}