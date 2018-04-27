server <- function(input, output) {
  inData <- reactive({
    req(input$file1)
    
    df <- read.csv(input$file1$datapath,
                   header = input$header,
                   sep = input$sep,
                   quote = input$quote)
    colnames(df) <- toTitleCase(str_replace_all(colnames(df), "[.,_]", " "))
    df
  })
  
  
  
  output$contents <- renderDataTable({
    datatable(
      inData(), 
      rownames = FALSE,
      options = list(
        autoWidth = FALSE,
        lengthMenu = list(c(5, 20, -1), c('5', '20', 'All')),
        pageLength = 10,
        scrollX = TRUE)
    )
  })
  
  output$inSummary <- renderPrint({
    summary(inData())
  })
  
  
  # Define selectors for predictors and response
  
  output$response_selector <- renderUI({
    pickerInput(
      inputId = "selected_response", "Choose the response variable",
      choices = colnames(inData()),
      selected = NULL,
      multiple = F, options = list('actions-box' = TRUE, title = "Click here", 'deselect-all-text' = "None", 'select-all-text' = "All"),
      width = '80%'
    )
  })
  
  output$predictors_selector <- renderUI({
    pickerInput(
      inputId = "selected_predictors", "Choose the categorical predictors", 
      choices = colnames(inData())[!colnames(inData()) %in% input$selected_response],
      selected = NULL,
      multiple = T, options = list('actions-box' = TRUE, title = "Click here", 'deselect-all-text' = "None", 'select-all-text' = "All"),
      width = '80%'
    )
  })
  
  
  # Define predictors
  
  predictors <- reactive({
    req(input$selected_predictors)
    input$selected_predictors
  })
  
  # Define response
  
  response <- reactive({
    req(input$selected_response)
    input$selected_response
  })
}
