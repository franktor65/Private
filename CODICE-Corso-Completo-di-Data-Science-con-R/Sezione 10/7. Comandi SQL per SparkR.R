# apriamo la sessione

Sys.setenv(SPARK_HOME = "/spark/spark-2.3.1-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"))) 

sparkR.session()  

# carichiamo il DataFrame

df <- as.DataFrame(iris)

# creiamo la tabella temporanea

createOrReplaceTempView(df, 'iris2')

# a questo punto possiamo utilizzare il linguaggio SQL per estrarre dei dati o riepilogarli

collect(sql("SELECT * FROM iris2 LIMIT 5"))

collect(sql("SELECT * FROM iris2 WHERE Petal_Width > 1.5"))

collect(sql("SELECT Species, 
     avg(Sepal_Length) avg_sepal_length,
            avg(Sepal_Width) avg_sepal_width
            FROM iris2 
            GROUP BY Species
            ORDER BY avg_sepal_length desc"))

# infine chiudiamo la sessione

sparkR.session.stop()
