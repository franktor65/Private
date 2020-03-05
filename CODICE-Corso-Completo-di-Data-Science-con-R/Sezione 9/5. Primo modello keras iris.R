# abbiamo già a disposizione il dataset iris 

# impostiamo un seed
set.seed(12345)

# mischiamo il dataset 
random <- runif(nrow(iris))
iris2 <- iris[order(random),]

# eliminiamo il fattore di classificazione e lo salviamo a parte
iris3 <- iris2[, -5]
cl <- iris2[, 5]


# creiamo una funzione che normalizzi il dataset
normalize <- function(x) {
        num <- x - min(x)
        denom <- max(x) - min(x)
        return (num/denom)
}

# e la applichiamo ai casi
iris_norm <- as.data.frame(lapply(iris3, normalize))

# diamo un'occhiata
head(iris_norm)

# a questo punto ci creiamo gli oggetti di train e di test
train <- as.matrix(iris_norm[1:100 ,])
test <- as.matrix(iris_norm[101:150 ,])

# facciamo lo stesso per il fattore di classificazione
# trasformiamo i fattori di classificazione in valori numerici
cl_train <- as.numeric(cl[1:100])
cl_test <- as.numeric(cl[101:150])

# diamo un'occhiata per renderci conto della differenza
head(cl)
head(cl_train)

# carichiamo il pacchetto keras
library(keras)

# codifichiamo con l'one hot il fattore di classificazione sul train
cl_train <- to_categorical(cl_train)

# facciamo lo stesso sul test
cl_test <- to_categorical(cl_test)

# diamo un'occhiata 
head(cl_train)

# inizializziamo il modello
model <- keras_model_sequential() 

# aggiungiamo gli strati
model %>% 
        layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
        layer_dense(units = 3, activation = 'softmax')

# stampiamo un sommario del modello
summary(model)

# possiamo ottenere ulteriori informazioni sul modello e la sua configurazione
get_config(model)
get_layer(model, index = 1)
model$layers
model$inputs
model$outputs

# compiliamo il modello
model %>% compile(
        loss = 'categorical_crossentropy',
        optimizer = 'adam',
        metrics = 'accuracy'
)

# adattiamo il modello ai dati
model %>% fit(train, 
        cl_train[, -1], 
        epochs = 200, 
        batch_size = 4, 
        validation_split = 0.2
)

# prediciamo le classi del test
classes <- model %>% predict_classes(test, batch_size = 128)

model %>% predict(test)

# vediamo la matrice di confusione
table(as.numeric(cl[101:150]), classes)

# valutiamo il modello
score <- model %>% evaluate(test, cl_test[, -1], batch_size = 128)

print(score)


# aggiungiamo più strati 

model <- keras_model_sequential() 

model %>% 
        layer_dense(units = 8, activation = 'relu', input_shape = c(4)) %>% 
        layer_dense(units = 5, activation = 'relu') %>% 
        layer_dense(units = 3, activation = 'softmax')

model %>% compile(
        loss = 'categorical_crossentropy',
        optimizer = 'adam',
        metrics = 'accuracy')

model %>% fit(
        train, cl_train[, -1], 
        epochs = 200, batch_size = 5, 
        validation_split = 0.2)

score <- model %>% evaluate(test, cl_test[, -1], batch_size = 128)

print(score)

