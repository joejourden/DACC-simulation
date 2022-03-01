# em-methods-project
This repo contains code from my final project for the course Empirical Methods for Applied Microeconomics.
I have updated the code to improve readability.

I keep the simulated data presented in the paper in the folder "data-original". If the R scripts are run, the folder
	"data-replication" will store their results, but the Python scripts use the data from "data-original".

1. simulate preference data. (Output stored in "data-example" or "data-replication")
2. functions for DA and DACC algorithms
3. main block runs DACC 100 times per market, exports pdf document summarizing results

# To change number of men/women in preference data, edit 'choose_MW.csv' in data folder. (default M=20, W=25)
