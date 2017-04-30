require(readr)
require(plyr)
require(dplyr)

# Use Radio Stations.csv
file_path = "Radio Stations.csv"

# Read CSV into dataframe
df <- readr::read_csv(file_path)

# Analyze current columns
names(df)

# Isolate columns we want
measures <- c("Callsign", "Frequency", "City", "State", "Licensee", "Format")
df <- df[measures]

# Remove rows with incomplete information
df <- df[complete.cases(df),]

# Remove incomplete formats
df <- df[!(df$Format=="Format"),]

# Adjust format to match
findFormat <- function(format) {
  currentFormat <- unlist(strsplit(tolower(format), " "))
  if ("christian" %in% currentFormat || "gospel" %in% currentFormat || "religious" %in% currentFormat || "religion" %in% currentFormat) {
    return("Religious")
  }
  else if ("pop" %in% currentFormat || "contemporary" %in% currentFormat || "mainstream" %in% currentFormat || "top" %in% currentFormat || "hot" %in% currentFormat || "hit" %in% currentFormat) {
    return("Pop or Contemporary")
  }
  else if ("rock" %in% currentFormat || "alternative" %in% currentFormat || "indie" %in% currentFormat) {
    return("Rock, Alternative, or Indie")
  }
  else if ("country" %in% currentFormat || "southern" %in% currentFormat) { 
    return("Country")
  }
  else if ("urban" %in% currentFormat || "hip" %in% currentFormat || "rap" %in% currentFormat || "hip-hop" %in% currentFormat) {
    return("Hip-hop")
  }
  else if ("jazz" %in% currentFormat || "blues" %in% currentFormat) {
    return("Jazz or Blues")
  }
  else if ("latin" %in% currentFormat || "mexican" %in% currentFormat || "international" %in% currentFormat) {
    return("International")
  }
  else if ("oldies" %in% currentFormat) { 
    return("Oldies")
  }
  else if ("news/talk" %in% currentFormat || "news" %in% currentFormat || "talk" %in% currentFormat || "public" %in% currentFormat) { 
    return("News and Talk")
  }
  else {
    return("Other")
  }
}

# This returns the found format for every format
df$Format <- apply(df["Format"], 1, findFormat)

# Write cleaned up data to file
write.csv(df, row.names=FALSE, file="PostETL-Radio.csv")
