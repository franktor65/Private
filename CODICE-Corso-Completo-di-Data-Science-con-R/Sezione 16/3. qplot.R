## qplot()

qplot(hwy, cty, data=mpg)

qplot(hwy, cty, data = mpg, size = factor(manufacturer))

qplot(hwy, cty, data = mpg, col = manufacturer)

qplot(hwy, cty, data = mpg, color= manufacturer, geom = c("point", "smooth"))

qplot(hwy,cty, data=mpg, geom="boxplot")

qplot(manufacturer, data = mpg)

qplot(manufacturer, data = mpg, fill = manufacturer)

qplot(hwy, data = mpg, facets = drv ~ ., binwidth = 3)

qplot(hwy, data = mpg, facets = .~ drv, binwidth = 3)
