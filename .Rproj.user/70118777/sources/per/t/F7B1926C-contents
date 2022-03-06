source("scripts/DA_code.R")
source("scripts/DACC_code.R")
source("scripts/DACC_helper.R")
source("scripts/generate_data.R")

M <- 25
W <- 20
Pref_arrays <- generate_data(M, W)

output_df <- data.frame(matrix(0, ncol = 3, nrow = 30))
colnames(output_df) <- c('Men_Optimal', 'Intermediate_Matching', 'Women_Optimal')

for (market in 1:30) {
  Pref_M <- Pref_arrays[[1]][,,market]
  Pref_W <- Pref_arrays[[2]][,,market]
  men_optimal <- DA_M(Pref_M, Pref_W)
  women_optimal <- DA_W(Pref_M, Pref_W)
  if (all(men_optimal == women_optimal)) { # if there is a unique stable matching
    output_df[market, 1] <- 100
    output_df[market, 3] <- 100
  } else {
    for (rep in 1:100) {
      Phi <- sample(c(1:M,-1:-W), 50 * M * W, replace = T)
      matching <- DACC(Pref_M, Pref_W, Phi)
      if (all(matching == men_optimal)) {
        output_df[market, 1] <- output_df[market, 1] + 1
      } else if (all(matching == women_optimal)) {
        output_df[market, 3] <- output_df[market, 3] + 1
      } else {
        output_df[market, 2] <- output_df[market, 2] + 1
      }
    }
  }
}
write.csv(output_df, file = "output/matching_results.csv")
sum(output_df[,2])