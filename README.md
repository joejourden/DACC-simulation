# em-methods-project
This repo contains the code and simulated data for my final project for the course Empirical Methods for Applied Microeconomics.

I keep the simulated data presented in the paper in the folder "data-original". If the R scripts are run, the folder
	"data-replication" will store their results, but the Python scripts use the data from "data-original".

I obtained code for the DA algorithm from https://www.geeksforgeeks.org/stable-marriage-problem/. This code also
	inspires my implementation of the DACC algorithm.

0: simulate preference data in R. (Output stored in "data-original" or "data-replication")
1: functions for DA and DACC algorithms
2: main block runs DACC 100 times per market, exports data as Latex tables in respective data folders.