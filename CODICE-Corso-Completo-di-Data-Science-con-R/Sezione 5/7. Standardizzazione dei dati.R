min.max <- function(x) {
        num <- x - min(x)
        denom <- max(x) - min(x)
        return (num/denom)
}


(x-mean(x)) / sd(x)

summary(iris$Sepal.Length)

scaled <- scale(iris$Sepal.Length)
summary(scaled)