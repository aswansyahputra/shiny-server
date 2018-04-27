library(shiny)
library(shinyjs)
library(shinyWidgets)
library(DT)
library(stringr)
library(tools)

# Define UI for application that draws a histogram
ui <- fluidPage(
  useShinyjs(),
  title = "SenseHub",
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$link(rel = "shortcut icon", href = "logo.png")
  ),
  div(
    id = "headerSection",
    h1(strong("Analisis")),
    
    # author info
    span(
      style = "font-size: 1.2em",
      span("Dibuat oleh "),
      a("Muhammad Aswan Syahputra", href = "https://aswansyahputra.com"),
      HTML("&bull;"),
      span("Hubungi di"),
      a("LinkedIn", href = "https://www.linkedin.com/in/aswansyahputra/"),
      HTML("&bull;"),
      span("Kirim"),
      a("surel", href = "mailto:muhammadaswansyahputra@gmail.com?Subject=Salam%20Kenal")
    )
  ),
  
  tabsetPanel(
    tabPanel("Data",
             sidebarLayout(
               sidebarPanel(
                 # Input: Select a file ----
                 fileInput("file1", "Choose CSV File",
                           multiple = FALSE,
                           accept = c("text/csv",
                                      "text/comma-separated-values,text/plain",
                                      ".csv")),
                 
                 # Horizontal line ----
                 tags$hr(),
                 
                 # Input: Checkbox if file has header ----
                 checkboxInput("header", "Header", TRUE),
                 
                 # Input: Select separator ----
                 radioButtons("sep", "Separator",
                              choices = c(Comma = ",",
                                          Semicolon = ";",
                                          Tab = "\t"),
                              selected = ","),
                 
                 # Input: Select quotes ----
                 radioButtons("quote", "Quote",
                              choices = c(None = "",
                                          "Double Quote" = '"',
                                          "Single Quote" = "'"),
                              selected = '"')
                 
               ),
               mainPanel(
                 tabsetPanel(
                   tabPanel("Data View",
                            dataTableOutput("contents")), 
                   tabPanel("General Summary", 
                            verbatimTextOutput("inSummary"))
                 )
               )
             )
    ),
    tabPanel("Local Analysis",
             sidebarLayout(
               sidebarPanel(
                 wellPanel(
                   uiOutput("response_selector"),
                   uiOutput("predictors_selector")
                 )
               ),
               mainPanel(
                 wellPanel(
                   tabsetPanel(
                     tabPanel("ANOVA"),
                     tabPanel("Posthoc"),
                     tabPanel("Plot")
                   )
                 )
               )
             )
    ),
    tabPanel("Global Analysis",
             sidebarLayout(
               sidebarPanel(
                 radioButtons(inputId = "type",
                              label = "Please select the type of global analysis",
                              choices = c("PCA", "CA", "MFA"),
                              selected = "PCA")
               ),
               mainPanel(
                 h2("Global analysis")
               )
             )
    )
  )
)
