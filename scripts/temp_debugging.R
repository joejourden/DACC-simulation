
guys <- Guys
gals <- Gals
guy_pref <- Guy_pref
gal_pref <- Gal_pref


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
engaged_M