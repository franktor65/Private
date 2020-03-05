# per prima cosa creiamo un vettore, che contiene, ad esempio, i voti di alcuni esami

alcuni.esami <- c(28, 27, 24, 22, 25)

alcuni.esami

# assegniamo ora un’etichetta ai vari valori all’interno del nostro vettore
names(alcuni.esami) <- c("marketing", "statistica", "analisi1", "logica", "text mining")
                         
# stampiamo
alcuni.esami