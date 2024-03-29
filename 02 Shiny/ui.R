#ui.R
require(shiny)
require(shinydashboard)
require(plotly)

dashboardPage(skin = "green",
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Scatter Plot", tabName = "scat", icon=icon("dashboard")),
      menuItem("Aggregated Measure Analysis - Format Ratio by Population", tabName = "agg", icon=icon("dashboard")),
      menuItem("Non-Aggregated Measure Analysis - Stations per Capita", tabName = "nonagg", icon=icon("dashboard")),
      menuItem("Crosstabs - Crosstabs, KPIs, Parameters", tabName = "crosstab", icon = icon("dashboard")),
      menuItem("Barcharts - State", tabName = "barchart", icon = icon("dashboard")),
      menuItem("Barcharts - Political Affiliation", tabName = "PLbarchart", icon = icon("dashboard")),
      menuItem("Barcharts - East vs West Coast Barchart", tabName = "EWbarchart", icon = icon("dashboard"))
    )
  ),
  dashboardBody(  
    tabItems(
     
      tabItem(tabName = "scat",
              tabsetPanel(
                tabPanel("Data",
                         h1("Scatter Plot"), 
                         actionButton(inputId = "scataction", label="Get Data"), hr(),
                         DT::dataTableOutput("scatdata")
                ),
                tabPanel("Scatter Plot", "This is a scatter plot.", plotlyOutput("scatplot", height=1000))
              )
      ),
      
      tabItem(tabName = "agg",
              tabsetPanel(
                tabPanel("Data",
                         h1("Aggregated Measure Analysis"), 
                         actionButton(inputId = "aggaction", label="Get Data"), hr(),
                         DT::dataTableOutput("aggdata")
                ),
                tabPanel("Histogram", "This is a stacked histogram.", plotlyOutput("aggplot", height=1000))
              )
      ),
      
      tabItem(tabName = "nonagg",
        tabsetPanel(
          tabPanel("Data",
            h1("Non-Aggregated Measure Analysis"), 
            actionButton(inputId = "nonaggaction", label="Get Data"), hr(),
            DT::dataTableOutput("nonaggdata")
          ),
          tabPanel("Box Plot", "This is a box-and-whiskers plot of the stations per capita for each format.", plotlyOutput("nonaggplot", height=1000))
        )
      ),
      
      # "Please select the states for which you'd like to see a format distribution.",
      # uiOutput("nonaggstates"),
      
      # Begin Crosstab tab content.
      tabItem(tabName = "crosstab",
              tabsetPanel(
                tabPanel("Data",
                         radioButtons("rb5", "Choose the Crosstab you want to see:",
                                      c("Stations per Capita" = "capita",
                                        "Male Listeners Ratio" = "male",
                                        "Female Listeners Ratio" = "female"), inline=T),
                         actionButton(inputId = "click5",  label = "To get data, click here"),
                         hr(), # Add space after button.
                         DT::dataTableOutput("data5")
                ),
                tabPanel("Crosstab", "This is a crosstab of the radio formats for the U.S.", plotOutput("plot5", height=1000))
              )
      ),
      # End Crosstab tab content.
      
      # Begin Barchart tab content.
      tabItem(tabName = "barchart",
              tabsetPanel(
                tabPanel("Data", "Please select a few states to view", 
                         radioButtons("rb2", "Get data from:",
                                      c("SQL" = "SQL"), inline=T),
                         uiOutput("regions2"), # See http://shiny.rstudio.com/gallery/dynamic-ui.html
                         actionButton(inputId = "click2",  label = "To get data, click here"),
                         hr(), # Add space after button.
                         DT::dataTableOutput("data2")
                ),
                tabPanel("Barchart", "Bars represent amount of stations in each format", plotOutput("plot2", height=500))
              )
      ),
      # End Barchart tab content.
      
      # Begin Barchart tab content.
      tabItem(tabName = "PLbarchart",
              tabsetPanel(
                tabPanel("Data", "Please select a couple states to view", 
                         radioButtons("rb3", "Get data from:",
                                      c("SQL" = "SQL"), inline=T),
                         uiOutput("regions3"),
                         uiOutput("regions3b"),# See http://shiny.rstudio.com/gallery/dynamic-ui.html
                         actionButton(inputId = "click3",  label = "To get data, click here"),
                         hr(), # Add space after button.
                         DT::dataTableOutput("data3")
                ),
                tabPanel("Political Leaning Barchart", "Bars represent amount of stations in each format for each state", plotOutput("plot3", height=300))
              )
      ),
      # End Barchart tab content.
      
      # Begin Barchart tab content.
      tabItem(tabName = "EWbarchart",
              tabsetPanel(
                tabPanel("Data", "Please select a few states to view", 
                         radioButtons("rb4", "Get data from:",
                                      c("SQL" = "SQL"), inline=T),
                         uiOutput("regions4"),
                         uiOutput("regions4b"), # See http://shiny.rstudio.com/gallery/dynamic-ui.html
                         actionButton(inputId = "click4",  label = "To get data, click here"),
                         hr(), # Add space after button.
                         DT::dataTableOutput("data4")
                ),
                tabPanel("East vs West Coast Barchart", "Bars represent amount of stations in each format for each state", plotOutput("plot4", height=300))
              )
      )
      # End Barchart tab content.
      
      
    )
  )
)