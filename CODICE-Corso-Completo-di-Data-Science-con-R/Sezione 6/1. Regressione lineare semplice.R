stud <- c(1,2,3,4,5,6,4,1,2,1, 3)

red <- c(12000,23000,35000,47000,55000,67000,43000,15000, 25000,15000,31500)

red.stud <- cbind(stud, red)

red.stud <- as.data.frame(red.stud)


plot(red.stud)


lm(red.stud$red ~ red.stud$stud)

lm(red ~ stud, data = red.stud)


regr.r <- lm(red.stud$red ~ red.stud$stud)

abline(regr.r)

