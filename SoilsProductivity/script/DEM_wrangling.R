pacman::p_load(tidyverse, sf, stars)

farms <- 
  read_sf('./FrackingFarms', 
          'FrackingFarms')

dem <- 
  farms  %>%
  as_Spatial()  %>%
  elevatr::get_elev_raster(z = 13, 
                           clip = 'bbox', 
                           verbose = F, 
                           override_size_check = T) 
raster::writeRaster(dem, './FrackingFarms/dem.tif')

slope <- 
terra::rast(dem) %>%
terra::terrain(., 'slope') 
 terra::writeRaster(slope, './FrackingFarms/slope.tif')
 
 raster::contour(dem, nlevels = 50)
