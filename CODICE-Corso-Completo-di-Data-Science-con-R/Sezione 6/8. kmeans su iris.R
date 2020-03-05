# kmeans

iris2 <- iris[, 1:4]
head(iris2)

iris_kmeans <- kmeans(iris2, 3)
iris_kmeans

table(iris$Species, iris_kmeans$cluster)

plot(Petal.Length ~ Petal.Width, data = iris2, col = iris_kmeans$cluster)

barplot(t(iris_kmeans$centers), beside = TRUE,xlab="cluster", ylab="value")

plot(iris[,1:4], col = iris_kmeans$cluster)