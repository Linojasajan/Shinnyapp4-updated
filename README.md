# Shiny App for Salmon Data Analysis 2.0

## Link to Running Shiny App
You can access the live version of the app version 2.0 at the following link:
https://linoja.shinyapps.io/newapp/ .Also you can checkout the old app in the following link:  [https://linoja.shinyapps.io/my-first-shiny-app/]

## Description of the App
This Shiny app 2.0  allows users to explore and analyze salmon population data in British Columbia. The app provides interactive visualizations, including time series graphs, bar charts, and detailed information about various salmon species to help users understand the trends in salmon population counts over time and across different regions.This is an improved version of the previous app.

Key features:
- Interactive plots displaying observed salmon counts across different regions.
- Time series graphs to explore trends in salmon populations.
- Ability to filter data by region, species, and year.
- Detailed species information, including descriptions and images, to help users better understand different types of salmon.
- The app enables users to explore the effects of different management practices on salmon populations, with easy-to-use interfaces and tools for deeper exploration.

New updates:
- The app now includes sections dedicated to specific salmon species (e.g., Coho, Pink, Sockeye), with detailed descriptions and images.
- Updated maps for salmon streams and their mouths in BC.
- Feedback option to user to send some suggestions/questions

## Dataset Source
The dataset used in this app comes from publicly available data on salmon populations in British Columbia. The data is provided by the **Department of Fisheries and Oceans (DFO)**. You can access the data directly from their official resources or find more information at the following links:

- **Department of Fisheries and Oceans (DFO)**: [https://open.canada.ca/data/en/dataset/c48669a3-045b-400d-b730-48aafe8c5ee6](https://open.canada.ca/data/en/dataset/c48669a3-045b-400d-b730-48aafe8c5ee6)

For transparency and reproducibility, the dataset used in this app is stored in the **Data** folder of this repository.
 
## Data Access and Licensing
The dataset used in this app is publicly available for academic, governmental, and non-profit uses. For users who want to access the raw data or get involved in research related to salmon populations, please refer to the links provided above.

## Installation Instructions

To run this app locally, clone the repository and install the necessary R packages. Here’s how to do it:

1. Clone the repository:

   git clone https://github.com/stat545ubc-2024/assignment-b3-Shinyapp-LinojaSajanthan.git

2. Install required R packages:

  install.packages(c("shiny", "ggplot2", "dplyr", "DT", "shinythemes", "rsconnect"))
   

3. Open the app in RStudio:
   - Navigate to the `app` folder where the `ui.R` and `server.R` files are located.
   - Run the app using:

     shiny::runApp()
     

## Folder Structure

- **www**: Contains static files like images used in the app. For example, the image of a sockeye salmon.
- **Data**: Contains the dataset used in the app for analysis and visualizations.
- **ui.R**: Defines the user interface for the Shiny app.
- **server.R**: Contains the server-side logic for the Shiny app.




