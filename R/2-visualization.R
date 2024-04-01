library(tidyverse)
library(ggplot2)

data = readRDS("../data/atrinktiPagalEcoKoda.rds")

# 2.1 uzduotis

pirmasGrafikas = data %>%  
  ggplot(aes(x=avgWage)) + 
  geom_histogram(bins = 80) + 
  labs(title = "Histograma vidutiniam atlyginimui", x="vidutinis atlygis", y="kiekis")
  ggsave('../img/2.1_Grafikas.png', pirmasGrafikas, width = 10)

  
# 2.2 uzduotis
  
data = data %>% mutate(month = ym(month))

top5 = data%>%
    group_by(name)%>%
    summarise(top=max(avgWage))%>% 
     arrange(desc(top)) %>%
     head(5)

antrasGrafikas = data%>%
  filter(name %in% top5$name) %>%
  ggplot(aes(x=month, y=avgWage, col = name)) +
    geom_line() + labs(title = "vid. atlyginimo kaita", x= "metu eiga", y= "vidutinis atlyginimas")
ggsave('../img/2.2_Grafikas.png', antrasGrafikas, width = 10)

# 2.3 uzduotis

maxskaicius = data%>%
  filter(name %in% top5$name) %>% 
  group_by(name) %>%
  summarise(max = max(numInsured)) %>%
  arrange(desc(max))

# vardu isrikiavimas pagal apdraustuju skaiciu
maxskaicius$name=factor(maxskaicius$name, levels = maxskaicius$name[order(maxskaicius$max, decreasing = TRUE)])

treciasGrafikas = maxskaicius %>%
  ggplot(aes(x=name, y=max, fill = name)) + geom_col() + labs(title = "apdraustuju skaicius imonems", 
                                                              x= "imone", y = "apdraustuju skaicius")
ggsave('../img/2.3_Grafikas.png', treciasGrafikas, width = 10)

