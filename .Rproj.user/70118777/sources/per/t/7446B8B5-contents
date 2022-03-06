applies <- function(i, Pref_M, Pref_W, Budget_M, Budget_W, A_M, A_W, CC, Mu) {
  if (i > 0) { # i is male
    j <- if (sum(Budget_M[i,]) == 0) 0 else which(Pref_M[i,] == min(Pref_M[i,][Budget_M[i,] != 0]))
    if (j == 0 || Mu[i, j] == 1) { # if i and j are already matched or i has no one to apply to, return
      return(list(Budget_M, Budget_W, A_M, A_W, CC, Mu))
    }
    A_W[j, i] <- 1L
    Budget_W[j, i] <- 1L
    if (sum(Mu[,j]) == 0 || Pref_W[j, i] < Pref_W[j, which(Mu[,j] == 1)]) { # j accepts i's proposal
      if (sum(Mu[i,]) == 1) { # if i was previously matched
        j0 <- which(Mu[i,] == 1)
        CC <- if (A_W[j0, i] == 1) c(-j0, CC) else CC # compensate j0 if i deceived j0
        Budget_W[j0, i] <- 0L
        Mu[i, j0] <- 0L # divorce i and j0
      }
      if (sum(Mu[,j] == 1)) { # if j was previously matched
        i0 <- which(Mu[,j] == 1)
        CC <- if (A_M[i0, j] == 1) c(i0, CC) else CC # compensate i0 if j deceived i0
        Budget_M[i0, j] <- 0L
        Mu[i0, j] <- 0L # divorce i0 and j
      }
      Mu[i, j] <- 1L # match i and j
    } else {
      Budget_M[i,j] <- 0L # j rejects i
    }
  }
  
  if (i < 0) { # i is female
    i <- -i
    j <- if (sum(Budget_W[i,]) == 0) 0 else which(Pref_W[i,] == min(Pref_W[i,][Budget_W[i,] != 0]))
    if (j == 0 || Mu[j, i] == 1) { # if i and j are already matched or i has no one to apply to, return
      return(list(Budget_M, Budget_W, A_M, A_W, CC, Mu))
    }
    A_M[j, i] <- 1L
    Budget_M[j, i] <- 1L
    if (sum(Mu[j,]) == 0 || Pref_M[j, i] < Pref_M[j, which(Mu[j,] == 1)]) { # j accepts i's proposal
      if (sum(Mu[,i]) == 1) { # if i was previously matched
        j0 <- which(Mu[,i] == 1)
        CC <- if (A_M[j0, i] == 1) c(j0, CC) else CC # compensate j0 if i deceived j0
        Budget_M[j0, i] <- 0L
        Mu[j0, i] <- 0L # divorce j0 and i
      }
      if (sum(Mu[j,] == 1)) { # if j was previously matched
        i0 <- which(Mu[j,] == 1)
        CC <- if (A_W[i0, j] == 1) c(-i0, CC) else CC # compensate i0 if j deceived i0
        Budget_W[i0, j] <- 0L
        Mu[j, i0] <- 0L # divorce j and i0
      }
      Mu[j, i] <- 1L # match j and i
    } else {
      Budget_W[i,j] <- 0L # j rejects i
    }
  }
  return(list(Budget_M, Budget_W, A_M, A_W, CC, Mu))
}