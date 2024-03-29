source("scripts/DA_code.R")
source("scripts/DACC_code.R")
source("scripts/DACC_helper.R")
source("scripts/generate_data.R")

MW <- read.csv("data/choose_MW.csv")
M <- MW[[1]]; W <- MW[[2]]
preflists <- generate_data(M, W)

output_df <- data.frame(matrix(0, ncol = 4, nrow = 100 * 11))
colnames(output_df) <- c('market_type', 'men_optimal', 'intermediate', 'women_optimal')
for (t in 1:11) {
  output_df$market_type <- sort(rep(1:11, 100))
}

for (t in 1:11) {
  num_M <- dim(preflists[[1]][[t]][,,1])[[1]]
  num_W <- dim(preflists[[1]][[t]][,,1])[[2]]
  for (mkt in 1:100) {
    Pref_M <- preflists[[1]][[t]][,,mkt]
    Pref_W <- preflists[[2]][[t]][,,mkt]
    men_optimal <- DA_M(Pref_M, Pref_W)
    women_optimal <- DA_W(Pref_M, Pref_W)
    if (all(men_optimal == women_optimal)) { # if there is a unique stable matching
      output_df[100 * (t - 1) + mkt, 2] <- 100
      output_df[100 * (t - 1) + mkt, 4] <- 100
    } else {
      for (k in 1:100) {
        Phi <- sample(c(1:num_M,-1:-num_W), 50 * num_M * num_W, replace = T)
        matching <- DACC(Pref_M, Pref_W, Phi)
        if (all(matching == men_optimal)) {
          output_df[100 * (t - 1) + mkt, 2] <- output_df[100 * (t - 1) + mkt, 2] + 1
        } else if (all(matching == women_optimal)) {
          output_df[100 * (t - 1) + mkt, 4] <- output_df[100 * (t - 1) + mkt, 4] + 1
        } else {
          output_df[100 * (t - 1) + mkt, 3] <- output_df[100 * (t - 1) + mkt, 3] + 1
        }
      }
    }
  }
}

write.csv(output_df, file = "output/matching_results.csv")







## redo matchings with weighted re-sampling

output_df <- data.frame(matrix(0, ncol = 4, nrow = 100 * 11))
colnames(output_df) <- c('market_type', 'men_optimal', 'intermediate', 'women_optimal')
for (t in 1:11) {
  output_df$market_type <- sort(rep(1:11, 100))
}

for (t in 1:11) {
  num_M <- dim(preflists[[1]][[t]][,,1])[[1]]
  num_W <- dim(preflists[[1]][[t]][,,1])[[2]]
  for (mkt in 1:100) {
    Pref_M <- preflists[[1]][[t]][,,mkt]
    Pref_W <- preflists[[2]][[t]][,,mkt]
    men_optimal <- DA_M(Pref_M, Pref_W)
    women_optimal <- DA_W(Pref_M, Pref_W)
    if (all(men_optimal == women_optimal)) { # if there is a unique stable matching
      output_df[100 * (t - 1) + mkt, 2] <- 100
      output_df[100 * (t - 1) + mkt, 4] <- 100
    } else {
      for (k in 1:100) {
        sample_space <- c(rep(1:num_M, num_W),rep(-1:-num_W, num_M))
        Phi <- sample(sample_space, 50 * num_M * num_W, replace = T)
        matching <- DACC(Pref_M, Pref_W, Phi)
        if (all(matching == men_optimal)) {
          output_df[100 * (t - 1) + mkt, 2] <- output_df[100 * (t - 1) + mkt, 2] + 1
        } else if (all(matching == women_optimal)) {
          output_df[100 * (t - 1) + mkt, 4] <- output_df[100 * (t - 1) + mkt, 4] + 1
        } else {
          output_df[100 * (t - 1) + mkt, 3] <- output_df[100 * (t - 1) + mkt, 3] + 1
        }
      }
    }
  }
}

write.csv(output_df, file = "output/matching_results_reweight.csv")
