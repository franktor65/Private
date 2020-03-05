install.packages("ggplot2")
library(ggplot2)

# visualizziamo la struttura del dataset 
str(mpg)

# i primi casi
head(mpg)

ggplot(mpg, aes(x = hwy, y = cty)) + geom_point()

ggplot(mpg, aes(x = hwy, y = cty))

ggplot(mpg, aes(x = hwy, y = cty, col = manufacturer)) + geom_point()

ggplot(mpg, aes(x = hwy, y = cty, size = cyl)) + geom_point()

ggplot(mpg, aes(x = hwy, y = cty)) + geom_point() + geom_smooth()

ggplot(mpg, aes(x = hwy, y = cty)) + geom_smooth()

ggplot(mpg, aes(x = hwy, y = cty)) + geom_smooth(linetype = 2)

ggplot(mpg, aes(x = hwy, y = cty)) + geom_smooth(linetype = 4)

ggplot(mpg, aes(x = hwy, y = cty)) + geom_smooth(se = FALSE)

ggplot(mpg, aes(x = hwy, y = cty, col = model)) + geom_point(alpha = 0.2)

ggplot(mpg, aes(x = hwy, y = cty, col = model)) + geom_point()

# creiamo il nostro oggetto
grafico1 <- ggplot(mpg, aes(x = hwy, y = cty)) + geom_point()

grafico1 + geom_smooth()

grafico1 + geom_point(aes(col = model))

grafico1 + geom_jitter() + facet_grid(. ~ year)

grafico1 + geom_jitter() + facet_grid(year~.)

grafico1 + geom_point(shape = 12, size = 4, alpha = 0.5)

grafico1 + geom_point(shape = 24, size = 5, alpha = 0.5)

grafico1 + geom_point(shape = 24, size = 5, alpha = 0.5, col = "green")

ggplot(mpg, aes(x = hwy, y = cty, col = cyl)) + geom_jitter()

ggplot(mpg, aes(x = hwy, y = cty, size = cyl, col = cyl)) + geom_jitter()

ggplot(mpg, aes(x = hwy, y = cty, col = cyl)) + geom_jitter(alpha = 0.2)

ggplot(mpg, aes(x = hwy, y = cty, col = cyl)) + geom_jitter(size= 6)

ggplot(mpg, aes(x = hwy, y = cty, col = cyl)) + geom_jitter(shape =3)

ggplot(mpg, aes(x = hwy, y = cty, label = cyl)) +  geom_text()

ggplot(mpg, aes(x = factor(cyl), fill = factor(cyl))) + geom_bar()

# per rendere più chiara la visualizzazione dell’istogramma, ho creato un oggetto mpg2 che contiene le prime 100 osservazioni del dataset mpg:
mpg2 <- mpg[1:100,]

# creiamo l’istogramma con “stack”
ggplot(mpg2, aes(x = manufacturer, fill = drv)) + geom_bar(position = "stack")

ggplot(mpg2, aes(x = manufacturer, fill = drv)) + geom_bar(position = "fill")

ggplot(mpg2, aes(x = manufacturer, fill = drv)) + geom_bar(position = "dodge")

ggplot(mpg, aes(cty)) + geom_freqpoly(binwidth = 1)






