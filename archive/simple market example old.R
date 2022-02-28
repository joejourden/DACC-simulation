Guys <- list('abe', 'bob', 'col', 'dan', 'ed', 'fred', 'gav', 'hal', 'ian', 'jon')
Gals <- list('abi', 'bea', 'cath', 'dee', 'eve', 'fay', 'gay', 'hope', 'ivy', 'jan')

Guy_pref <- list('abe' = c('abi', 'eve', 'cath', 'ivy', 'jan', 'dee', 'fay', 'bea', 'hope', 'gay'),
                    'bob' = c('cath', 'hope', 'abi', 'dee', 'eve', 'fay', 'bea', 'jan', 'ivy', 'gay'),
                    'col' = c('hope', 'eve', 'abi', 'dee', 'bea', 'fay', 'ivy', 'gay', 'cath', 'jan'),
                    'dan' = c('ivy', 'fay', 'dee', 'gay', 'hope', 'eve', 'jan', 'bea', 'cath', 'abi'),
                    'ed' = c('jan', 'dee', 'bea', 'cath', 'fay', 'eve', 'abi', 'ivy', 'hope', 'gay'),
                    'fred' = c('bea', 'abi', 'dee', 'gay', 'eve', 'ivy', 'cath', 'jan', 'hope', 'fay'),
                    'gav' = c('gay', 'eve', 'ivy', 'bea', 'cath', 'abi', 'dee', 'hope', 'jan', 'fay'),
                    'hal' = c('abi', 'eve', 'hope', 'fay', 'ivy', 'cath', 'jan', 'bea', 'gay', 'dee'),
                    'ian' = c('hope', 'cath', 'dee', 'gay', 'bea', 'abi', 'fay', 'ivy', 'jan', 'eve'),
                    'jon' = c('abi', 'fay', 'jan', 'gay', 'eve', 'bea', 'dee', 'cath', 'ivy', 'hope'))

Gal_pref <- list('abi' =  c('bob', 'fred', 'jon', 'gav', 'ian', 'abe', 'dan', 'ed', 'col', 'hal'),
                    'bea' =  c('bob', 'abe', 'col', 'fred', 'gav', 'dan', 'ian', 'ed', 'jon', 'hal'),
                    'cath' =  c('fred', 'bob', 'ed', 'gav', 'hal', 'col', 'ian', 'abe', 'dan', 'jon'),
                    'dee' =  c('fred', 'jon', 'col', 'abe', 'ian', 'hal', 'gav', 'dan', 'bob', 'ed'),
                    'eve' =  c('jon', 'hal', 'fred', 'dan', 'abe', 'gav', 'col', 'ed', 'ian', 'bob'),
                    'fay' =  c('bob', 'abe', 'ed', 'ian', 'jon', 'dan', 'fred', 'gav', 'col', 'hal'),
                    'gay' =  c('jon', 'gav', 'hal', 'fred', 'bob', 'abe', 'col', 'ed', 'dan', 'ian'),
                    'hope' =  c('gav', 'jon', 'bob', 'abe', 'ian', 'dan', 'hal', 'ed', 'col', 'fred'),
                    'ivy' =  c('ian', 'col', 'hal', 'gav', 'fred', 'bob', 'abe', 'ed', 'jon', 'dan'),
                    'jan' =  c('ed', 'hal', 'gav', 'abe', 'bob', 'jon', 'col', 'ian', 'fred', 'dan'))

# get women who abe likes better than ivy e.g.
guy_prefers$abe[1:which(guy_prefers$abe == "ivy") - 1]

# get men who fay prefers over col e.g.
gal_prefers$fay[1:which(gal_prefers$fay == "col") - 1]
