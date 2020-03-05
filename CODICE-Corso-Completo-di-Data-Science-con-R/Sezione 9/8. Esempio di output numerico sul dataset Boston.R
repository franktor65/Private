# esempio di regressione sul dataset Boston

library(keras)

boston <- dataset_boston_housing()

# come vediamo il dataset è una lista, andiamo a vedere quindi la sua struttura
str(boston)

# usiamo il fattore di assegnazione multipla "%<-%" che ci permette di creare gli oggetti di train e di test
c(c(train, cl_train), c(test, cl_test)) %<-% boston

# vediamo qualche informazione sugli oggetti creati
str(train)
str(test)

str(cl_train)

# normalizziamo i dati

mean <- apply(train, 2, mean)
std <- apply(train, 2, sd)
train <- scale(train, center = mean, scale = std)
test <- scale(test, center = mean, scale = std)

# inizializziamo il modello
model <- keras_model_sequential()

# creiamo il modello 
model %>% 
        layer_dense(units = 64, activation = "relu",
                    input_shape = dim(train)[[2]]) %>%
        layer_dense(units = 64, activation = "relu") %>%
        layer_dense(units = 1)


model %>% compile(
        optimizer = "rmsprop",
        loss = "mse",
        metrics = c("mae"))

model %>% fit(train, cl_train,
              epochs = 200, batch_size = 1, verbose = 1)

model %>% evaluate(test, cl_test, verbose = 1)
