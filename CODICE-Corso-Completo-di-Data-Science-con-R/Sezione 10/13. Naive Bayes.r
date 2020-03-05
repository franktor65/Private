# naive bayes

# importiamo il pacchetto SparkR

library(SparkR)

# importiamo il dataset

df <- read.df(source = "csv", path = "/FileStore/tables/churn.csv", header = "true", inferSchema = "true")


# visualizziamo le prime occorrente

head(df2)

# eliminiamo i missing values


df2 <- na.omit(df2, how = 'any')

# creiamo l'oggetto di train e di test

sample <- randomSplit(df2, c(0.7, 0.3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]

# impostiamo il modello

model <- spark.naiveBayes(train, label ~ gender + paymethod)

# computiamo le predizioni sull'oggetto di test


predictions <- predict(model, test)

# valutiamo l'accuratezza

createOrReplaceTempView(predictions, "predictions")


correct <- sql("SELECT prediction, label FROM predictions WHERE prediction = label")


count(correct)


acc <- count(correct)/count(predictions)
acc
