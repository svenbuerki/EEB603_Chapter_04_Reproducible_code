############################
#Script to infer the data structure of your project
############################

#-------
#Aim: Know where your files are stored (incl. which version) and how they are related.
#-------
# - STEP 1: Produce a list of all files in your wrkdir, their location and gather attributes (size, version)
# - STEP 2: Convert data into a data.tree format
# - STEP 3: Plot data structure

## Load R packages ---
require(data.tree)
require(networkD3)

## STEP1 ------
#Produce a list of all files in your wrkdir (incl. subdir) 
#Add info related to those files: e.g. location, size, last modified
filesInfo <- file.info(list.files(recursive = TRUE, full.name = TRUE))

mytree <- data.tree::as.Node(data.frame(pathString = gsub("\\./\\b", "Chapter_6/", rownames(filesInfo))))

plot(as.igraph(mytree, directed = TRUE, direction = "climb"))  
## STEP 3 ----
##Plotting data.tree object

#Simple, tree-like plot
jpeg(file="Data_structure.jpeg")
plot(mytree)
dev.off()
#Plot and save (html) as an interactive 3D network
dataStrNetwork <- ToDataFrameNetwork(mytree, inheritFromAncestors = F)

fromNet <- strsplit(dataStrNetwork[,1], split='/')

x<-NULL
for(i in 1:length(fromNet)){
  tmp <- fromNet[[i]][length(fromNet[[i]])]
  x <- c(x, tmp)
}
dataStrNetwork$from <- x

toNet <- strsplit(dataStrNetwork[,2], split='/')

x<-NULL
for(i in 1:length(toNet)){
  tmp <- toNet[[i]][length(toNet[[i]])]
  x <- c(x, tmp)
}
dataStrNetwork$to <- x

##Add " " to first duplicated file
toFind <- which(table(dataStrNetwork$to) > 1)

for(i in 1:length(toFind)){
  dataStrNetwork$to[grep(names(toFind[i]), dataStrNetwork$to)[1]] <- paste(names(toFind[i]), " ", sep='')
}

network <- simpleNetwork(dataStrNetwork, fontSize = 12)
saveNetwork(network, file="Data_Structure_chapter6.html", selfcontained = TRUE)
