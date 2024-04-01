
library(shiny)
library(shinythemes)
library(tidyverse)

ui <- fluidPage(
  theme = shinytheme("slate"),
  titlePanel("Veiklos sritis: 680000"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("kodas",
                     "Pasirinkite įmonę",
                     choices = NULL),
      
    ),
    mainPanel(
      
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  data <- readRDS("../data/atrinktiPagalEcoKoda.rds")
  data=data %>% filter(is.na(avgWage)==FALSE)
  
  updateSelectizeInput(session, "kodas", choices = data$name , server = TRUE)
  
  
  output$plot <- renderPlot(
    data %>%
      filter(name == input$kodas) %>%
      ggplot(aes(x = ym(month), y = avgWage)) +
      geom_point(col='yellow') + 
      geom_line(col = 'white') +
      theme_dark() + labs(x="laiko tarpas", y = "vidutinis atlygis")
  ) 
}

shinyApp(ui = ui, server = server)
