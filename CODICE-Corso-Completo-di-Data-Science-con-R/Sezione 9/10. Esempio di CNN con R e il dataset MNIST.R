# richiamiamo keras
library(keras)

# importiamo il dataset MNIST, che è tra quelli già disponibili in keras
mnist <- dataset_mnist()

# creiamo gli oggetti di train e di test con le relative classificazioni
x_train <- mnist$train$x
y_train <- mnist$train$y
x_test <- mnist$test$x
y_test <- mnist$test$y

# controlliamo le dimensioni dei nostri oggetti
dim(x_train)
dim(y_train)
dim(x_test)
dim(y_test)

# per creare delle immagini
digit <- x_train[5,,]
plot(as.raster(digit, max = 255))

# reshape
x_train <- array_reshape(x_train, c(nrow(x_train), 28, 28, 1))
x_test <- array_reshape(x_test, c(nrow(x_test), 28, 28, 1))


# rescale
x_train <- x_train / 255
x_test <- x_test / 255

# convertiamo la classificazione in fattore
y_train <- to_categorical(y_train, 10)
y_test <- to_categorical(y_test, 10)

# inizializziamo il modello

model <- keras_model_sequential()

# costruiamo il modello

model %>%
        layer_conv_2d(filters = 32, kernel_size = c(3,3), activation = 'relu',
                      input_shape = c(28, 28, 1)) %>% 
        layer_conv_2d(filters = 64, kernel_size = c(3,3), activation = 'relu') %>% 
        layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
        layer_dropout(rate = 0.25) %>% 
        layer_flatten() %>% 
        layer_dense(units = 128, activation = 'relu') %>% 
        layer_dropout(rate = 0.5) %>% 
        layer_dense(units = 10, activation = 'softmax')

# compiliamo il modello

model %>% compile(
        loss = loss_categorical_crossentropy,
        optimizer = optimizer_adadelta(),
        metrics = c('accuracy')
)

# verifichiamo i risultati

model %>% fit(
        x_train, y_train, 
        epochs = 10, batch_size = 128, 
        validation_split = 0.2
)

scores <- model %>% evaluate(
        x_test, y_test, verbose = 0
)


# prediciamo le classi degli oggetti di test
model %>% predict_classes(x_test)

# Test loss
scores[[1]]

# Accuracy
scores[[2]]

# salviamo il modello
save_model_hdf5(model, 'model.h5')

# possiamo poi ricaricare il modello
model <- load_model_hdf5('model.h5')
