source("predictInput.R")

library(DT)
library(shiny)
library(shinydashboard)
library(wordcloud)
library(RColorBrewer)

shinyServer(
    function(input, output) {
        prediction <-  reactive( {
            inputText <- input$text
            predictFunction(inputText)
})
    
    output$table <- renderDT({
        if (is.null(prediction))
            return(NULL)
        datatable(prediction(), options = list(lengthMenu = c(5, 10, 25)))
}) 
    
    output$topPrediction <- renderValueBox({
        
        valueBox(
            paste0(prediction()$lastGram[1]), "Next word", icon = icon("list"),
            color = "olive")
    })
    
    wordcloud_rep <- repeatable(wordcloud)
    output$plot <- renderPlot(
        wordcloud_rep(
            prediction()$lastGram,
            prediction()$p,
            use.r.layout = FALSE, random.order = FALSE,
            colors = brewer.pal(6, 'Dark2'), scale=c(4, 1), max.words = 50))
})