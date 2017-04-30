#ui.R
require(shiny)
require(shinydashboard)

dashboardPage(
  dashboardHeader(
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("State Barchart", tabName = "barchart", icon = icon("dashboard")),
      menuItem("Political Affiliation Barchart", tabName = "PLbarchart", icon = icon("dashboard")),
      menuItem("East vs West Coast Barchart", tabName = "EWbarchart", icon = icon("dashboard"))
    )
  ),
  dashboardBody(    
    tabItems(
      
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