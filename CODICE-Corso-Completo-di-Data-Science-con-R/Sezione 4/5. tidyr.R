install.packages("tidyr")
library(tidyr)

# carichiamo i dati
pazienti1 <- read.csv("pazienti.csv")

gather(pazienti1, trattamenti, punteggio, trattamento1:trattamento4, na.rm = FALSE, convert = FALSE)

# usiamo gather per riorganizzare il dataset originale, pazienti1, e creare un oggetto che lo contenga
gat1 <- gather(pazienti1, trattamenti, punteggio, trattamento1:trattamento4, na.rm = FALSE, convert = FALSE)
head(gat1)


# adesso usiamo la funzione spread() per tornare al dataset originale:
spread(gat1, trattamenti, punteggio)



## unite() e separate()

df <- data.frame(name = c("Laura", "Simon", "Katherine", "Francis", "Joseph", "Rosie"),
                 heights = c("163", "180", "165", "169", "178", "164"),
                 sex = c( "f", "m", "f", "m", "m", "f"))

df2 <- unite(df, heights_sex, heights, sex, sep = "")

df3 <- separate(df2, heights_sex, into = c("heights", "sex"), 3)

df4 <- unite(df, heights_sex, heights, sex, sep = ",")

df5 <- separate(df4, heights_sex, into = c("heights", "sex"), sep = ",")



