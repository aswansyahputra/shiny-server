server <- function(input, output) {
  des <- eventReactive(input$rancang, {
    req(input$sampel)
    req(input$panelis)
    set.seed(input$sampel + input$panelis)
    sampel <- sample(100:999, input$sampel, replace = FALSE)
    desain <- williams(trt = input$sampel)
    desain <- apply(desain, MARGIN = 2, rep, input$panelis)
    colnames(desain) <- paste("Urutan", 1:input$sampel, sep = "_")
    if (input$kode == "Ya") {
      kode_sampel <- sample(100:999, input$sampel, replace = FALSE)
      for (i in 1:input$sampel) {
        desain[desain == i] <- kode_sampel[i]
      }
    }
    desain <- data.frame(
      Panelis = 1:input$panelis,
      desain[1:input$panelis, ]
    )
    colnames(desain) <- toTitleCase(str_replace_all(colnames(desain), "[.,_]", " "))
    desain
  })

  output$penyajian <- renderDataTable({
    datatable(des(),
      options = list(
        lengthMenu = list(c(5, 10, 20, -1), c("5", "10", "20", "All")),
        pageLength = 10,
        searching = FALSE,
        autoWidth = FALSE,
        scrollX = TRUE,
        initComplete = JS(
          "function(settings, json) {",
          "$(this.api().table().header()).css({'background-color': '#5b543a', 'color': '#fff'});",
          "}"
        )
      ),
      rownames = FALSE
    )
  })

  observeEvent(input$rancang, {
    output$penjelasan <- renderUI({
      div(
        tags$hr(),
        helpText("Tabel diatas merupakan rancangan penyajian sampel. Baris menyatakan panelis, kolom merupakan urutan penyajian sampel, sedangkan nilai pada baris-kolom menunjukan nomor atau kode acak sampel (jika anda memilih opsi 'Buat Kode Acak')."),
        tags$br()
      )
    })
  })

  observeEvent(input$rancang, {
    output$unduh <- renderUI({
      downloadButton(
        outputId = "simpan",
        label = "Simpan Rancangan"
      )
    })
  })

  output$simpan <- downloadHandler(
    filename = function() {
      paste("Rancangan penyajian ", input$sampel, " sampel ", "dan ", input$panelis, " panelis", ".csv", sep = "")
    },
    content = function(tabel) {
      write.csv(des(), tabel, row.names = FALSE)
    }
  )
}
