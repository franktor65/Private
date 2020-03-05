# carichiamo i pacchetti e apriamo la sessione

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.3.1-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))


# creiamo un dataset
df <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/students_spark1.csv",
              source = 'csv',
              header = 'true',
              inferSchema = 'true')

head(df)

nrow(df)

# eliminiamo i casi duplicati

df <- dropDuplicates(df)

nrow(df)


# aggiungiamo una nuova colonna

df2 <- withColumn(df, "media", (df$mark1 + df$mark2 + df$mark3)/3)

head(df2)


# eliminiamo i missing

df3 <- na.omit(df2, how = 'any')

nrow(df3)


# col metodo eliminiamo i missing soltanto se un'intera riga è vuota

df4 <- na.omit(df2, how = 'all')

nrow(df4)


# chiudiamo la sessione
sparkR.session.stop()
