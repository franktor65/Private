# carichiamo i pacchetti e apriamo la sessione

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.4.0-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "local[*]", sparkConfig = list(spark.driver.memory = "2g"))

# caricare file in .csv

df_csv <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn.csv",
                  source = "csv", header="true", inferSchema = "true")

# vediamo i primi casi del DataFrame

head(df_csv)

# il numero di righe

nrow(df_csv)

# il numero di colonne

ncol(df_csv)

# lo schema del DataFrame

schema(df_csv)

# possiamo decidere noi lo schema del DataFrame stabilendo il tipo di variabile

# schema <- structType(structField("gender", "string"), 
#                     structField("age", "integer"), 
#                     structField("paymethod", "integer"), 
#                     structField("last_trans", "integer"),
#                     structField("label", "integer"))

# path <- "/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/churn.csv"

# schema_test <- read.df(path, 
#                   header = "true", 
#                   schema = schema, nullValue = "NA")

# schema(schema_test)

# eliminiamo la prima colonna

df_csv <- df_csv[, -1]

head(df_csv)


# leggiamo il secondo file csv

df2_csv <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn2.csv",
                  source = "csv", header="true", inferSchema = "true")

# vediamo i primi casi

head(df2_csv)

# eliminiamo la prima colonna

df2_csv <- df2_csv[, -1]

head(df2_csv)

# se volessimo rinominare le colonne del dataset

new_colnames <- c('gender', 'age', 'paymethod', 'last_trans', 'label')

names(df_csv) <- new_colnames

# uniamo i due csv in un unico oggetto

df_tot <- rbind(df_csv, df2_csv)

# visualizziamo lo schema

printSchema(df_tot)

# possiamo ottenere un riepilogo dei nostri dati in questo modo

system.time(desc1 <- describe(df_tot))

collect(desc1)

# vediamo i primi casi del dataset completo

showDF(df_tot)

# il numero di righe

nrow(df_tot)

# un riepilogo dei dati

describe(df_tot)

# vediamo un riepilogo sulla variabile gender

head(summarize(groupBy(df_tot, df_tot$gender), count = n(df_tot$gender)))

# possiamo aggregare i casi per ottenere dei riepiloghi in base ai nostri bisogni
# ad esempio di seguito aggreghiamo i dati per ottenere 
# la cifra media spesa nell'ultima transazione

ob1 <- agg(df_tot, last_trans_avg = avg(df_tot$last_trans))

showDF(ob1)

# aggreghiamo i casi in base al metodo di pagamento
# quindi vediamo la media dei pagamenti differenziata in base al metodo di pagamento

gr1 <- groupBy(df_tot, df_tot$paymethod)

df2 <- agg(gr1, last_trans_avg = avg(df_tot$last_trans))

head(df2)

# di seguito aggreghiamo invece la media delle cifre spese in base al genere

gr2 <- groupBy(df_tot, df_tot$gender)

df3 <- agg(gr2, last_trans_avg = avg(df_tot$last_trans))

head(df3)

# riordiniamo il dataset in base a una delle variabili numeriche
# posta in ordine descrescente

df4 <- arrange(df_tot, desc(df_tot$last_trans))  

head(df4)

# oppure in base alla variabile dell'età posta in maniera crescente

df5 <- arrange(df_tot, "age", decreasing = FALSE)

head(df5)


# qui di seguito aggreghiamo invece la media delle cifre spese in base al genere

gr3 <- groupBy(df_tot, df_tot$label, df_tot$gender)

df3 <- agg(gr3, last_trans_avg = avg(df_tot$last_trans))

head(df3)


# come si può vedere i valori mancanti impattano sul nostro riepilogo, quindi per ora li eliminiamo

# consideriamo solo i casi completi

comp_cas <- dropna(df_tot)

gr3 <- groupBy(comp_cas, comp_cas$label, comp_cas$gender)

df3 <- agg(gr3, last_trans_avg = avg(comp_cas$last_trans))

head(df3)

# possiamo anche utilizzare la notazione con il pipe, grazie al pacchetto magrittr

library(magrittr)

df_tot2 <- filter(df_tot, df_tot$last_trans > 200) %>%
        group_by(df_tot$gender)%>%
        summarize(mean=mean(df_tot$last_trans))

arrange(df_tot2, desc(df_tot2$mean)) %>% head

# spostiamo una parte dei casi trasformandolo in un dataset normale

df_loc <- take(df_tot, num = 1500)

class(df_loc)

class(df_tot)

# riprendendo il nostro dataset totale, filtriamo i casi 
# in base ad alcune condizioni

f1 <- filter(df_tot, df_tot$gender == 'F' | df_tot$age > 40)

showDF(f1)
nrow(f1)

# filtriamo in base al metodo di pagamento e alla classificazione

f2 <- filter(df_tot, df_tot$paymethod != "cash" & df_tot$label != "loyal")

showDF(f2)
nrow(f2)

# filtriamo in base all'età 

f3 <- filter(df_tot, df_tot$age > 60)

head(f3)
nrow(f3)

# possiamo selezionare alcune variabili

s1 <- select(df_tot, df_tot$gender, df_tot$paymethod, df_tot$label)

head(s1)

s2 <- select(df_tot, 'label', 'gender')

head(s2)

# possiamo selezionale le variabili con varie sintassi

# head(select(df, df$var1))

# head(select(df, "var1"))

# head(filter(df, df$var1 > 5))

# head(count(groupBy(df, df$var1)))

# estrarre un campione dal nostro DataFrame

samp1 <- sample(df_tot, withReplacement = FALSE, fraction = 0.2)  

count(samp1)

# estrarre un campione con un seed

samp2 <- sample(df_tot, withReplacement = FALSE, fraction = 0.3, seed = 12345)

count(samp2)

# creare un riepilogo dei nostri dati

sum1 <- summarize(groupBy(df_tot, df_tot$gender), count = n(df_tot$gender))

head(sum1)

# aggiungere una colonna

df_tot$new_col <- df_tot$last_trans * 10

head(df_tot)

# carichiamo altri due dataset 

df1 <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn2.csv",
                  source = "csv", header="true", inferSchema = "true")

head(df1)

df1 <- df1[, -1]

head(df1)

df2 <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn3.csv",
               source = "csv", header="true", inferSchema = "true")


head(df1)
head(df2)

# come si può vedere dobbiamo prima modificare i nomi delle colonne prima di unire
# i due dataset

new_colnames <- c('gender', 'age', 'paymethod', 'last_trans', 'label')

names(df2) <- new_colnames

head(df2)

# uniamo i due dataset

df <- rbind(df1, df2)

sum1 <- summarize(groupBy(df, df$gender), count = n(df$gender))

head(sum1)

# modifichiamo i dati in modo da unificare le modalità

df$gender <- regexp_replace(df$gender, 'female', 'F')
df$gender <- regexp_replace(df$gender, 'male', 'M')

sum2 <- summarize(groupBy(df, df$gender), count = n(df$gender))

head(sum2)


# alla fine delle nostre analisi, dobbiamo sempre ricordare di chiudere la sessione

sparkR.session.stop()
