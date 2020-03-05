# ripartiamo dal dataset originale, quello con gli errori
stud <- read.csv("students2.csv", sep = ",")

# in questo caso ci interessano in particolare le variabili mark1 e mark1
# richiamiamo il pacchetto
library(outliers)

# calcoliamo gli outlier tramite il test del chi quadro
chisq.out.test(stud$mark1)
chisq.out.test(stud$mark2)

# vediamo l’output dell’outlier detection sulla variabile mark1
outlier(stud$mark1)

# possiamo identificare gli outlier di una variabile anche tramite la funzione outlier
outlier(stud$mark2, opposite = FALSE, logical = FALSE)

# impostando l’argomento logical come TRUE otteniamo un output di questo tipo

outlier(stud$mark2, opposite = FALSE, logical = TRUE)


# possiamo usare la funzione sapply() per applicare la funzione a più variabili del dataset
sapply(stud[, 4:6], outlier)


# in questo modo, impostando fill come TRUE e median come FALSE, impostiamo la media al posto dell'outlier

rm.outlier(stud$mark1, fill = TRUE, median = FALSE, opposite = FALSE)

# in questo modo, impostando fill come TRUE e median come TRUE, impostiamo la mediana al posto dell'outlier

rm.outlier(stud$mark1, fill = TRUE, median = FALSE, opposite = FALSE)
