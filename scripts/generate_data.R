generate_data <- function(M, W) {
  # increment # of (men, women) as (10, 15), (10,14),..., (10,10), (11,10),..., (15,10)
  preflist_M <- list()
  for (t in 1:11) {
    preflist_M[[t]] <- array(dim = c(max(M, M - 6 + t), max(W, W + 6 - t), 100))
  }
  preflist_W <- list()
  for (t in 1:11) {
    preflist_W[[t]] <- array(dim = c(max(W, W + 6 - t), max(M, M - 6 + t), 100))
  }
  for (t in 1:11) {
    num_M <- dim(preflist_M[[t]])[[1]]
    num_W <- dim(preflist_M[[t]])[[2]]
    for (i in 1:100){
      # Men's preference matrix
      # the (m,w) entry is man m's ranking of woman w
      for(m in 1:num_M){
        preflist_M[[t]][m,,i] <- sample(1:num_W)
      }
      # Women's preference matrix
      # the (w,m) entry is woman w's ranking of man m
      for(w in 1:num_W){
        preflist_W[[t]][w,,i] <- sample(1:num_M)
      }
    }
  }
  return(list(preflist_M, preflist_W))
}