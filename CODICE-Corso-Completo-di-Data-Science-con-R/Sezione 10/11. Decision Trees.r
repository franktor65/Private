# Databricks notebook source
# alberi di decisione


library(SparkR)


df <- read.df(source = "csv", path = "/FileStore/tables/winsconsin_breast_cancer", header = "true", inferSchema = "true")


head(df,2)


# https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/breast-cancer-wisconsin.names


df$Class <- ifelse(df$Class == 2, 0, 1)


sample <- randomSplit(df, c(0.7, 0.3), seed = 12345)
train <- sample[[1]]
test <- sample[[2]]


head(train, 2)


model <- spark.decisionTree(train, Class ~ Clump_Thickness + Uniformity_of_Cell_Size + Uniformity_of_Cell_Shape +
                           Marginal_Adhesion + Single_Epithelial_Cell_Size + Bare_Nuclei +
                            Bland_Chromatin + Normal_Nucleoli + Mitoses, "classification")


summary(model)


predictions <- predict(model, test)


head(predictions, 2)


createOrReplaceTempView(predictions, 'predictions')

correct <- sql("SELECT prediction, Class FROM predictions WHERE prediction = Class")

count(correct)

acc <- count(correct)/count(predictions)
acc


# possono essere utilizzati anche con variabili qualitative


t <- as.data.frame(Titanic)
df2 <- createDataFrame(t)


head(df2)


model2 <- spark.decisionTree(df, Survived ~ Freq + Age, "classification")


# alberi di regressione


model <- spark.decisionTree(train, label ~ var1 + var2 + var3, "regression")
