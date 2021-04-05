import copy
import random
import pandas as pd
import os
import collections
import numpy as np
from scipy.stats import randint  

path = "/em-methods-project"
relative_path = os.path.relpath(path)

os.chdir(relative_path + "/data_original/simulated_data_1")

# change directory based on simulation type (0,1,2, or 3)
sim_type = 0
os.chdir("C:/Users/Joe/Documents/ECON Courses/Junior Year/Micro-Metrics/Research Project/simulated_data_" + str(sim_type))
# number of men and women
M = 100
W = 100
results = [[] for i in range(1,31)] # for each simulation, store occurenes of M-optimal, intermediate, and W-optimal outcomes
for sim_number in range(1,31):
    # Create a dataframe from csv
    pref_M = pd.read_csv('pref_M_' + str(sim_number) + '.csv', delimiter=',')
    pref_W = pd.read_csv('pref_W_' + str(sim_number) + '.csv', delimiter=',')
    # rows are lists within a list
    pref_M = [list(row) for row in pref_M.values]
    pref_W = [list(row) for row in pref_W.values]
    prefs = dict((str(i+1),[str(k) for k in pref_M[i]]) for i in range(0,M)) # make a dictionary with men, and a list of women ordered by preference
    prefs.update(dict((str(-i-1),[str(k) for k in pref_W[i]]) for i in range(0,W))) # add women's preferences

    guys = [str(i) for i in range(1,M+1)]
    gals = [str(-i) for i in range(1,W+1)]
    folks = copy.deepcopy(guys)
    folks.extend(gals)
    # the DA algorithms use mens' and womens' preferences as separate objects
    guyprefers = dict((guy, prefs[guy]) for guy in guys)
    galprefers = dict((gal, prefs[gal]) for gal in gals)

    # run men-proposing DA and women-proposing DA
    engaged_M = matchmaker_M()
    engaged_W = matchmaker_W()
    if engaged_M == engaged_W:
        results[sim_number-1] = [100,0,100]
        print("Simulation # %s/30 results: Unique Stable Matching" % (sim_number))
    else:
        results[sim_number-1] = [0,0,0] # occurences of M-optimal, intermediate, and W-optimal
        for rep in range(0,100):
            Phi = randint .rvs(-W, M, size = 500000) # draw Phi from discrete uniform dist
            Phi = list(Phi)
            Phi = [x+1 if x >= 0 else x for x in Phi] # Men should be indexed from 1 to M, not 0 to (M-1)
            Phi = list(map(str, Phi))

            budget = copy.deepcopy(prefs)
            matched = {}
            A = dict((k,[]) for k in folks)
            CC = []
            k = 0 # rounds
            t = 0 # time
            while not stopcriterion():
                if CC == []:
                    i = Phi[k]
                    proposes(i)
                    k += 1
                else:
                    i = CC[0] # take i from top of CC stack
                    compensate(i)
                t += 1
            if matched == engaged_M:
                results[sim_number-1][0] += 1
            elif matched == engaged_W:
                results[sim_number-1][2] += 1
            else:
                results[sim_number-1][1] += 1
            print("Simulation # %s/30, repetition # %s/100 results: %s" % (sim_number,rep+1, results[sim_number-1]))

# convert results to dataframe
results_df = pd.DataFrame.from_records(results)
# convert dataframe to latex table code
results_text = open("results_" + str(sim_type) + ".txt","w")
results_text.write(results_df.to_latex(index=False))
results_text.close()



with open('mytable.tex','w') as tf:
    tf.write(df.to_latex())