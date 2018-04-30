ui <- fluidPage(
  title = ("Rancangan Uji Sensoris dengan Williams Latin Square Design"),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$link(rel = "shortcut icon", href = "logo.png")
  ),
  div(
    id = "headerSection",
    h1(strong("Rancangan Uji Sensoris")),

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

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput(
        inputId = "sampel",
        label = "Jumlah Sampel",
        value = 3,
        min = 3
      ),
      numericInput(
        inputId = "panelis",
        label = "Jumlah Panelis",
        value = 10,
        min = 2
      ),
      radioButtons(
        inputId = "kode",
        label = "Buat Kode Acak",
        choices = c("Ya", "Tidak")
      ),
      tags$hr(),
      helpText("Klik 'Rancang' untuk merancang penyajian sampel berdasarkan Williams Latin Square Design."),
      actionButton(
        inputId = "rancang",
        label = "Rancang"
      ),
      tags$hr(),
      uiOutput(outputId = "unduh")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      dataTableOutput(outputId = "penyajian"),
      uiOutput(outputId = "penjelasan")
    )
  )
)
