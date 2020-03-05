x <- c(10, 15, 19, NA, 45, 67, 84, NA, 14, 22, 18)

mean(x)

mean(x, na.rm = TRUE)

x[is.na(x)] <- mean(x, na.rm = TRUE)

x

round(x)

x <- c(10, 15, 19, NA, 45, 67, 84, NA, 14, 22, 18)
median(x, na.rm=TRUE)

x[is.na(x)] <- median(x, na.rm = TRUE)

x
