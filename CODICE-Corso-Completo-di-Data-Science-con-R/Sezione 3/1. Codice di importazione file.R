# creiamo un oggetto Random dove importiamo il nostro file
Random <- read.table("inserire nome file più estensione csv o tsv", header=TRUE, sep=";", stringsAsFactors = FALSE)

# per prima cosa installiamo il pacchetto xlsx
install.packages("xlsx")

# in secondo luogo lo richiamiamo
library(xlsx)

# importiamo un file con xlsx e creiamo un oggetto in cui storarlo
oggetto.excel <- read.xlsx("inserire nome file xlsx", sheetIndex=1)

# esportazione di un file

esempio <- 1:50
save(esempio, file="nome.file.esempio.rda")


