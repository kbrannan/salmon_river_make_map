library(rgdal)
library(RgoogleMaps)

dir.state <- "//deqhq1/GISLIBRARY/Base_Data/Admin_Boundaries/OR_StateBnd_USGS"
name.state <- "state_boundary"

sp.state.bnd <- readOGR(dsn = dir.state, layer = name.state)

sp.state.bnd@bbox[1,]

str(sp.state.bnd)

str(sp.state.bnd@lines[[1]]@Lines[[1]]@coords)

min(sp.state.bnd@lines[[1]]@Lines[[1]]@coords[,1])

min(sp.state.bnd@lines[[1]]@Lines[[1]]@coords[,2])

get.lats <- function(x) sp.state.bnd@lines[[x]]@Lines[[1]]@coords[,2]

# min lat
lat.min <- min(
  do.call(rbind,lapply(X = 1:19, 
                       FUN = function(x) 
                         min(sp.state.bnd@lines[[x]]@Lines[[1]]@coords[,2]))))
# max lat
lat.max <- max(
  do.call(rbind,lapply(X = 1:19, 
                       FUN = function(x) 
                         max(sp.state.bnd@lines[[x]]@Lines[[1]]@coords[,2]))))
# min lon
lon.min <- min(
  do.call(rbind,lapply(X = 1:19, 
                       FUN = function(x) 
                         min(sp.state.bnd@lines[[x]]@Lines[[1]]@coords[,1]))))
# max lon
lon.max <- max(
  do.call(rbind,lapply(X = 1:19, 
                       FUN = function(x) 
                         max(sp.state.bnd@lines[[x]]@Lines[[1]]@coords[,1]))))

mt.bbox.state.bnd <- c(c(lat.min,lat.max)c(lon.min,lon.max))


array(c(lat.min,lon.min,lat.max,lon.max), dim=c(2,2))


get.lats(2)

str(as.character(sp.state.bnd@proj4string))

proj4string(sp.state.bnd)

CRS(proj4string(sp.state.bnd))

junk <- SpatialPoints(sp.state.bnd@bbox,
                      proj4string = CRS(proj4string(sp.state.bnd)))
str(junk)

google <- "+init=epsg:3857"

junk.g <- spTransform(junk,CRS(google))

sp.state.bnd.g <- spTransform(sp.state.bnd,CRS(google))

str(sp.state.bnd.g)

str(sp.state.bnd.g@bbox)

range(sp.state.bnd.g@bbox[1,])
range(sp.state.bnd.g@bbox[2,])

bbox <- qbbox(lat=range(sp.state.bnd.g@bbox[1,]),
              lon = range(sp.state.bnd.g@bbox[2,]))
junk.png <- GetMap(center = c(lat = 122.6819, lon = -45.52),
                   zoom = 5,
                   destfile = "junk.png", format = "png")




junk.g@bbox

str(junk.g)

junk.g@bbox[1,]

range(junk.g@bbox[1,])

bbox <- qbbox(lon=range(junk.g@bbox[2,]),lat=range(junk.g@bbox[1,]))

rm(junk.png)

junk.png <- GetMap(center = c(lon = mean(bbox$lonR), lat = mean(bbox$latR)),
                   zoom = 5,
                   destfile = "junk.png", format = "png")

PlotOnStaticMap(junk.png)


