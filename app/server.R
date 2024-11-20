# Server Code
server <- function(input, output, session) {
  
  # Dynamically update the stream names based on selected species
  observe({
    filtered_species <- salmon_data %>%
      filter(Species_name %in% input$species)
    updateSelectizeInput(session, "location",
                         choices = unique(filtered_species$Stream_name),
                         server = TRUE)
  })
  
  # Dynamically update the streams for time series plot
  observe({
    filtered_streams <- salmon_data %>%
      filter(Species_name == input$species_filter) %>%
      select(Stream_name) %>%
      distinct()
    updateSelectizeInput(session, "stream_filter",
                         choices = unique(filtered_streams$Stream_name),
                         server = TRUE)
  })
  
  # Filter and render data table based on selected input
  output$data_table <- renderDT({
    filtered_data <- salmon_data %>%
      filter(Species_name %in% input$species,
             Year >= input$start_year,
             Year <= input$end_year,
             Stream_name %in% input$location)
    datatable(filtered_data)
  })
  
  # Time series plot for salmon counts
  output$time_series_plot <- renderPlot({
    # Ensure the necessary inputs are available
    req(input$species_filter, input$stream_filter)
    
    # Retrieve the filtered data based on the selected species and stream
    filtered_data <- salmon_data %>%
      filter(Species_name %in% input$species_filter, 
             Stream_name == input$stream_filter)
    
    # Check if there's data to plot
    if (nrow(filtered_data) > 0) {
      ggplot(filtered_data, aes(x = Year, y = Salmon_count, fill = Species_name)) +
        geom_bar(stat = "identity", position = "dodge") +
        facet_wrap(~ Stream_name, scales = "free_y") +  # Handles different y-axis scales per stream
        theme_minimal() +
        labs(
          title = "Pacific Salmon Counts in British Columbia",
          x = "Year",
          y = "Salmon Counts",
          fill = "Species"
        ) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    } else {
      ggplot() + 
        ggtitle("No data available for the selected filters") +
        theme_void()
    }
  })
  
  
  # Data download handler
  output$downloadData <- downloadHandler(
    filename = function() {
      paste("salmon_data_", Sys.Date(), ".csv", sep = "")
    },
    content = function(file) {
      write.csv(salmon_data, file)
    }
  )
}


