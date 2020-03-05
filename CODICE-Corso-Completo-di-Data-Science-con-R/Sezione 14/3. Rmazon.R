devtools::install_github("56north/Rmazon")

library(Rmazon)

info <- get_product_info("B006YDFXT0", domain = "it")

reviews <- get_reviews("B006YDFXT0", domain = "it")

reviews

show(reviews)

reviews$reviewText

reviews$reviewRating
