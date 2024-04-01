library(tidyverse)
library(jsonlite)
library(dplyr)
cat("Darbinė direktorija:", getwd())        # turi buti pasirinkta KTU-P160B131-2024-lab/R
download.file("https://atvira.sodra.lt/imones/downloads/2023/monthly-2023.json.zip", "../data/temp" )
unzip("../data/temp",  exdir = "../data/")
data = fromJSON('../data/monthly-2023.json')
file.remove("../data/temp")
file.remove("../data/monthly-2023.json")

data %>% 
  filter(ecoActCode == 680000) %>%
  saveRDS('../data/atrinktiPagalEcoKoda.rds')
