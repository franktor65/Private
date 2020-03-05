install.packages("neuralnet")
library(neuralnet)

library(mlbench)
data(PimaIndiansDiabetes)

pid <- PimaIndiansDiabetes

pid$diabetes <- ifelse(pid$diabetes == "pos", 1, 0)

train <- pid[1:500,]

test <- pid[501:768,]

nn2 <- neuralnet(diabetes ~ pregnant + glucose + 
                         pressure + triceps + insulin + mass + 
                         pedigree + age, train, err.fct = "ce", 
                 linear.output = FALSE, likelihood = TRUE, stepmax=1e6)


n <- names(pid)
formula <- as.formula(paste("diabetes ~", paste(n[!n %in% "diabetes"], collapse = " + ")))

neuralnet(formula, train, err.fct = "ce", linear.output = FALSE, likelihood = TRUE)

plot(nn2)

nn2$net.result
nn2$weights
nn2$result.matrix
nn2$covariate

library(NeuralNetTools)

garson(nn2)

olden(nn2)

pred <- compute(nn2, test[,1:8])

predictions <- ifelse(pred$net.result > 0.5,1,0)

table(predictions, test$diabetes)

caret::confusionMatrix(predictions, test$diabetes)

