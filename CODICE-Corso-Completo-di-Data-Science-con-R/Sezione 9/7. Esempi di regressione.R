library(keras)

# primo esempio di regressione su dati generati in maniera casuale

set.seed(12345)

x <- rnorm(100)
y <- 2 * x * 10

plot(x, y)

train <- x[1:80]
test <- x[81:100]

cl_train <- y[1:80]
cl_test <- y[81:100]

model <- keras_model_sequential() 

model %>%
        layer_dense(4, input_shape=(1)) %>%
        layer_dense(1)

model %>% compile(
        optimizer = optimizer_rmsprop(lr=1),
        loss = 'mse',
        metrics = c("mae"))

model %>% fit(train, cl_train,
              epochs = 200, batch_size = 128, verbose = 1)


model %>% evaluate(test, cl_test)

