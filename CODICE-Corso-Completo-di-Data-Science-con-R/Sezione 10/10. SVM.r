# Support Vector Machines

df <- sql("SELECT * FROM pid2")

head(df)


# convertire la variabile label

df$diabetes <- ifelse(df$diabetes == 'pos', 1, 0)



sample <- randomSplit(df, c(0.7, 0.3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]


model <- spark.svmLinear(train, diabetes ~ glucose 
                            + pressure + triceps + insulin + mass 
                            + pedigree, regParam = 0.01, maxIter = 10)

# riepilogo del modello
summary(model)

# predizioni
predictions <- predict(model, test)
head(predictions)

head(select(predictions, "diabetes", "prediction"))

createOrReplaceTempView(predictions, "predictions")

correct <- sql("SELECT prediction, diabetes FROM predictions WHERE prediction = diabetes")

count(correct)

acc <- count(correct)/count(predictions)
acc

