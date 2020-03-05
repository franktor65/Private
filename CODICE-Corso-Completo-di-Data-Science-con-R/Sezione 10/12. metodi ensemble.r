# Random Forest

df <- sql("SELECT * FROM pid")


head(df)

# convertire la variabile label

df$diabetes <- ifelse(df$diabetes == 'pos', 1, 0)

# estrarre il train e il test

sample <- randomSplit(df, c(0.7, 0.3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]


# impostare il modello predittivo

model <- spark.randomForest(train, diabetes ~ glucose + triceps + mass + pedigree, "classification", numTrees = 40)

# computare le predizioni


predictions <- predict(model, test)

# valutare l'accuratezza


createOrReplaceTempView(predictions, 'predictions')

correct <- sql("SELECT prediction, diabetes FROM predictions WHERE prediction = diabetes")

count(correct)

acc <- count(correct)/count(predictions)
acc


# Gradient Boosting 


gbt_model <- spark.gbt(train, diabetes ~ pregnant + glucose 
                            + pressure + triceps + insulin + mass 
                            + pedigree + age, "classification", maxIter = 10)

# riepilogo del modello
summary(gbt_model)

# predizioni
predictions <- predict(gbt_model, test)
head(predictions)

head(select(predictions, "diabetes", "prediction"))

createOrReplaceTempView(predictions, "predictions")

correct <- sql("SELECT prediction, diabetes FROM predictions WHERE prediction = diabetes")

count(correct)

acc <- count(correct)/count(predictions)
acc

# regressione con Random Forest

df <- as.DataFrame(iris)


# vediamo i primi casi

head(df)


# analizziamo lo schema dati

printSchema(df)


# ricaviamo un oggetto di train e di test


train <- sample(df, F, 0.7)
test <- sample(df, F, 0.3)


model <- spark.randomForest(train, Sepal_Length ~ Sepal_Width + Petal_Length + Petal_Width, "regression", numTrees = 40)


prediction <- predict(model, test)



head(select(prediction, "Sepal_Length", "prediction"))



# media della variabile Sepal_Length

smean <- collect(agg(train, mean= mean(train$Sepal_Length)))$mean



smean



# quadrato dei residui e quadrato totale

prediction<-transform(
  prediction,
  s_res=(prediction$Sepal_Length - prediction$prediction)**2,
  s_tot=(prediction$Sepal_Length - smean)**2)



head(select(prediction, "Sepal_Length", "prediction", "s_res", "s_tot"))



# somma dei quadrati

res<-collect(agg(prediction, 
                 ss_res=sum(prediction$s_res),
                 ss_tot=sum(prediction$s_tot)))



res



# R2

R2 = 1-(res$ss_res/res$ss_tot)



R2

