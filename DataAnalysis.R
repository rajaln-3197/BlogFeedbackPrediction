train <- read.csv("blogData_train.csv",header=F)
require(ggplot2)
require(corrplot)

##Zero percentage
isZero <- sum(train$V281 == 0)
isNonZero <- sum(train$V281 != 0)
pie(c(isZero,isNonZero), labels=percent, col=c("skyblue","darkorange"))
legend("top", legend=c("Zero","NonZero"), fill=c("skyblue","darkorange"),horiz=T,bty='n')
## NonZero distribution
comments <- train$V281
comments <- comments[comments != 0]
ggplot(data.frame(x=comments), aes(x)) + 
  geom_histogram(bins=200) +
  labs(x="Nonzero comments in next 24h", y="Counts")+
  theme(text = element_text(size=14))+
  scale_y_sqrt()

## correlation
corrs <- c()
for (i in 1:280) {
  corrs <- c(corrs, cor(train[,i], train[, 281]))
}
corrs[is.na(corrs)] <- 0
corrs <- abs(corrs)
corrs[order(corrs,decreasing = T)[1:10]]
# make correlation matrix plot
foo <- train[,c(10,21,6,5,11,281)]
corrplot.mixed(cor(foo), upper="shade")

## correlation
corrs <- c()
for (i in 270:276)
{
  corrs <- c(corrs, cor(train[,i], train[, 281]))
}
corrs[is.na(corrs)] <- 0
corrs <- abs(corrs)
corrs[order(corrs,decreasing = T)[1:10]]
# make correlation matrix plot
foo <- train[,c(270,271,272,273,274,275,276,281)]
corrplot.mixed(cor(foo), upper="shade")

# words
foo <- train[, 63:262]
word_freq <- colSums(foo)
plot(word_freq, type="h", col="blue4", main="Word Frequency", ylab="Count", xlab="Words", cex.lab=1.2)
points(word_freq, pch=16, col="blue4",cex=0.6)
foo <- c()
for (i in 63:262) {
  supAB <- sum(train[, i] == 1 & train[, 281] > 0)
  supA <- sum(train[, i] == 1)
  foo <- c(foo, supAB/supA)
}
plot(foo, type="h", col="blue4", main="Conditional probability", ylab="P(Comments>0 | word appears in the post)", xlab="Words", cex.lab=1.2)
points(foo, pch=16, col="blue4",cex=0.6)

# influence of weekday
basetimeday <- rep(0,nrow(train))
publishday <- rep(0,nrow(train))
for ( i in 1:7) {
  basetimeday[train[, (262+i)] == 1] <- i
  publishday[train[, (269+i)] == 1] <- i
}
foo <- data.frame(basetimeday=basetimeday, publishday=publishday, comment=log10(train[, 281]+1))

ggplot(foo, aes(factor(publishday), comment))+
  geom_bar(stat="identity")+
  labs(x="Weekday of the Publication day", y="Number of comments")+
  theme(text=element_text(size=14))

#https://github.com/hncpr1992/BlogFeedBackProject