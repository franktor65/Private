install.packages("arules")
library(arules)

data(Groceries)
summary(Groceries)


inspect(Groceries[10:15])

itemFrequencyPlot(Groceries, support = 0.1)

itemFrequencyPlot(Groceries, topN = 15)

itemFrequency(Groceries)

tabella <- crossTable(Groceries)
tabella[1:5, 1:5]

regole <- apriori(Groceries, parameter = list(support = 0.1, confidence = 0.7))

regole <- apriori(Groceries, parameter = list(support = 0.01, confidence = 0.1))

head(interestMeasure(regole, c("support", "confidence", "lift", "chisquare", "cosine", "coverage", "leverage", "oddsRatio"), Groceries))

regole.conf <- sort(regole, by = "confidence")
regole.lift <- sort(regole, by = "lift")


inspect(regole[1:20])

summary(regole)

inspect(sort(regole, by = "lift")[1:10])

library(arulesViz)
plot(regole[1:10], method = "graph", interactive = TRUE, shading = TRUE)

beef <- subset(regole, items %in% "beef")

inspect(beef)

tabella["butter", "yogurt"]

write(regole, "regole.csv", sep = "," , quote = TRUE, row.names = FALSE)

beni <- read.transactions("transactions.csv", sep = ",")
