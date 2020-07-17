# typology_magic.R
#
# Henri Kauhanen 2020, based on earlier script logic by John Beavers and Elise LeBovidge
#
# Get relatedness information within paradigm pairs. Note that the underlying root is
# not counted in the calculation of pairedness, and that symmetrically related pairs are only
# counted once.


typology_magic <- function(datafile = "../data/prepared.RData",
                           folder = "../results") {
  load(datafile) # object named 'data'

  for (condition in c("wo_hyps", "with_hyps")) {
    df <- data[[condition]]$plain

    outapp <- data.frame(Language=unique(df$Language), Roots=NA, Und=NA, Pairs=NA, Equi=NA, ND=NA)

    for (i in 1:nrow(outapp)) {
      dfhere <- df[df$Language==outapp[i,]$Language, ]

      outapp[i,]$Roots <- nrow(dfhere)
      outapp[i,]$Und <- nrow(dfhere[dfhere$Underlying.Root != "", ])/nrow(dfhere)

      pairs <- 0
      l_pairs <- 0
      e_pairs <- 0
      u_pairs <- 0
      for (r in 1:nrow(dfhere)) {
        forms_attested <- 0
        for (col in c("Simple.State", "Inchoative", "Causative", "Result.State")) {
          if (dfhere[r,][[col]] != "") {
            forms_attested <- forms_attested + 1
            l_pairs <- l_pairs + sum(unlist(strsplit(dfhere[r,][[paste0(col, ".Code")]], ""))[-1] == "l")
            e_pairs <- e_pairs + sum(unlist(strsplit(dfhere[r,][[paste0(col, ".Code")]], ""))[-1] == "e")
            u_pairs <- u_pairs + sum(unlist(strsplit(dfhere[r,][[paste0(col, ".Code")]], ""))[-1] == "u")
          }
        }
        pairs <- pairs + choose(forms_attested, 2)
      }
      outapp[i,]$Pairs <- pairs
      outapp[i,]$Equi <- e_pairs/(2*pairs)
      outapp[i,]$ND <- (l_pairs + u_pairs)/(2*pairs)
    }

    outapp <- outapp[order(outapp$Language), ]

    write.csv(outapp, row.names=FALSE, file=paste0(folder, "/typology_", condition, ".csv"))
  }
}

