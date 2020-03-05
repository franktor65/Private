# regressione logistica

# caricare il dataset


df <- sql("SELECT * FROM pid")


head(df)

# convertire la variabile label

df$diabetes <- ifelse(df$diabetes == 'pos', 1, 0)



sample <- randomSplit(df, c(0.7, 0.3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]



model <- glm(diabetes ~ glucose + pressure + pedigree + age, data = train, family = 'binomial')



predictions <- predict(model, test)



head(predictions)



predictions$prediction <- ifelse(predictions$prediction > 0.5, 1, 0)



head(predictions)



head(select(predictions, "label", "prediction"))



createOrReplaceTempView(predictions, "predictions")



correct <- sql("SELECT prediction, label FROM predictions WHERE prediction = label")



count(correct)



acc <- count(correct)/count(predictions)



acc
