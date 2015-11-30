library(rgdal)
library(RgoogleMaps)

dir.state <- "//deqhq1/GISLIBRARY/Base_Data/Admin_Boundaries/OR_StateBnd_USGS"
name.state <- "state_boundary"

sp.state.bnd <- readOGR(dsn = dir.state, layer = name.state)

sp.state.bnd@bbox[1:2,]

google.proj4string <- CRS("+init=epsg:4326")


sp.state.bnd.g <- spTransform(sp.state.bnd, google.proj4string)

sp.state.bnd.g@bbox[1:2,]

center <- c(mean(sp.state.bnd.g@bbox[2,]), mean(sp.state.bnd.g@bbox[1,]))

zoom <- min(MaxZoom(range(sp.state.bnd.g@bbox[2,]), 
                    range(sp.state.bnd.g@bbox[1,])))

gm.state.bnd <- GetMap(center=center, zoom=zoom,
                       destfile = "gm-state-bnd.png")

