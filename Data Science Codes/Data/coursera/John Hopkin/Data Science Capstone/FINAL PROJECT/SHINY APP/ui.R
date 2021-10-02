library(DT)
library(shiny)
library(shinydashboard)

dashboardPage(
    skin = "green",
    dashboardHeader(title = "Swiftkey Capstone"),
    dashboardSidebar(id="",
    sidebarMenu(
        menuItem("Next Word Prediction", tabName = "main", icon = icon("keyboard")),
        menuItem("Documentation", tabName = "extra", icon = icon("book"))
        ) ),
    
    dashboardBody(
        tabItems(
            tabItem(
                tabName = "main", h1("Next Word Prediction"),
                
            fluidRow(
                box(title="Type in word(s) below:",
                    textAreaInput(inputId="text", label= NULL, width="200px", value=""), status = "success", solidHeader = TRUE,),
                
                valueBoxOutput("topPrediction", width=6) ),
                
            fluidRow( 
                box(
                    title = "Possible next words",
                    collapsible = TRUE, status = "success", solidHeader = TRUE,
                    div(DTOutput('table'), style = "height: 300px")),
                
                box(
                    title = "Word cloud",
                    collapsible = TRUE, status = "success", solidHeader = TRUE,
                    plotOutput("plot", height = "300px"))
                )),
            #tab item 2
            tabItem(
                tabName = "extra", h1("Documentation"),
                fluidRow(
                    box(width=12,
                        h4("This application serves as the final product for the Data Science Capstone project on Coursera. Over the course of seven weeks one was to apply all the skills learned during the Data Science Specialization. A big part of the challenge involved figuring out how to work with a new type of data to develop a working prediction algorithm and ultimately a useful data product.", 
                        tags$br(), tags$br(), 
                        "Based on an N-Gram Language Model, the prediction algorithm developed provides fitting suggestions to allow for words and thoughts going forward.",              tags$br(), tags$br(),  
                           "The source code along with further information on the project can be found here:", tags$a("Source Code", href= "https://github.com/wowkazmir/Data-Science-Capstone"), style = "font-size: 125%"))))
    ))
)
    

    