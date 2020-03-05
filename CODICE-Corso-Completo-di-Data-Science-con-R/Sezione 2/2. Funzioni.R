# creiamo unoa funzione

funzione.somma1 <- function (x) {
        1+x
}


# applichiamo la funzione al numero tra le parentesi
funzione.somma1(20)

ricetta <- function(aggiungi){
        if (aggiungi < 4) {
                print ("Aggiungi un altro uovo")
        }else{
                print ("Basta così!")
        }
}

ricetta(3)

ricetta(12)