Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.4.0-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib"))) 


sparkR.session()  

# creiamo un dataset NORMALE

df1 <- data.frame(name = c('Rosie', 'Simon', 'Kate'), age = c(68, 32, 64))

class(df1)

# possiamo convertirlo in DataFrame in uno dei due modi qua sotto

df2 <- as.DataFrame(df1)

df3 <- createDataFrame(df1)

# verifichiamo la classe dei due DataFrame

class(df2)

class(df3)

# possiamo anche creare un DataFrame con uno dei dataset precaricati

df4 <- createDataFrame(iris)

class(df4)

head(df4, 4)

nrow(df4)

ncol(df4)

class(df4) 

# per leggere un file da una fonte esterna, possiamo procedere così

df5 <- read.df('/Users/valentinaporcu/Desktop/churn.csv',
               source = 'csv',
               header = 'true',
               inferSchema = 'true')

# verifichiamo la struttura e le informazioni sui nostri dati

class(df5)

str(df5)

# possiamo verificare alcuni casi in vari modi

head(df5)

take(df5, 5)

showDF(df5, 3)

# verifichiamo un sommario dei dati come segue

desc1 <- describe(df5)
collect(desc1)

# possiamo ordinare i dati in base a una delle variabili

collect(orderBy(df5, "age"))

# carichiamo il pacchetto magrittr oppure dplyr per utilizzare il pipe 

library(magrittr)

df5 %>% 
        groupBy("gender") %>% 
        count() %>% 
        collect()

df5 %>% 
        groupBy("label") %>% 
        count() %>% 
        collect()

# salviamo il risultato ottenuto in due oggetti per creare i grafici

df6 <- df5 %>% 
        groupBy("gender") %>% 
        count() %>% 
        collect()

barplot(df6$count, names.arg = df6$gender, col = topo.colors(2), main = 'Generi')

df7 <- df5 %>% 
        groupBy("paymethod") %>% 
        count() %>% 
        collect()

barplot(df7$count, names.arg = df7$paymethod, col = rainbow(3), main = 'Metodi di pagamento')

# possiamo anche filtrare una parte dei casi

filter <- filter(df5, "age > 35")
sel1 <- select(filter, c('paymethod', 'gender'))
showDF(sel1)


# salvando nei due modi che seguono i DataFrame andremo a creare una cartella sulla nostra
# working directory, contenente il dataset

saveDF(df5, path = "spark-test", source = "csv", mode = "error")

write.df(df5, path = "spark-test2", source = "csv", mode = "overwrite")

# quando finiamo una sessione di analisi, dobbiamo sempre interrompere la sessione di Spark
# con uno dei due comandi seguenti

sparkR.session.stop()

sparkR.stop()

