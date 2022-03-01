generate_data <- function(M, W) {
prefarrayM <- array(dim = c(M, W, 30))
prefarrayW <- array(dim = c(W, M, 30))
  for (i in 1:30){
    # Men's preference matrix
    # the (m,w) entry is man m's ranking of woman w
    pref_M <- matrix(nrow = M, ncol = W)
    for(m in 1:M){
      pref_M[m,] <- sample(1:W)
    }
    # Women's preference matrix
    # the (w,m) entry is woman w's ranking of man m
    pref_W <- matrix(nrow = W, ncol = M)
    for(w in 1:W){
      pref_W[w,] <- sample(1:M)
    }
    prefarrayM[,,i] <- pref_M
    prefarrayW[,,i] <- pref_W
    
    write.csv(pref_M, paste0("./data/pref_M_",i,".csv"))
    write.csv(pref_W, paste0("./data/pref_W_",i,".csv"))
  }
  return(list(prefarrayM, prefarrayW))
}