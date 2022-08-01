# DACC-simulation
View "Report.pdf" for detailed description of project.

To change number of men/women in preference data, edit 'choose_MW.csv' in data folder. Some graphic/tabular labels will not reflect 
this change, but the data will reflect the change. By default M=10 and W=10, so the number of men/women in each market type increments as (M,W) = (15,10), (14,10), (13,10), ... (10,10), (10,11), (10,15), ..., (10,15).

To reproduce data and results with new (or same) number of men and women, open the project and run "Master.R" from the scripts folder, 
and to reproduce the pdf, run "DACC-simulation.Rmd".

# Packages Required to Reproduce Project:
tidyverse, kableExtra, Rtools, tinytex
