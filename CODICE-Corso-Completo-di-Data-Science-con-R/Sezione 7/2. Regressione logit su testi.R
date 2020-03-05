library(kernlab)
data(spam)

set.seed(12345)
random <- runif(nrow(spam))
spam2 <- spam[order(random),]

spam2$type <- ifelse(spam2$type == "spam", 0, 1)

library(plyr)
spam2$type <- revalue(spam2$type, c("spam"="0", "nonspam"="1"))

train <- spam2[1:3500,]
test <- spam2[3501:4601,]

mod <- glm(type ~., data=train, family=binomial(logit))

pred <- predict(mod, test, type='response')

val <- test[, 58]
sqrt(mean((pred - val)^2))


cbind(round(pred), val)

table(round(pred), test$type)
