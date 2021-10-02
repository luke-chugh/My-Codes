library(dplyr)
library(textclean)
library(tokenizers)

cleanData <- function(text) {
    
        profanityList <- readLines("googleprofanitylist.txt", warn = FALSE)
        removeWords <- function(str, stopwords) {
            x <- unlist(strsplit(str, " "))
            paste(x[!x %in% stopwords], collapse = " ")
        }
        text <- gsub("(ht|f)tp(s?)://\\S+", "", text)
        text <- gsub("@[^\\s]+", "", text)
        text <- gsub("[,.!?:;()]", " ", text)
        text <- replace_internet_slang(text)
        text <- tolower(text)
        text <- removeWords(text, profanityList)
        text <- replace_contraction(text)
        text <- gsub("\\s+", " ", text)
        text <- unlist(tokenize_words(text, lowercase = FALSE, strip_punct = TRUE,
                                      strip_numeric = TRUE, simplify = TRUE))
        text <- data_frame(text)
}   

predictFunction <- function(inputText) {
    
inputText <- cleanData(inputText)

    if(nrow(inputText) >= 3) {
        firstText <- paste(tail(inputText, 3)[1,], tail(inputText, 3)[2,], tail(inputText, 3)[3,])
        prediction <- quadGrams %>%
            filter(firstGram %in% firstText) %>%
            select(lastGram, n, p)
        if (nrow(prediction) < 5) {
            oldprediction <- prediction
            firstText <- paste(tail(inputText, 2)[2,], tail(inputText, 2)[1,])
            prediction <- triGrams %>%
                filter(firstGram %in% firstText) %>%
                select(lastGram, n, p)
            prediction <- rbind(oldprediction, prediction)
            if (nrow(prediction) < 5)  {
                oldprediction <- prediction
                firstText <- paste(tail(inputText, 1)[1,])
                prediction <- biGrams %>%
                    filter(firstGram %in% firstText) %>%
                    select(lastGram, n, p)
                prediction <- rbind(oldprediction, prediction)
                if (nrow(prediction) < 5)  {
                    oldprediction <- prediction
                    prediction <- uniGrams %>%
                    select(firstGram, n, p)
                    prediction <- rbind(oldprediction, prediction)
                }
            }
        }  
        return(prediction %>% group_by(lastGram) %>% summarise_all(sum) %>% ungroup() %>% arrange(desc(p)))
}
    else if(nrow(inputText) == 2) {
        firstText <- paste(tail(inputText, 2)[2,], tail(inputText, 2)[1,])
        prediction <- triGrams %>%
            filter(firstGram %in% firstText) %>%
            select(lastGram, n, p)
        if (nrow(prediction) < 5)  {
            oldprediction <- prediction
            firstText <- paste(tail(inputText, 1)[1,])
            prediction <- biGrams %>%
                filter(firstGram %in% firstText) %>%
                select(lastGram, n, p)
            prediction <- rbind(oldprediction, prediction)
            if (nrow(prediction) < 5)  {
                oldprediction <- prediction
                prediction <- uniGrams %>%
                select(firstGram, n, p)
                prediction <- rbind(oldprediction, prediction)
            }
        }
        return(prediction %>% group_by(lastGram) %>% summarise_all(sum) %>% ungroup() %>% arrange(desc(p)))
}     
    else if(nrow(inputText) == 1) {
        firstText <- paste(tail(inputText, 1)[1,])
        prediction <- biGrams %>%
            filter(firstGram %in% firstText) %>%
            select(lastGram, n, p)
        if (nrow(prediction) < 5) {
            prediction <- uniGrams %>%
            select(firstGram, n, p)
        }     
        return(prediction %>% group_by(lastGram) %>% summarise_all(sum) %>% ungroup() %>% arrange(desc(p)))
    }
}

