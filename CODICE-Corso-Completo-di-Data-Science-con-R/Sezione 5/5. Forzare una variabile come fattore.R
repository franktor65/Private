df <- data.frame(name = c("Laura", "Simon", "Katherine", "Francis", "Joseph", "Rosie"), 
                 heights = c("163", "180", "165", "169", "178", "164"),
                 sex = c("f", "m", "f", "m", "m", "f"))


df

str(df)

df$heights <- as.integer(df$heights)

df

df$heights <- as.integer(as.character(df$heights))

df

str(df)

# df <- data.frame(“indirizzo.file.csv”, stringsAsFactors = FALSE)