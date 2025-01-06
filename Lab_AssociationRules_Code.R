#Load the package arules in R
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)


#Loading data for Association Rules

#First, identify in which format the data is saved

#SCENARIO 1. Data is saved as "transactions"
#We cannot load transaction data using the traditional read.csv
#We need to use a different function
#Load the Groceries data using read.transactions()
#we specify that the format of our data is "basket"
#sep ="," is used to specify how the data are saved in the csv file
#rm.duplicates will remove duplicate items in the same transaction

Groceries <- read.transactions("groceries_data.csv", format = "basket",
                               sep = ",", rm.duplicates = TRUE)
#To visualize the transactions in the data, use inspect()
inspect(head(Groceries, 5))


#SCENARIO 2. If we have a Binary Format, we need to perform three steps
#A.Load data
movie_binary = read.csv("movies_binary4.csv")
#B.Transform the data into a matrix object
movie_matrix = as.matrix(movie_binary)
#C.Finally, transform the matrix into transactions
movie_data = as(movie_matrix, "transactions")


#To visualize the transactions in the data, use inspect()
inspect(head(movie_data, 20))
#get a general summary of the data
summary(movie_data)

#To learn the unique items existing in the dataset
itemInfo(movie_data)

#To find the support percentage of each unique item
itemFrequency(movie_data)

round(itemFrequency(movie_data), 3)

#Get support % for a specific item
itemFrequency(movie_data)["X.Men.2000."]
itemFrequency(movie_data)[5]
#For the first 10 items
itemFrequency(movie_data)[1:10]

#To get the support count, add the option type and set = absolute
itemFrequency(movie_data, type = "absolute")

#Plot frequent items
quartz(width = 10, height = 9)
itemFrequencyPlot(movie_data, ylim = c(0, 1), 
                  main = "Support %", col = "steelblue3", topN = 20,
                  cex.names = 0.6)


#subset transactions by item
#the operator %in% will look for transactions that contain the items specified
#if more than 1 item is specified, %in% will look for transactions that have EITHER item
subset(movie_data, items %in% c("X.Men.2000."))
#inspect the head of transactions that contain the item specified
inspect(head(subset(movie_data, items %in% c("X.Men.2000."))))

#If we want to know transactions that contain ALL the items specified,
#we need to use the operator %ain%
subset(movie_data, items %ain% c("X.Men.2000.", "Fracture.2007."))

#How to find association rules using the Apriori
#specify minsupp and minconfidence

mean(itemFrequency(movie_data))
median(itemFrequency(movie_data))

rules <- apriori(movie_data, parameter = list(supp = 0.6, conf = 0.8, target = "rules", minlen = 2))
summary(rules)
inspect(rules)
inspect(head(rules))
#In R language, we have
#support: support percentage of both lhs (X) and rhs (Y)
#coverage: support percentage of the lhs (X)
#Therefore we always have support < coverage

#Show top 20 rules by lift
inspect(head(rules, by = "lift", n = 20))

inspect(head(rules, by = "lift", n = 20, decreasing = FALSE))

#Show top 10 rules by confidence
inspect(head(rules, by = "confidence", n = 10))

#subset rules based on values of lift
inspect(sort(subset(rules, lift > 1.15), by = "lift"))

#Look for rules with specific items
inspect(subset(rules, lhs %in% "Interstellar.2014."))
inspect(subset(rules, rhs %in% "LionKing.The.1994."))

#Run again apriori looking for rules with specific items

#Example: Which movies would we recommend to viewers of X.MenOrigins.Wolverine.2009."?

rules_XMen <- apriori(movie_data, parameter=list (supp=0.5, conf = 0.6, minlen = 2), appearance = list (lhs="X.MenOrigins.Wolverine.2009."))
inspect(sort(rules_XMen, by = "lift"))

#Changing the thresholds will affect the set of results obtained
#Let us explore what happens with different confidence
rules2 <- apriori(movie_data, parameter = list(supp = 0.5, conf = 0.5, target = "rules", minlen = 2))

#It shows an HTML interactive table
inspectDT(rules2)

#we can plot a scatterplot of the rules, where the color changes based 
#on a chosen measure
plot(rules2, measure = c("support", "lift"), shading = "confidence")

plot(rules2, measure = c("support", "lift"), shading = "confidence", engine = "interactive")




