# em-methods-project
This repo contains code from my final project for the course Empirical Methods for Applied Microeconomics.
I have updated the code to improve readability.

I keep the simulated data presented in the paper in the folder "data-original". If the R scripts are run, the folder
	"data-replication" will store their results, but the Python scripts use the data from "data-original".

1. simulate preference data. (Output stored in "data-example" or "data-replication")
2. functions for DA and DACC algorithms
3. main block runs DACC 100 times per market, exports pdf document summarizing results

# To change number of men/women in preference data, edit 'choose_MW.csv' in data folder. By default M=10 and W=10, so this is the number of men and women used for Table 1,
and for the Figure 2, the number of men/women increments as (M_n,W_n) = (15,10), (14,10), (13,10), ... (10,10), (10,11), (10,15), ..., (10,15).