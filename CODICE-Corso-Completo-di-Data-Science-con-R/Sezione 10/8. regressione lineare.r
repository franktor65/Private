# regressione lineare

# dataset iris

df <- as.DataFrame(iris)


# vediamo i primi casi

head(df)


# analizziamo lo schema dati

printSchema(df)


# ricaviamo un oggetto di train e di test


train <- sample(df, F, 0.7)
test <- sample(df, F, 0.3)



model <- glm(Sepal_Length ~ Sepal_Width + Species, data = train, family = 'gaussian')



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
