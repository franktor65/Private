# classificazione binaria su dataset Pima

# carichiamo keras
library(keras)

# carichiamo il dataset

library(mlbench)
data("PimaIndiansDiabetes")

pid <- PimaIndiansDiabetes

# visualizziamo i dati
head(pid)

# convertiamo la variabile di riferimento in valore numerico
pid$diabetes <- ifelse(pid$diabetes == 'pos', 1, 0)

head(pid)

dim(pid)

# stacchiamo i dati dal fattore di classificazione

pids <- scale(pid[, -9])

cl <- pid[, 9]

table(cl)

head(pids)

# creiamo l'oggetto di train e quello di test

train <- pids[1:450, ]
test <- pids[451:768, ]

# facciamo lo stesso per i fattori di classificazione

cl_train <- cl[1:450]
cl_test <- cl[451:768]

cl_train <- to_categorical(cl_train)
cl_test <- to_categorical(cl_test)

# creiamo il modello

model <- keras_model_sequential() 
model %>% 
        layer_dense(units = 10, activation = 'relu', input_shape = 8) %>% 
        layer_dense(units = 10, activation = 'relu') %>%
        layer_dense(units = 6, activation = 'relu') %>%
        layer_dense(units = 2, activation = 'sigmoid')


model %>% compile(
        loss = 'categorical_crossentropy',
        optimizer = 'adam',
        metrics = c('accuracy')
)


# adattiamo il modello ai dati

model %>% fit(train, 
              cl_train, 
              epochs = 200, 
              batch_size = 4, 
              validation_split = 0.2
)


# prediciamo le classi del test
classes <- model %>% predict_classes(test, batch_size = 128)

# vediamo la matrice di confusione
table(as.numeric(cl[451:768]), classes)

score <- model %>% evaluate(test, cl_test, batch_size = 5)

print(score)



