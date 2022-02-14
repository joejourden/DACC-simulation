# this script will contain Men-proposing DA, Women-proposing DA, and DACC

# Men-proposing DA
DA_M <- function(guys, gals, guy_pref, gal_pref) {
  guys_free <- guys
  engaged_M <- list()
  for (i in 1:length(guys)) {
    engaged_M[[i]] <- list(guys[[i]],NA_character_)
  }
  while (length(guys_free) > 0) {
    guy <- guys_free[[1]]
    guys_free <- guys_free[-which(guys_free == guy)] # mark selected guy as no longer free
    gal <- guy_pref[[guy]][[1]]
    guy_pref[[guy]] <- guy_pref[[guy]][-1] # remove girl he proposes to from his prefs
    fiance <- NA_character_
    for (i in 1:length(guys)) { # check if she has a fiance
      if(!is.na(engaged_M[[i]][[2]]) && engaged_M[[i]][[2]] == gal) {
        fiance <- engaged_M[[i]][[1]]
      }
    }
    if (is.na(fiance)) {
      # she's free
      engaged_M[[which(guys == guy)]][[2]] <- gal
    } else {
      # she is already engaged
      if (which(gal_pref[[gal]] == fiance) > which(gal_pref[[gal]] == guy)) {
        # she prefers the new guy
        engaged_M[[which(guys == guy)]][[2]] <- gal
        engaged_M[[which(guys == fiance)]][[2]] <- NA_character_
        if (length(guy_pref[[fiance]]) != 0) {
          # Ex fiance has more girls to propose to
          guys_free <- append(guys_free, fiance)
        }
      }
      else {
        # she is faithful to old fiance
        if (length(guy_pref[[guy]]) > 0) {
          # mark guy as free again if he has gals left to propose to
          guys_free <- append(guys_free, guy)
        }
      }
    }
  }
  return(engaged_M) ############ need to check that this is in right format (TO DO)
}

# Women-proposing DA
# Use Men-proposing DA but with inputs swapped
# then swap the output so pairs are of form (guy, gal) 
# and order pairs according to the list "guys"
DA_W <- function(guys, gals, guy_pref, gal_pref) {
  pairs <- DA_M(gals, guys, gal_pref, guy_pref)
  pairs <- lapply(pairs, rev)
  pairs_sorted <- list()
  for (i in 1:length(guys)) {
    j <- which(lapply(pairs, function(x) x[[1]] == guys[[i]]) == TRUE)
    pairs_sorted[[i]] <- pairs[[j]]
  }
  return(pairs_sorted)
}

DA_M(Guys, Gals, Guy_pref, Gal_pref)
DA_W(Guys, Gals, Guy_pref, Gal_pref)

# DACC