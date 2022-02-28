# M-proposing DA
def matchmaker_M():
    guysfree = guys[:]
    engaged_M  = {}
    guyprefers2 = copy.deepcopy(guyprefers)
    galprefers2 = copy.deepcopy(galprefers)
    while guysfree:
        guy = guysfree.pop(0)
        guyslist = guyprefers2[guy]
        gal = guyslist.pop(0)
        fiance = engaged_M.get(gal)
        if not fiance:
            # She's free
            engaged_M[gal] = guy
        else:
            # she is already matched
            galslist = galprefers2[gal]
            if galslist.index(fiance) > galslist.index(guy):
                # She prefers new guy
                engaged_M[gal] = guy
                if guyprefers2[fiance]:
                    # Ex has more girls to try
                    guysfree.append(fiance)
            else:
                # She is faithful to old fiance
                if guyslist:
                    # Look again
                    guysfree.append(guy)
    engaged_M = dict((v,k) for k,v in engaged_M.items()) # go from dict with men as keys, women as values to opposite way
    return engaged_M

# Women-proposing DA
def matchmaker_W():
    Galprefers = guyprefers
    Guyprefers = galprefers
    Gals = guys
    Guys = gals
    Guysfree = Guys[:]
    engaged_W  = {}
    Guyprefers2 = copy.deepcopy(Guyprefers)
    Galprefers2 = copy.deepcopy(Galprefers)
    while Guysfree:
        Guy = Guysfree.pop(0)
        Guyslist = Guyprefers2[Guy]
        Gal = Guyslist.pop(0)
        fiance = engaged_W.get(Gal)
        if not fiance:
            # She's free
            engaged_W[Gal] = Guy
        else:
            #  she is already matched
            Galslist = Galprefers2[Gal]
            if Galslist.index(fiance) > Galslist.index(Guy):
                # She prefers new Guy
                engaged_W[Gal] = Guy
                if Guyprefers2[fiance]:
                    # Ex has more girls to try
                    Guysfree.append(fiance)
            else:
                # She is faithful to old fiance
                if Guyslist:
                    # Look again
                    Guysfree.append(Guy)
    return engaged_W

# DACC functions
def stopcriterion():
    for guy in guys:
        hisbudget = budget[guy]
        if guy in matched.keys(): # check that guys with partners don't have better options in budget set
            partner = matched[guy]
            if hisbudget.index(partner)!=0:
                return False
        elif len(hisbudget)!=0: # unmatched guys should have empty budget sets
            return False
    inversematched = dict((v,k) for k,v in matched.items()) # repeat steps for gals
    for gal in gals:
        herbudget = budget[gal]
        if gal in inversematched.keys():
            partner = inversematched[gal]
            if herbudget.index(partner)!=0:
                return False
        elif len(herbudget)!=0:
            return False
    return True

def proposes(i):
    global matched, budget, A, CC
    if budget[i]==[]:
            return None
    else:
        if i in guys:
            j = budget[i][0] # i proposes to j
            if (i in matched.keys() and j in matched.values() and j == matched[i]): # i and j are already matched
                return None
            else:
                if i not in A[j]:
                    A[j].append(i) # record that i proposed to j
                if i not in budget[j]:
                    budget[j].append(i) # add i to j's budget
                    budget[j] = [y for x in prefs[j] for y in budget[j] if y == x] # reorder j's budget set to fit prefs
                inversematched = dict((v,k) for k,v in matched.items())
                if (j not in matched.values() or prefs[j].index(i) < prefs[j].index(inversematched[j])): # if j prefers i to her partner,
                    if i in matched.keys(): # see if we need to compensate i's previous partner
                        j_1 = matched[i] # j_1 was i's previous partner
                        if  i in A[j_1]: # if j_1 was deceived by i
                            CC.insert(0,j_1) # j_1 will be next to be compensated
                        budget[j_1].remove(i) # remove i from j_1's budget set
                        del matched[i] # divorce i and j_1
                    if j in matched.values(): # see if we need to compensate j's previous partner
                        inversematched = dict((v,k) for k,v in matched.items())
                        i_1 = inversematched[j]
                        if j in A[i_1]:
                            CC.insert(0,i_1)
                        budget[i_1].remove(j)
                        del matched[i_1]
                    matched[i] = j
                else:
                    budget[i].remove(j) # j rejects i
                return None
        if i in gals: # repeat steps for if i is a gal
            j = budget[i][0] # i proposes to j
            if (i in matched.values() and j in matched.keys() and i == matched[j]): # i and j are already matched
                return None
            else:
                if i not in A[j]:
                    A[j].append(i) # record that i proposed to j
                if i not in budget[j]:
                    budget[j].append(i) # add i to j's budget
                    budget[j] = [y for x in prefs[j] for y in budget[j] if y == x] # reorder j's budget set to fit prefs
                inversematched = dict((v,k) for k,v in matched.items())
                if (j not in matched.keys() or prefs[j].index(i) < prefs[j].index(matched[j])): # if j prefers i to his partner,
                    if i in matched.values(): # see if we need to compensate i's previous partner
                        j_1 = inversematched[i] # j_1 was i's previous partner
                        if i in A[j_1]: # if j_1 was deceived by i
                            CC.insert(0,j_1) # j_1 will be next to be compensated
                        budget[j_1].remove(i) # remove i from j_1's budget set
                        del matched[j_1] # divorce i and j_1
                    if j in matched.keys(): # see if we need to compensate j's previous partner
                        i_1 = matched[j]
                        if j in A[i_1]:
                            CC.insert(0,i_1)
                            budget[i_1].remove(j)
                        del matched[j]
                    matched[j] = i
                else:
                    budget[i].remove(j) # j rejects i
                return None

def compensate(i):
    global matched, budget, A, CC
    if (budget[i] != [] and budget[i][0] in CC): # if two compensation chains cross
        j = budget[i][0]
        compensate(j) # compensate j before i
        CC.remove(j) # j has been compensated
    proposes(i)
    if (i in matched.keys() or i in matched.values() or budget[i]==[]): # if i is done being compensated,
        CC.remove(i)
