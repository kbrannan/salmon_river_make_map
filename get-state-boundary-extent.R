# script reads the state boundary shapefile, transforms crs to one used 
# by Google Maps and uses bounding box of state boundary to get map tile from 
# Google Maps to get backgound image for the map
# created by Kevin Brannan 2015-11-30

#load packages
library(rgdal)
library(RgoogleMaps)

# dns and layer for the state boundary shape file
dir.state <- "//deqhq1/GISLIBRARY/Base_Data/Admin_Boundaries/OR_StateBnd_USGS"
name.state <- "state_boundary"

# read state boundary into spatial.data.frame
sp.state.bnd <- readOGR(dsn = dir.state, layer = name.state)

# bounding box, note coordinates are in local crs (units are int feet)
sp.state.bnd@bbox[1:2,]

# get the projection arguments for the Google Maps crs
google.proj4string <- CRS("+init=epsg:4326")

# transform state boundary to Google Maps crs
sp.state.bnd.g <- spTransform(sp.state.bnd, google.proj4string)

# bounding box, note coordinates are in crs used by Google Maps 
# (units are decimal degrees)
sp.state.bnd.g@bbox[1:2,]

# calculate the lon and lat of the center for the Google Maps tile from the
# bounding box of the state boundary
center <- c(mean(sp.state.bnd.g@bbox[2,]), mean(sp.state.bnd.g@bbox[1,]))

# calculate the zoom level for the Google Maps tile from the state boundary
# bounding box
zoom <- min(MaxZoom(range(sp.state.bnd.g@bbox[2,]), 
                    range(sp.state.bnd.g@bbox[1,])))

# get the Google Maps tile to use as background and save to file
gm.state.bnd <- GetMap(center=center, zoom=zoom,
                       destfile = "gm-state-bnd.png")

