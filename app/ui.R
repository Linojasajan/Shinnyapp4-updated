# Loading the necessary libraries
library(shiny)
library(DT)
library(dplyr)
library(shinythemes)
library(ggplot2)

# Load data: This is panel data on Pacific salmon population counts in British Columbia in which the original version of this data is publicly available in the Fisheries and Oceans Canada website. More details about the data is explained in the README.file.
salmon_data <- read.csv("Data/pacific_salmon_data.csv")

# UI
ui <- navbarPage( # Creating the navigation bar to other pages
  title = div(
    tags$span("PACIFIC SALMON DATA HUB", # Add title of the page 
              style = "font-weight: bold; font-family: 'Merriweather', sans-serif; font-size: 24px; color: navy;")
  ),
  theme = shinythemes::shinytheme("cerulean"),
  
  # Home page
  tabPanel("Home",
           fluidPage(
             tags$style(HTML("body { background-color: aliceblue; }")),
             h1("Pacific Salmons in British Columbia", 
                style = "color: steelblue; text-align: center; font-weight: bold;"),
             br(),
             img(src = "salmon.jpg", alt = "Salmon Image", height = "400px", width = "auto",
                 style = "display: block; margin-left: auto; margin-right: auto;"), # Adding the Pacific salmon picture in the home page
             br(),
             p("Welcome to the Pacific Salmon Data Hub, a part of the Wildlife and Conservation Laboratory at the University of British Columbia (UBC). This platform provides interactive tools to explore various datasets related to the Pacific salmon populations in British Columbia.", 
               style = "color: steelblue; font-size: 18px; text-align: center;"),
             br(),
             tags$footer(
               style = "background-color: #f1f1f1; padding: 10px; text-align: center; margin-top: 30px;",
               p("© 2024 Wildlife and Conservation Laboratory, UBC | Contact: linoja07@student.ubc")
             )
           )
  ),
  
  # Salmon Population Data Page: This page contains the interactive table which provides the user to filter the data based on species, year and stream
  tabPanel("Salmon Population Data",
           fluidPage(
             h2("Salmon Population Data"),
             p("This section navigates you to the Pacific salmon data for the five different species since 1920 in British Columbia. You can use the below filter to explore different species, for different streams for your intended year ranges. Also, you can get a .csv file download of the explored data."),
             sidebarLayout(
               sidebarPanel(
                 selectInput("species", "Species:", 
                             choices = unique(salmon_data$Species_name), 
                             selected = unique(salmon_data$Species_name)[1], 
                             multiple = TRUE), # Able to choose multiple species at a time
                 
                 selectInput("start_year", "Start Year:",
                             choices = sort(unique(salmon_data$Year)), 
                             selected = min(salmon_data$Year)), # Able to choose one year as a starting year
                 
                 selectInput("end_year", "End Year:",
                             choices = sort(unique(salmon_data$Year)), 
                             selected = max(salmon_data$Year)), # Able to choose one year as an end year
                 
                 selectizeInput("location", "Stream name:",
                                choices = NULL,
                                selected = NULL), # This will give the option to choose one stream
                 
                 downloadButton("downloadData", "Download Table as CSV") # Download the filtered data in .csv format
               ),
               mainPanel(
                 textOutput("resultCount"), # Returns the number of results count
                 br(),
                 DTOutput("data_table")
               )
             )
           )
  ),
  
  # Time Series Page : This page explores the time series plot for each stream for different species and plot the graph
  tabPanel("Time Series of Pacific Salmon",
           fluidPage(
             h2("Time Series of Pacific Salmon"),
             p("The time series data of salmon populations is displayed as bar charts showing the return to river (salmon counts) for each species across different years. This will give you a clear idea of the Stream-level Pacific salmon abundance in British Columbia. If there is no data for a particular stream, the graph will be blank."),
             sidebarLayout(
               sidebarPanel(
                 selectizeInput("species_filter", "Select Species:",
                                choices = unique(salmon_data$Species_name), 
                                selected = NULL, multiple = FALSE), # Able to choose only one species
                 
                 selectizeInput("stream_filter", "Select Stream:",
                                choices = NULL, 
                                selected = NULL) # Able to choose only one stream
               ),
               mainPanel(
                 plotOutput("time_series_plot")
               )
             )
           )
  ),
  
  # About Page : This page provides an information page for the whole app and the contents in this page are just for an example.
  tabPanel("About",
           fluidPage(
             h2("About Pacific Salmon Data Hub"),
             p("This is the Pacific Salmon Data Hub, a part of the Wildlife and Conservation Laboratory at the University of British Columbia (UBC). The data used here is publicly available and can be accessed on the Fisheries and Oceans Canada website."),
             p(tags$a(href = "https://open.canada.ca/data/en/dataset/c48669a3-045b-400d-b730-48aafe8c5ee6", "New Salmon Escapement Database System: Fisheries and Ocean Canada")),
             br(),
             p("This website is a result of ongoing research, and updates and developments will continue to be incorporated."),
             br(),
             h3("Get in touch"),
             p("We welcome comments and feedback. For any inquiries or suggestions, feel free to contact us at the following:"),
             tags$ul(
               tags$li(tags$i(class = "fas fa-envelope"), " linoja07@student.ubc.ca"),
               tags$li(tags$i(class = "fas fa-phone-alt"), " +1 (123) 456-7890"),
               tags$li(tags$i(class = "fas fa-map-marker-alt"), " University of British Columbia, Vancouver, BC, Canada")
             )
           )
  ),
  
  # Custom CSS and Font Awesome CDN
  tags$head(
    tags$style(HTML(".navbar-nav { margin-left: auto; }")),
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css")
  )
)


##### Comments on Features used in the shinyapp ####

# Here's a brief overview of the key features I've included:

# 1. Image Upload (Salmon Picture): This adds a visual connection to the Pacific salmon, making the app more engaging and thematic.
   
# 2. Interactive Table: Users can filter the data by streams, species, and year ranges, which is useful for targeting specific interests. The option to download the filtered data adds practicality to the app, allowing users to take the information offline.

# 3. Bar Chart Plotting: Users can generate bar charts to visualize salmon count trends based on the stream and species they select. This is a great way to present time-series data in a clear and interactive way.

# 4. About Page: I've included a page with additional details, possibly about the app, the project, or related content. Adding symbols and formatting to this page can make it visually appealing and informative.

