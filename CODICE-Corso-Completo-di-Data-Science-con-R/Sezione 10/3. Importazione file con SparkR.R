# carichiamo i pacchetti e apriamo la sessione

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.3.2-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "local[*]")

# convertire dataset precaricati in R o altri file

df <- as.DataFrame(iris)

head(df)

# carichiamo un file e convertiamolo

df <- read.csv("churn.csv")

df_conv <- as.DataFrame(df)

# createDataFrame()

# carichiamo un file in .csv

df_csv <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn.csv",
                      source = "csv", header="true", inferSchema = "true")

# vediamo le prime occorrenze del DataFrame

head(df_csv)

# SparkR rileva automaticamente la struttura dei dati 

printSchema(df_csv)

# struttura della funzione read.df()

# read.df(path = NULL, source = NULL, schema = NULL, na.strings = "NA", ...)

# struttura della funzione per la lettura di database jdbc da url

# read.jdbc(url, tableName, partitionColumn = NULL, 
#          lowerBound = NULL, upperBound = NULL, numPartitions = 0L, predicates = list(), ...)


# per la lettura di file in JSON utilizziamo la funzione read.json()

read.json(path, ...)

# formato parquet

read.parquet(path, ...)

# formato testo

read.text(path, ...)


# scrivere file in vari formati

write.df(df, path = NULL, source = NULL, mode = "error", ...)

write.jdbc(x, url, tableName, mode = "error", ...)

write.json(x, path, ...)

write.parquet(x, path, ...)

write.text(x, path, ...)

# chiudiamo sempre la sessione quando abbiamo finito

sparkR.session.stop()
