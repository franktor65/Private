# sistema di raccomandazione base con knn
# importiamo il file
clients <- read.csv(file.choose())

# sistemiamo il file per usarlo per l'analisi, impostando i nomi delle righe, eliminando la prima colonna e girando il dataframe
row.names(clients) <- clients[, 1]
clients <- clients[, -1]
clients <- t(clients) 


# calcoliamo la similarità tra i prodotti
similarities <- cor(clients)

# vediamo alcune similarità come esempio
similarities[1, 3]

# calcoliamo la distanza tra i prodotti
distances <- -log((similarities / 2) + 0.5)

# impostiamo la funzione che calcola il knn
k.nearest.neighbors <- function(i, distances, k = 2)
{
        return(order(distances[i, ])[2:(k + 1)])
}

# calcoliamo la probabilità di acquisto di un prodotto
buying.probability <- function(cl, product, clients, distances,
                               k = 2)
{
        neighbors <- k.nearest.neighbors(product, distances, k = k)
        return(mean(sapply(neighbors, function (neighbor) {clients[cl,
                                                                   neighbor]})))
}

buying.probability(1, 6, clients, distances)


most.probable.products <- function(cl, clients, distances, k = 2)
{
        return(order(sapply(1:ncol(clients),
                            function (product)
                            {
                                    buying.probability(cl,
                                                       product,
                                                       clients,
                                                       distances,
                                                       k = k)
                            }),
                     decreasing = TRUE))
}

cl <- 4
listing <- most.probable.products(cl, clients, distances)
colnames(clients)[listing[1:10]]
