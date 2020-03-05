data.di.oggi <- Sys.Date()

# stampiamo l’oggetto
data.di.oggi


class(data.di.oggi)

Sys.time()


# creiamo un oggetto con una data
data.oggi <- as.Date("2016-02-21")
                      
                       
# e stampiamo
data.oggi

# possiamo anche scoprire che giorno è oggi con la funzione weekdays()
weekdays((data.oggi))

# possiamo sommare la nostra data a un numero:
data.oggi + 15

x <- 0:10
data.oggi + x

seq(data.oggi, by=2, length.out = 10)

as.Date("Jan-10-1997", format="%b-%d-%Y")


esempio.data2 <- "October 17, 2015, 12:57:10"
esempio.data2.formato <- "%B %d, %Y, %H:%M:%S"

data.completo <- as.POSIXct(esempio.data2, format=esempio.data2.formato, tz="GMT")

data.completo


data.completo2 <- as.POSIXlt(data.completo)

# e usiamo la funzione unclass() sul nostro oggetto per scomporlo
unclass(data.completo2)


date.gare <- c(
        "15:10:00 20/03/2015",
        "16:00:35 19/01/2016",
        "10:20:30 05/12/2014",
        "12:15:15 30/06/2015",
        "11:20:35 21/04/2015",
        "15:50:00 11/09/2015"
)

date.gare_str <- strptime(
        date.gare,
        "%H:%M:%S %d/%m/%Y",
        tz = "UTC"
)

date.gare

## lubridate

install.packages("lubridate")
library(lubridate)

esempi.date <- c(
        20150521,
        "1693-03 24",
        "2014.10.5",
        "2003/07\\19",
        "Giovedì+1997.10*24"
)

ymd(esempi.date)

# possiamo quindi parsare date in un formato giorno/mese/anno:
giornomeseanno <- dmy("04-12-2015")
giornomeseanno

# oppure mese/giorno/anno
mesegiornoanno <- mdy("12/27*2011")
mesegiornoanno

# la funzione ymd_hms() serve a specificare non solo anno/mese/giorno, ma anche ore/minuti/secondi: 
momento1 <- ymd_hms("2015,02,22 12:50:27")
momento1

# possiamo cambiare la prima parte della funzione come abbiamo visto negli esempi qua sopra
momento2 <- dmy_hms("22-02-2016 12:50:27")
momento2

# verifichiamo l'anno
oggi <- dmy("22-02-2016")
year(oggi)

# oppure il giorno
wday(oggi)

wday(oggi, label=TRUE)


# per aggiornare una data, aggiungendo dei giorni, dei minuti eccetera, possiamo usare la funzione update() 

dieci.minuti.fa <- dmy_hms("22-02-2016 12:00:30")

ora <- update(dieci.minuti.fa, minutes=10, seconds=01)
ora

# possiamo cambiare anche il valore delle ore, con l’argomento “hours=“

domani <- ora + days(1)
domani

# possiamo specificare il fuso orario con la funzione with_tz() 

fuso.orario <- with_tz(domani, "Europe/Rome")
fuso.orario

fuso.orario.brasile <- with_tz(domani, "America/Fortaleza")
fuso.orario.brasile







