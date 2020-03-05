# apriamo la sessione

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.4.0-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"))) 

sparkR.session()  


# kmeans 

df <- createDataFrame(iris)

sample <- randomSplit(df, c(7,3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]
model <- spark.kmeans(train, ~ Sepal_Length + Sepal_Width + Petal_Length + 
                              Petal_Width,
                            k = 3)

# Model summary
summary(model)

# Get fitted result from the k-means model
head(fitted(model))

# Prediction
predictions <- predict(model, test)
head(predictions)

predictions$Species <- regexp_replace(predictions$Species, 'setosa', '2')
predictions$Species <- regexp_replace(predictions$Species, 'versicolor', '0')
predictions$Species <- regexp_replace(predictions$Species, 'virginica', '1')

head(predictions)

createOrReplaceTempView(predictions, 'predictions')

correct <- sql("SELECT prediction, Species FROM predictions WHERE prediction = Species")

count(correct)

acc <- count(correct)/count(predictions)
acc

sparkR.session.stop()
