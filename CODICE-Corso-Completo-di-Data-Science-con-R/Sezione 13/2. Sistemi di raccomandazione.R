# installiamo e richiamiamo il pacchetto

install.packages('recommenderlab')
library(recommenderlab)

# visualizziamo i dataset disponibili in recommenderlab

data(package = "recommenderlab")

# usiamo il pacchetto Movielense

data(MovieLense)
MovieLense

# visualizziamo i dati

vec1 <- as.vector(MovieLense@data)
unique(vec1)

vec2 <- vec1[vec1 != 0]

table(vec2)

qplot(vec2, binwidth = 0.5)


vis_film <- colCounts(MovieLense)

df1 <- data.frame(
        movie = names(vis_film),
        views = vis_film)

tab1 <- df1[order(df1$views, decreasing = TRUE), ]

# film più visti

ggplot(df1[1:10, ], aes(x = movie, y = views)) +
        geom_bar(stat="identity") +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        ggtitle("Film più visti")


# media delle recensioni

mediar <- colMeans(MovieLense)


qplot(mediar) +
        stat_bin(binwidth = 0.2) +
        ggtitle("Media delle recensioni")

# creiamo i due oggetti di train

sample1 <- sample(1:nrow(MovieLense), size=0.9*nrow(MovieLense), replace = F)
train <- MovieLense[sample1, ]
test <- MovieLense[-sample1, ]

rec_model <- Recommender(data = train, method = "UBCF")  
rec_model
getModel(rec_model) 


# test
n_rec <- 10
recommendations <- predict(object = rec_model, newdata = test, n = n_rec)
recommendations

recommendations@ratings
recommendations@items
recommendations@itemLabels

reco_out <- as(recommendations, "list")
reco_out


# migliori raccomandazioni
top3 <- bestN(recommendations, 3)
top3
as(top3, "list")


# film più popolari
rec_model_POPULAR <- Recommender(data = train, method = "POPULAR") 
rec_model_POPULAR

n_rec <- 5
recommendations <- predict(object = rec_model_POPULAR, 
                           newdata = test, n = n_rec)

recommendations
as(recommendations, "list")


# possiamo anche utilizzare il dataset senza splittare in train e test set 

# user-based collaborative filtering (UBCF)

rc <- Recommender(MovieLense, method = "UBCF")
rc

recom <- predict(rc, MovieLense, n=5)
recom

head(as(recom,"list"))

# metodo casuale

rc <- Recommender(MovieLense, method = "RANDOM")
rc

recom <- predict(rc, MovieLense, n=5)
recom

head(as(recom,"list"))

# SVD

rc <- Recommender(MovieLense, method = "SVD")
rc

recom <- predict(rc, MovieLense, n=5)
recom

head(as(recom,"list"))

# sistema ibrido

recom <- HybridRecommender(
        Recommender(MovieLense, method = "POPULAR"),
        Recommender(MovieLense, method = "RANDOM"),
        Recommender(MovieLense, method = "RERECOMMEND"),
        weights = c(.6, .1, .3)
)

recom

getModel(recom)

as(predict(recom, MovieLense), "list")


# creiamo una realratingmatrix

set.seed(12345)
laura <- sample(1:5, 10, replace = TRUE)
francis <- sample(1:5, 10, replace = TRUE)
kate <- sample(1:5, 10, replace = TRUE)
simon <- sample(1:5, 10, replace = TRUE)
john <- sample(1:5, 10, replace = TRUE)
joseph <- sample(1:5, 10, replace = TRUE)
mary <- sample(1:5, 10, replace = TRUE)
rosy <- sample(1:5, 10, replace = TRUE)
jane <- sample(1:5, 10, replace = TRUE)
chris <- sample(1:5, 10, replace = TRUE)


mat <- rbind(laura, francis, kate, simon, john, joseph, mary, rosy, jane, chris)

colnames(mat) <- c("HP1", "Blade Runner", "Dirty Dancing", "X-men2", "Hunger Games3", "Van Helsing", "Limitless", "Jumper", "Ex-machina", "Ant-man")

mat

dist(mat, method = 'euclidean')

dist(t(mat), method = 'euclidean')

rrm <- as(mat, "realRatingMatrix")

dimnames(rrm)
rowCounts(rrm)
colCounts(rrm)
rowMeans(rrm)

# verifichiamo gli utenti simili
similar_users <- similarity(rrm, method = "cosine", which = "users")  

similar_users

similar_users[is.na(similar_users)] <- 0  
similar_users <- round(similar_users, 2)  
plot(hclust(similar_users))

# verifichiamo gli oggetti simili
similar_items <- similarity(rrm, method = "cosine", which = "items")
similar_items[is.na(similar_items)] <- 0  
similar_items <- round(similar_items, 2)  
plot(hclust(similar_items))

