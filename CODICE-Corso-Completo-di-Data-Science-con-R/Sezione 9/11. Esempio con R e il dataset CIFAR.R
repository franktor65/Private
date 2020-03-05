library(keras)

cifar <- dataset_cifar10()

x_train <- cifar$train$x
y_train <- cifar$train$y
x_test <- cifar$test$x
y_test <- cifar$test$y

dim(x_train)
dim(y_train)
dim(x_test)
dim(y_test)

# rescale
x_train <- x_train / 255
x_test <- x_test / 255


# convertiamo la classificazione in fattore
y_train <- to_categorical(y_train, 10)
y_test <- to_categorical(y_test, 10)

# costruiamo il modello
model <- keras_model_sequential()

model %>%
        layer_conv_2d(filter = 32, kernel_size = c(3, 3), activation = 'relu', input_shape = c(32, 32, 3), padding='same') %>%
        layer_conv_2d(32, kernel_size= c(3, 3), activation = 'relu', padding='same') %>%
        layer_max_pooling_2d(pool_size = c(2, 2)) %>% 
        layer_dropout(rate = 0.25) %>% 
        
        layer_conv_2d(filter = 64, kernel_size = c(3, 3), activation = 'relu', padding='same') %>%
        layer_conv_2d(64, kernel_size= c(3, 3), activation = 'relu', padding='same') %>%
        layer_max_pooling_2d(pool_size = c(2, 2), padding='same') %>% 
        layer_dropout(rate = 0.25) %>% 
        
        layer_conv_2d(filter = 128, kernel_size = c(3, 3), activation = 'relu', padding='same') %>%
        layer_conv_2d(128, kernel_size= c(3, 3), activation = 'relu', padding='same') %>%
        layer_max_pooling_2d(pool_size = c(2, 2), padding='same') %>% 
        layer_dropout(rate = 0.25) %>% 
        
        layer_flatten() %>% 
        layer_dense(units = 512, activation = 'relu') %>% 
        layer_dropout(rate = 0.5) %>% 
        layer_dense(units = 128, activation = 'relu') %>% 
        layer_dense(units = 10, activation = 'softmax')

model %>% compile(
        loss = "categorical_crossentropy",
        optimizer = 'adam',
        metrics = "accuracy")

summary(model)

history <- model %>% fit(x_train, y_train, 
                          epochs = 10, 
                          batch_size = 512, 
                          validation_split = 0.4)

scores <- model %>% evaluate(
        x_test, y_test, verbose = 0)

# salviamo per l'esportazione verso altri formati

mod_yaml <- model_to_yaml(model)

model_to_json()

