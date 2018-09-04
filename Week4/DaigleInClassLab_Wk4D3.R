## Daigle Wk4D3

# Exercise 1

mtcars
nrow(mtcars)
which(row.names(mtcars) == "Cadillac Fleetwood")
a <- which(row.names(mtcars) == "Cadillac Fleetwood")
mtcars1 <- mtcars[1:a-1,]
mtcars2 <- mtcars[a:nrow(mtcars),]

mtcars2[,c("vs","am")] <- NULL
mtcars2[,c("vs","am")] <- NA
rbind(mtcars1,mtcars2)

# Exercise 2
# Assigns mtcars3 the values in mtcars' columns 1 through to one column before the one named "wt", where m = rows and n= columns, the brackets relate to [m,n]
mtcars3 <- mtcars[,1:(which(names(mtcars) == "wt"))-1]
mtcars4 <- mtcars[,which(names(mtcars) == "wt"):ncol(mtcars)]

name <- row.names(mtcars)

mtcars3 <- cbind(name, mtcars3)
mtcars4 <- cbind(name, mtcars4)

#This removes the names we assigned to each row and replaces them with the number of thier respectie row
row.names(mtcars3) <- NULL
row.names(mtcars4) <- NULL
# Creates a character vector with the first four letters of each row name in mtcars
a <- substr(row.names(mtcars), start = 1, stop = 4)
mtcars4 <- mtcars4[!(a == "Merc"),]
# Replaces mtcars4 with all the values of mtcars4 except those rows where the character vector is "Merc"
mtcars4

mtcars_all <- merge(mtcars3, mtcars4, by = "name", all = TRUE)
# Merges mtcars3 and 4 by the column "name" where each is the same

# Exercise 3
mov <- "The Shining"
act <- c("Jack Nicholson", "Shelley Duvall", "Danny Lloyd", "Scatman Crothers", "Barry Nelso")
scores <- c(4.5, 4.0, 5.0)
sources <- c("IMDb1", "IMDb2", "IMDb3")
comments <- c("Best Horror Film I have ever seen", "A truly brilliant and scary film", "A masterpiece of psychological horror")
rev <- data.frame(scores, sources, comments)
# Creates a data.frame (like a database) of the scores, sources, and comments vectors (note they are not homogenous)

shine_list <- list(mov, act, rev)

rm(mov, act, scores, comments, rev)
names(shine_list) <- c("moviename", "actors", "reviews")
shine_list[2]
shine_list[[2]][2]
(shine_list[[3]][1])*5
shine_list[[3]][3]
yOR <- 1980
shining_list_new <- shine_list
shining_list_new$yearOfRelease <- yOR
shining_list_new