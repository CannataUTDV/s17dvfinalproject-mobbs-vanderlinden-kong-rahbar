# server.R
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(data.world)
require(readr)
require(DT)
require(plotly)


nonaggstates = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as States
  from `PostETL-Radio`"
)


# The following query is for the select list in the Barcharts tabs. 

regions2 = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as D, State as R
  from `Census` where `2016_Party_Popular_Vote` = 'Liberal'"
) 

regions2b = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as D, State as R
  from `Census` where `2016_Party_Popular_Vote` = 'Conservative'"
) 

regions3 = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as D, State as R
  from `Census` where Coast = 'West'"
) 

regions3b = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as D, State as R
  from `Census` where Coast = 'East'"
) 

regions = query(
  data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
  dataset="jacobv/s-17-dv-final-project", type="sql",
  query="select Distinct State as D, State as R
  from `PostETL-Radio`"
)

# if(regions[1] == "Server error") {
#   print("Getting Regions from csv")
#   file_path = "www/SuperStoreOrders.csv"
#   df <- readr::read_csv(file_path) 
#   tdf1 = df %>% dplyr::distinct(Region) %>% arrange(Region) %>% dplyr::rename(D = Region)
#   tdf2 = df %>% dplyr::distinct(Region) %>% arrange(Region) %>% dplyr::rename(R = Region)
#   regions = bind_cols(tdf1, tdf2)
# }

region_list <- as.list(regions$D, regions$R)
region_list <- append(list("All" = "All"), region_list)

region_list2 <- as.list(regions2$D, regions2$R)

region_list2b <- as.list(regions2b$D, regions2b$R)

region_list3 <- as.list(regions3$D, regions3$R)

region_list3b <- as.list(regions3b$D, regions3b$R)

# End Barcharts tabs list creation

# output/input
shinyServer(function(input, output) { 
  # These widgets are for the non-aggregate measures tab.
  output$nonaggstates <- renderUI({selectInput("nonaggselect", "Choose States:", nonaggstates, multiple = TRUE)})
  
  # These widgets are for the aggregate measures tab.
  
  # These widgets are for the Barcharts tab.
  online2 = reactive({input$rb2})
  output$regions2 <- renderUI({selectInput("selectedRegions", "Choose Regions:", region_list, multiple = TRUE) })
  
  # These widgets are for the PLBarcharts tab.
  online3 = reactive({input$rb3})
  output$regions3 <- renderUI({selectInput("selectedRegions2", "Choose Liberal Region:", region_list2, multiple = FALSE) })
  output$regions3b <- renderUI({selectInput("selectedRegions2b", "Choose Conservative Region:", region_list2b, multiple = FALSE) })
  
  # These widgets are for the EWBarcharts tab.
  online4 = reactive({input$r43})
  output$regions4 <- renderUI({selectInput("selectedRegions3", "Choose West Coast Region:", region_list3, multiple = FALSE) })
  output$regions4b <- renderUI({selectInput("selectedRegions3b", "Choose East Coast Region:", region_list3b, multiple = FALSE) })
  
  # These widgets are for the crosstabs tab.
  online5 = reactive({input$rb5})
  
  
  # Scat tab
  scatdf <- eventReactive(input$scataction, {
    print("Getting from data.world")
    query(
      data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
      dataset="jacobv/s-17-dv-final-project", type="sql",
      query="select p.State, p.Format, count(*) as Num_Stations, c.Female, c.Male, 
      100000*(count(*)/c.Female) as Fem_KPI, 100000*(count(*)/c.Male) as Male_KPI
      from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
      group by p.State
      order by p.State")
  })
  
  output$scatdata <- renderDataTable({DT::datatable(scatdf(), rownames = FALSE,
                                                      extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  
  output$scatplot <- renderPlotly({p <- ggplot(scatdf()) + 
    theme(axis.text.x=element_text(angle=90, size=16, vjust=0.5)) + 
    theme(axis.text.y=element_text(size=16, hjust=0.5)) +
    geom_point(aes(x=Fem_KPI, y=Male_KPI, colour=State), size=2) +
    geom_smooth(aes(x=Fem_KPI, y=Male_KPI, colour="black"), method=lm,   # Add linear regression line
                se=FALSE)    # Don't add shaded confidence region
  ggplotly(p)
  })
  
  # Aggregated measures tab
  aggdf <- eventReactive(input$aggaction, {
    print("Getting from data.world")
    query(
      data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
      dataset="jacobv/s-17-dv-final-project", type="sql",
      query="select p.State, p.Format, count(*) as Num_Stations, c.Total as sum_ppl,
      100000*(count(*)/c.Total) as KPI
      from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
      group by p.State, p.Format
      order by p.State, p.Format")
  })
  output$aggdata <- renderDataTable({DT::datatable(aggdf(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$aggplot <- renderPlotly({
    a <- ggplot(aggdf()) +
      geom_col(position = "stack", aes(x=sum_ppl, y=Num_Stations, color=KPI)) +
      theme(axis.text.x=element_text(angle=90, size=10, vjust=0.5))
    ggplotly(a)
  })
  
  # Non-agg tab
  nonaggdf <- eventReactive(input$nonaggaction, {
    print("Getting from data.world")
    query(
      data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
      dataset="jacobv/s-17-dv-final-project", type="sql",
      query="select p.State, p.Format, count(*) as Num_Stations, c.Total as sum_ppl, 
      100000*(count(*)/c.Total) as KPI
      from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
      group by p.State, p.Format
      order by p.State, p.Format")
  })
  output$nonaggdata <- renderDataTable({DT::datatable(nonaggdf(), rownames = FALSE,
                                                   extensions = list(Responsive = TRUE, FixedHeader = TRUE)
    )
    })
 
  
  output$nonaggplot <- renderPlotly({
    p <- ggplot(nonaggdf()) +
      geom_boxplot(aes(x=Format, y=KPI, color=KPI)) +
      ylim(0, 6) +
      theme(axis.text.x=element_text(angle=90, size=10, vjust=0.5))
    ggplotly(p)
  })
    
  #   renderPlot({ggplot(nonaggdf()) + geom_boxplot(aes(x=Format, y=KPI)) + ylim(0, 6) + 
  #     theme(axis.text.x=element_text(angle=90, size=14, hjust=0.5)) +
  #     theme(axis.text.y=element_text(size=16, vjust=0.5))  +
  #     geom_text(aes(x=Format, y=KPI, label=State), size=2.1)
  # })
    

    
  #  +
  #geom_text(aes(x=Format, y=KPI, label=State), size=2.1)
  
  # Begin Barchart Tab ------------------------------------------------------------------
  df2 <- eventReactive(input$click2, {
    if(input$selectedRegions == 'All') region_list <- input$selectedRegions
    else region_list <- append(list("Skip" = "Skip"), input$selectedRegions)
      print("Getting from data.world")
      tdf = query(
        data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
        dataset="jacobv/s-17-dv-final-project", type="sql",
        query="select State, Format, Count(*) as Amount
        from `PostETL-Radio`
        #The following line allows choosing which states to display
        where State in (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        group by State, Format
        order by State, Format",
        queryParameters = region_list
      )
  })
  output$data2 <- renderDataTable({DT::datatable(df2(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$plot2 <- renderPlot({ggplot(df2(), aes(x=Format, y=Amount)) +
      scale_y_continuous(labels = scales::comma) + # no scientific notation
      theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=12, hjust=0.5)) +
      geom_bar(stat = "identity") + 
      facet_wrap(~State, ncol=1) + 
      coord_flip() + 
      geom_text(mapping=aes(x=Format, y=Amount, label=round(Amount)),colour="black", hjust=-.5)
  })
  # End Barchart Tab ___________________________________________________________
  
  
  # Begin PLBarchart Tab ------------------------------------------------------------------
  df3 <- eventReactive(input$click3, {
    region_list2 <- append(input$selectedRegions2, input$selectedRegions2b)
    print("Getting from data.world")
    tdf = query(
      data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
      dataset="jacobv/s-17-dv-project-6", type="sql",
      query='select  p.State, c.`2016_Party_Popular_Vote` as Political_Leaning, p.Format, count(*) as Amount
                from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
                      where p.State in (?, ?) and c.`2016_Party_Popular_Vote` != ""
                      group by c.`2016_Party_Popular_Vote`, p.Format
                      order by c.`2016_Party_Popular_Vote`, p.Format',
      queryParameters = region_list2
    ) 
  })
  output$data3 <- renderDataTable({DT::datatable(df3(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$plot3 <- renderPlot({ggplot(df3(), aes(x=Format, y=Amount)) +
      scale_y_continuous(labels = scales::comma) + # no scientific notation
      theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=12, hjust=0.5)) +
      geom_bar(stat = "identity") + 
      facet_wrap(~State, ncol=1) + 
      coord_flip() + 
      # Add sum_sales, and (sum_sales - window_avg_sales) label.
      geom_text(mapping=aes(x=Format, y=Amount, label=round(Amount)),colour="black", hjust=-.5)
  })
  # End PLBarchart Tab ___________________________________________________________
  
  
  
  # Begin EWBarchart Tab ------------------------------------------------------------------
  df4 <- eventReactive(input$click4, {
    region_list3 <- append(input$selectedRegions3, input$selectedRegions3b)
    
    print("Getting from data.world")
    tdf = query(
      data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Omlhbm1vYmJzIiwiaXNzIjoiYWdlbnQ6aWFubW9iYnM6OmM1YWIzZjY4LTI4NDEtNDFhNS04OTlmLTNkZjhlMmRmYjlkNiIsImlhdCI6MTQ4NDg2NzI4Niwicm9sZSI6WyJ1c2VyX2FwaV93cml0ZSIsInVzZXJfYXBpX3JlYWQiXSwiZ2VuZXJhbC1wdXJwb3NlIjp0cnVlfQ.QBQa9S4qBJ1lU1iDfo8QVkY93BOXyHXQrzmYlfU0giWOgrLJuX9eELL8x3onRJk-SqNt4BC_U5UWitpUnewqqQ"),
      dataset="jacobv/s-17-dv-final-project", type="sql",
      query='select  p.State, c.Coast, p.Format, count(*) as Amount
                from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
      where p.State in (?, ?)
      group by c.Coast, p.Format
      order by c.Coast, p.Format',
      queryParameters = region_list3
    ) 
  })
  output$data4 <- renderDataTable({DT::datatable(df4(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$plot4 <- renderPlot({ggplot(df4(), aes(x=Format, y=Amount)) +
      scale_y_continuous(labels = scales::comma) + # no scientific notation
      theme(axis.text.x=element_text(angle=0, size=12, vjust=0.5)) + 
      theme(axis.text.y=element_text(size=12, hjust=0.5)) +
      geom_bar(stat = "identity") + 
      facet_wrap(~State, ncol=1) + 
      coord_flip() + 
      # Add sum_sales, and (sum_sales - window_avg_sales) label.
      geom_text(mapping=aes(x=Format, y=Amount, label=round(Amount)),colour="black", hjust=-.5)
  })
  # End EWBarchart Tab ___________________________________________________________
  
  # Begin Crosstab Tab ------------------------------------------------------------------
  df5 <- eventReactive(input$click5, {
    if(online5() == "capita") {
      print("Getting from data.world")
      query(
        data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
        dataset="jacobv/s-17-dv-final-project", type="sql",
        query="select p.State, p.Format, count(*) as Num_Stations, c.Total as sum_ppl, 
        100000*(count(*)/c.Total) as ratio,
        case
        when 100000*(count(*)/c.Total) < 1 then 'Low'
        when 100000*(count(*)/c.Total) < 3 then 'Medium'
        else 'High'
        end AS kpi
        from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
        group by p.State, p.Format
        order by p.State, p.Format"
      )
    }
    else if(online5() == "male") {
      query(
        data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
        dataset="jacobv/s-17-dv-project-5", type="sql",
        query="select p.State, p.Format, count(*) as Num_Stations, c.Male as sum_ppl, 
        100000*(count(*)/c.Male) as ratio,
        case
        when 100000*(count(*)/c.Male) < 2 then 'Low'
        when 100000*(count(*)/c.Male) < 5 then 'Medium'
        else 'High'
        end AS kpi
        from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
        group by p.State, p.Format
        order by p.State, p.Format"
      )
    }
    else {
      query(
        data.world(token = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJwcm9kLXVzZXItY2xpZW50Om5lZ2lua3JhaGJhciIsImlzcyI6ImFnZW50Om5lZ2lua3JhaGJhcjo6YzM3YzNiMTgtZmViMC00NTQ0LTg1NTMtYzUzYWY1NTJjNjk2IiwiaWF0IjoxNDg0ODY3MDY5LCJyb2xlIjpbInVzZXJfYXBpX3dyaXRlIiwidXNlcl9hcGlfcmVhZCJdLCJnZW5lcmFsLXB1cnBvc2UiOnRydWV9.ncSnTmsVhrpE4sLgSQoKNjBhMw0QFpl-bYfpaE-Cdor-hCRgXLrdUZs3jM7TscKym9tjRQv0ozX2nEG82MtWHw"),
        dataset="jacobv/s-17-dv-project-5", type="sql",
        query="select p.State, p.Format, count(*) as Num_Stations, c.Female as sum_ppl, 
        100000*(count(*)/c.Female) as ratio,
        case
        when 100000*(count(*)/c.Female) < 2 then 'Low'
        when 100000*(count(*)/c.Female) < 5 then 'Medium'
        else 'High'
        end AS kpi
        from `PostETL-Radio` as p inner join `Census` as c on (p.State=c.State)
        group by p.State, p.Format
        order by p.State, p.Format"
      )
    }
  })
  output$data5 <- renderDataTable({DT::datatable(df5(), rownames = FALSE,
                                                 extensions = list(Responsive = TRUE, FixedHeader = TRUE)
  )
  })
  output$plot5 <- renderPlot({ggplot(df5()) + 
      theme(axis.text.x=element_text(angle=90, size=14, hjust=0.5)) + 
      theme(axis.text.y=element_text(size=16, vjust=0.5)) + 
      geom_text(aes(x=Format, y=State, label=ratio), size=2.1) +
      geom_tile(aes(x=Format, y=State, fill=kpi), alpha=0.5)
  })
})
  # End Crosstab Tab ___________________________________________________________