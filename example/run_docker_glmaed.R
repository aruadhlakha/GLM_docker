## small script to run the GLM-AED2 container
## maintainer: Robert Ladwig
## https://github.com/robertladwig/GLM_docker

# clear the workspace
rm(list = ls())

# packaged needed to get the github files, install it via
# install.packages('httr')
library(httr)

# replace local_folder with a path on your machine
local_folder <- '/Users/robertladwig/Documents/Reports/docker/TestLake/'#"<YOURFOLDERPATH>" 
setwd(local_folder)

# creates the folders 'bcs' and 'aed' for the GLM-AED2 simulation
dir.create('aed')
dir.create('bcs')

# gets urls to the github data
path_glm <- "https://raw.githubusercontent.com/robertladwig/GLM_docker/master/example/TestLake/glm3.nml"
path_meteo <- "https://raw.githubusercontent.com/robertladwig/GLM_docker/master/example/TestLake/bcs/met_driver.csv"
path_aed <- "https://raw.githubusercontent.com/robertladwig/GLM_docker/master/example/TestLake/aed/aed2.nml"

# saves data to your machine
glm <- read_tsv(path_glm)
meteo <- read_csv(path_meteo)
aed <- read_tsv(path_aed)
write_tsv(glm, paste0(local_folder,'glm3.nml'), quote= FALSE)
write_csv(meteo, paste0(local_folder,'bcs/met_driver.csv'))
write_tsv(aed, paste0(local_folder,'aed/aed2.nml'), quote= FALSE)

# start docker as background process (detached)
system(paste0('docker run -it -d -v ',local_folder,':/GLM/TestLake hydrobert/glm-aed2 /bin/bash'))
# get the id of your running container
dockerps <- system('docker ps',intern = TRUE)
dockerid <- strsplit(dockerps, split = "/t")
dockerid <- strsplit(dockerid[[2]], split = " ")
dockerid <- dockerid[[1]][1]
# start the simulation (i - interactive, t - tty (user input))
system(paste('docker exec -t',dockerid,'/bin/bash -c \"cd TestLake; /GLM/glm\"'))

# stops and removes all running dockers
system('docker kill $(docker ps -q)')
system('docker rm $(docker ps -a -q)')

