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
  
  titlePanel("Holocaust Victims at Auschwitz"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("ethnicity", "Select Ethnicity:", choices = unique(df$ethnicity), multiple = TRUE),
      actionButton("update", "Update")
    ),
    mainPanel(
      plotOutput("bar_plot"),
      dataTableOutput("table")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Reactively update plot and table
  observeEvent(input$update, {
    filtered_data <- df %>%
      filter(ethnicity %in% input$ethnicity)
    
    # Generate bar plot
    output$bar_plot <- renderPlot({
      ggplot(filtered_data, aes(x = ethnicity)) +
        geom_bar(fill = "skyblue") +
        labs(title = "Holocaust Victims by Ethnicity",
             x = "Ethnicity",
             y = "Number of Victims") +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    })
    
    # Generate table
    output$table <- renderDataTable({
      filtered_data
    })
  })
}

# Run the application
shinyApp(ui = ui, server = server)