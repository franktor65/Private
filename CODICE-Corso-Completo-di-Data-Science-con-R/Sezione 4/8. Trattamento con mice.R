test <- read.csv("missing_test2.csv")

mice.es <- mice(test)

mice.es

mice.es$imp$ex2

test2 <- complete(mice.es,1)

test2

