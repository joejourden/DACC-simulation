setwd("C:/Users/Joe/Documents/ECON Courses/Junior Year/Micro-Metrics/Research Project/simulated_data_3/")

for (sim_number in 1:30){
  # approx original number of men: 6184, women 4840
  M <- 88; W <- 112
  err <- rlogis(M, location = 0, scale = 1)
  for (i in 2:W){
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
  
  U_M <- matrix(nrow = M, ncol = W)
  for(m in 1:M){
    for(w in 1:W){
      U_M[m,w] = D_W[w,]%*%beta_M + err[m,w]
    }
  }
  
  U_W <- matrix(nrow = W, ncol = M)
  for(w in 1:W){
    for(m in 1:M){
      U_W[w,m] = D_M[m,]%*%beta_W + err[m,w]
    }
  }
  
  # make a matrix with the women ordered by ranking (rank 1 to W) as rows, each row is a man's pref ranking over the women
  # the (i,j) entry is the woman whom man i ranks j'th
  pref_M <- matrix(nrow = M, ncol = W)
  for(m in 1:M){
    # order is from low to high utility, so flip the order to get ranking
    rank <- W - order(U_M[m,]) + 1
    for(w in 1:W){
      pref_M[m,rank[w]] <- w # if w has rank rank[w] for man m, put her in the rank[w]'th place in pref_M[m,]
    }
  }
  
  
  # make a matrix with the men ordered by ranking (rank 1 to M) as rows, each row is a woman's pref ranking over the men
  # the (i,j) entry is the man whom woman i ranks j'th
  pref_W <- matrix(nrow = W, ncol = M)
  for(w in 1:W){
    # order is from low to high utility, so flip the order to get ranking
    rank <- M - order(U_W[w,]) + 1
    for(m in 1:M){
      pref_W[w,rank[m]] <- m # if m has rank rank[m] for woman w, put him in the rank[m]'th place in pref_W[w,]
    }
  }
  pref_M_dat <- data.frame(-pref_M) # women are negative numbers now
  pref_W_dat <- data.frame(pref_W)
  
  write.table(pref_M_dat, file = paste("pref_M_",sim_number,".csv",sep=""), sep=",", row.names = FALSE, col.names = TRUE)
  write.table(pref_W_dat, file = paste("pref_W_",sim_number,".csv",sep=""), sep=",",  row.names = FALSE, col.names = TRUE)
}
