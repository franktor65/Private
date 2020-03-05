# carichiamo i pacchetti e apriamo la sessione

Sys.setenv(SPARK_HOME = "/Users/valentinaporcu/spark/spark-2.3.0-bin-hadoop2.7")

library(SparkR, lib.loc = c(file.path(Sys.getenv("SPARK_HOME"), "R", "lib")))

sparkR.session(master = "local[*]")


# carichiamo il dataset

df <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/cereals.csv",
                  source = "csv", header="true", inferSchema = "true")

# visualizziamo le prime occorrenze

head(df)

# creiamo un oggetto che contiene un primo riepilogo dei dati, creato con la funzione describe()
sum1 <- describe(df)

showDF(sum1)

# possiamo riepilogare anche un'unica variabile

sum2 <- describe(df, 'sodium')

showDF(sum2)

# possiamo aggregare i dati di una variabile attorno a una misura statistica, ad esempio la media

cal_avg <- agg(df, mean = mean(df$calories))

showDF(cal_avg)

# misure di dispersione

range1 <- agg(df, minimum = min(df$calories), maximum = max(df$calories), 
              range_width = abs(max(df$calories) - min(df$calories)))

showDF(range1)

# varianza

cal_var <- agg(df, variance = var(df$calories))  
showDF(cal_var)

# deviazione standard

cal_sd <- agg(df, std_dev = sd(df$calories)) 
showDF(cal_sd)

# quartili

quartiles <- approxQuantile(x = df, col = "sodium", 
                            probabilities = c(0.25, 0.5, 0.75), 
                            relativeError = 0.001)

quartiles

# skewness

df_sk <- agg(df, skewness = skewness(df$sodium))
showDF(df_sk)

# kurtosis

df_kr <- agg(df, kurtosis = kurtosis(df$sodium))
showDF(df_kr)


# covarianza e correlazione

cov1 <- cov(df, "calories", "fiber")
cov1

corr1 <- corr(df, "calories", "fiber", method = "pearson")
corr1

# se abbiamo dei dati categorici

df2 <- read.df("/Users/valentinaporcu/Dropbox/topic/11.\ Guida\ ai\ Big\ Data\ con\ R/codice\ -\ guida\ ai\ big\ data\ con\ R/Sezione\ 2/churn.csv",
                  source = "csv", header="true", inferSchema = "true")

sum1 <- count(groupBy(df2, "gender"))
showDF(sum1)

# calcoliamo le percentuali sulle variabili categoriche

n <- nrow(df2)
perc1 <- agg(groupBy(df2, df2$gender), Count = n(df2$gender), 
             Percentage = n(df2$gender) * (100/n))

showDF(perc1)

crosst1 <- crosstab(df2, "label", "gender")

crosst1

# una volta terminate le nostre analisi, interrompiamo la sessione

sparkR.session.stop()
