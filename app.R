

# Load Libraries
library(shiny)
library(arules)
library(arulesViz)
library(DT)

# UI Section
ui <- fluidPage(
  titlePanel("Association Rules with Apriori Algorithm"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("datafile", "Upload Transaction Data (CSV)",
                accept = c(".csv")),
      selectInput("data_format", "Data Format",
                  choices = c("Basket", "Binary")),
      sliderInput("supp", "Support Threshold", min = 0.01, max = 1, value = 0.1),
      sliderInput("conf", "Confidence Threshold", min = 0.01, max = 1, value = 0.8),
      numericInput("minlen", "Minimum Rule Length", value = 2, min = 1),
      actionButton("run_apriori", "Run Apriori Algorithm")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Rules", DTOutput("rules_table")),
        tabPanel("Plot", plotOutput("rules_plot")),
        tabPanel("Interactive Plot", plotOutput("interactive_plot"))
      )
    )
  )
)

# Server Section
server <- function(input, output) {
  data <- reactive({
    req(input$datafile)
    if (input$data_format == "Basket") {
      return(read.transactions(input$datafile$datapath, format = "basket", sep = ",", rm.duplicates = TRUE))
    } else {
      binary_data <- read.csv(input$datafile$datapath)
      matrix_data <- as.matrix(binary_data)
      return(as(matrix_data, "transactions"))
    }
  })
  
  rules <- eventReactive(input$run_apriori, {
    req(data())
    apriori(data(), parameter = list(supp = input$supp, conf = input$conf, minlen = input$minlen))
  })
  
  output$summary <- renderPrint({
    req(rules())
    summary(rules())
  })
  
  output$rules_table <- renderDT({
    req(rules())
    inspectDT(rules())
  })
  
  output$rules_plot <- renderPlot({
    req(rules())
    plot(rules(), measure = c("support", "lift"), shading = "confidence")
  })
  
  output$interactive_plot <- renderPlot({
    req(rules())
    plot(rules(), measure = c("support", "lift"), shading = "confidence", engine = "interactive")
  })
}

# Run the Application
shinyApp(ui, server)
