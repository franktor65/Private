# avevamo già visto un'immagine di un numero del dataset MNIST
library(keras)

# importiamo il dataset MNIST, che è tra quelli già disponibili in keras
mnist <- dataset_mnist()

# creiamo gli oggetti di train e di test con le relative classificazioni
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

digit <- x_train[2,,]
plot(as.raster(digit, max = 255))

# installiamo e richiamiamo i pacchetti che ci servono 

install.packages(c('jpeg', 'ggplot2'))
library(jpeg)
library(ggplot2)

# carichiamo un'immagine

img <- readJPEG("/Users/valentinaporcu/Dropbox/topic/10.\ Corso\ completo\ di\ Data\ Science\ con\ R/CODICE\ Corso\ Completo\ di\ Data\ Science\ con\ R/Sezione\ 9/daisies.jpg")

img_dim <- dim(img)

canali_rgb  <- data.frame(
        x = rep(1:img_dim[2], each = img_dim[1]),
        y = rep(img_dim[1]:1, img_dim[2]),
        R = as.vector(img[,,1]),
        G = as.vector(img[,,2]),
        B = as.vector(img[,,3]))

ggplot(data = canali_rgb, aes(x = x, y = y)) + 
        geom_point(colour = rgb(canali_rgb[c("R", "G", "B")])) +
        labs(title = "Immagine originale") +
        xlab("x") +
        ylab("y") +
        theme_void()


clusters <- 5

kmeans1 <- kmeans(canali_rgb[, c("R", "G", "B")], centers = clusters)

col <- rgb(kmeans1$centers[kmeans1$cluster,])

ggplot(data = canali_rgb, aes(x = x, y = y)) + 
        geom_point(colour = col) +
        labs(title = paste("Ricostruzione col kmeans", clusters)) +
        xlab("x") +
        ylab("y") + 
        theme_void()
