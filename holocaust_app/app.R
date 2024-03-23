#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("Count of holocaust victims by ethicity at Autschwitz"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "number_of_bins",
        label = "Number of bins:",
        min = 1,
        max = 50,
        value = 30
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(plotOutput("distPlot"))
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$distPlot <- renderPlot({
    # Draw the histogram with the specified number of bins
    df |>
      ggplot(aes(x = ethnicity, y = victims)) +
      geom_bar(stat = "identity", fill = "skyblue", color = "black")+ 
      labs(title = "Number of Murder Victims by Ethnicity at Auschwitz",
           x = "Ethnicity",
           y = "Number of victims") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# Run the application
shinyApp(ui = ui, server = server)