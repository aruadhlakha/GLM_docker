   library(glmtools)
  library(ncdf4)
  setwd('/home/rstudio/configurations')
  colors = c('red','blue','green','black','yellow','cyan','orange','darkgreen','violet','magenta')
  for (i in seq(1,10)){
    if (i == 1){
      system2('/home/rstudio/glm/GLM/glm')
    } else {
      system2('/home/rstudio/glm-a/GLM/glm')
    }
    out <- 'output/output.nc'
    ncin <- nc_open('output/output.nc')
    sim_time <- ncvar_get(ncin, "time")
    sim_ns <- ncvar_get(ncin, "NS")
    sim_z <- ncvar_get(ncin, "z")
    sim_temp <- ncvar_get(ncin, "temp")
    sim_cyano <- ncvar_get(ncin, "PHY_cyano")
    ref_time <- ncin$dim$time$units
    ref_time <- gsub('hours since ', '', ref_time)
    if (i == 1){
      plot(sim_time,sim_cyano[1,], col = colors[i])
    }else{
      points(sim_time,sim_cyano[1,], col = colors[i])
    }
    nc_close(ncin)
  }
