stud <- c("licenza_elementare","licenza_media","diploma_superiore","laurea","master","dottorato","laurea","licenza_elementare","licenza_media","licenza_elementare", "diploma_superiore")

red <- c(12000,23000,35000,47000,55000,67000,43000,15000, 25000,15000,31500)

df <- cbind(stud, red)

df <- as.data.frame(df)

df$stud <- factor(df$stud,levels = c("licenza_elementare","licenza_media","diploma_superiore","laurea","master","dottorato"),
                         labels = c(1, 2, 3, 4, 5, 6))
