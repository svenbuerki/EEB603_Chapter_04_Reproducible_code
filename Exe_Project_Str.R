# What: Produce a diagram of project structure

# Loading R packages
require(data.tree)
require(DiagrammeR)

# Pseudocode
# Arguments
# - dependencies
# - path vector with the path to the directory where you have all your files in 

##
# 1. What project and list all files in this project (as a data.frame())
##
  
# List all files in Project_ID
all_files <- list.files(path = path, all.files = TRUE, recursive = TRUE, full.names = TRUE)
  
# Fetch attributes
files_info <- file.info(all_files) 
  
# 2. Convert into data.tree (= to a genealogy or phylogenetic tree)
myproj <- data.tree::as.Node(data.frame(pathString = rownames(filesInfo)))
  
# 3. Prepare and plot a diagram ()
  
#general settings
data.tree::SetGraphStyle(myproj$root, rankdir = "LR")
  
#Set rules about all nodes
data.tree::SetNodeStyle(myproj, style = "rounded", shape = "box")
#Apply criteria only to children nodes of Scripts and R_functions folders
data.tree::SetNodeStyle(myproj$Scripts, style = "box", penwidth = "2px")
data.tree::SetNodeStyle(myproj$R_functions, style = "box", penwidth = "2px")
  
#Set rules about edges
data.tree::SetEdgeStyle(myproj$root, arrowhead = "vee", color = "grey", penwidth = "2px")
  
#plot
plot(myproj)
