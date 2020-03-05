### knn - ex1

X1 <- c(1,2)
X2 <- c(3,4)
X3 <- c(5,5)
X4 <- c(2.5,3)
X5 <- c(3.5,5)

Y1 <- c(10,12)
Y2 <- c(13,10.5)
Y3 <- c(11,13.5)
Y4 <- c(12.5,14)
Y5 <- c(16,11.5)


train <- rbind(X1, X2, X3, X4, X5, Y1, Y2, Y3, Y4, Y5)


cl <- factor(c(rep("class1",5), rep ("class2", 5)))


test <- c(4,5)

knn(train, test, cl, k=1)

summary(knn(train, test, cl, k=1))



test2 <- c(16, 11)

summary(knn(train, test2, cl, k =1))


### knn - ex2

X6 <- c(1,2,4)
X7 <- c(3,4,5)
X8 <- c(5,5,6)
X9 <- c(2.5,3,5.5)
X10 <- c(3.5,5,6)

Y6 <- c(10,12,10)
Y7 <- c(13,10.5,12)
Y8 <- c(11,13.5,12)
Y9 <- c(12.5,14,15)
Y10 <- c(16,11.5,14)

train <- rbind(X6, X7, X8, X9, X10, Y6, Y7, Y8, Y9, Y10)
train



cl <- factor(c(rep("class1",5), rep ("class2", 5)))
cl


test <- c(4,5,6)

summary(knn(train, test, cl, k=1))


test2 <- c(16, 11,14)

summary(knn(train, test2, cl, k = 1))

### knn - ex3

str(iris)

dim(iris)

View(iris)

table(iris$Species)


set.seed(12345)
random <- runif(nrow(iris))
iris2 <- iris[order(random),]

min.max <- function(x) {
        num <- x - min(x)
        denom <- max(x) - min(x)
        return (num/denom)
}


iris3 <- min.max(iris2[,1:4])

iris4 <- as.data.frame(lapply(iris2[,1:4], min.max))


iris_train <- iris3[1:105,]
iris_test <- iris3[106:150,]

head(iris_train)
head(iris_test)


cl_iris_train <- iris2[1:105, 5]
cl_iris_test <- iris2[106:150, 5]


mk <- knn(train = iris_train, test = iris_test, cl = cl_iris_train, k = 12)

summary(knn(iris_train, iris_test, cl_iris_train, k = 12))

table(mk, cl_iris_test)




