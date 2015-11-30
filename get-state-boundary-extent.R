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

str(as.character(sp.state.bnd@proj4string))

proj4string(sp.state.bnd)

CRS(proj4string(sp.state.bnd))

junk <- SpatialPoints(sp.state.bnd@bbox,
                      proj4string = CRS(proj4string(sp.state.bnd)))
str(junk)

google <- "+init=epsg:3857"

junk.g <- spTransform(junk,CRS(google))

str(junk.g)

junk.g@bbox[1,]

junk.png <- GetMap.bbox(lonR=junk.g@bbox[1,],latR=junk.g@bbox[2,])

PlotOnStaticMap(junk.png)
