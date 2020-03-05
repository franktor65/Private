# creiamo un vettore
titolo.studio <- c("laurea", "diploma", "l.media", "master", "laurea", "laurea", "diploma")

# creiamo un fattore
fattore1 <- factor(titolo.studio, order=TRUE, levels=c("l.media", "diploma", "laurea", "master"))

fattore1

fattore1[2] > fattore1[4]

# creiamo un vettore
vettore1 <- c(1,2,1,2,3,1,2)

# creiamo un fattore e gli attribuiamo livelli ed etichette
fattore1 <- factor(vettore1, levels= c(1,2,3), labels= c("basso", "medio", "alto"))
                                                         
# stampiamo il fattore1
fattore1

# riassumiamo il fattore con la seguente funzione:
summary(fattore1)

table(fattore1)


                                                         

