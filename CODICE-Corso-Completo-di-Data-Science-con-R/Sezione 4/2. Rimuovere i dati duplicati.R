test.dup <- c(1,2,3,1,2,3,4,5,5,7,7,8,9,9,1,1,2)

duplicated()


duplicated(test.dup)

which(duplicated(test.dup))

t2 <- test.dup[!duplicated(test.dup)]

t2
