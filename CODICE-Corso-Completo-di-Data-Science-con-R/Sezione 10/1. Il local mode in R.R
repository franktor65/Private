# localizziamo la cartella che contiene Spark sul nostro computer e copiamo l'indirizzo

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.3.2-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"))) 

install.packages(c("rJava", "rmarkdown", "ggplot2", "pipeR", "whisker", "data.table", "reshape2"))


