Data Science Capstone: Predicting the Next Word
========================================================
author: Amyas Walji
date:  November, 2019
autosize: true
transition: rotate
transition-speed: slow
incremental: true
font-import: http://fonts.googleapis.com/css?family=Helvetica
font-family: 'Helvetica'

<div>
<img src="coursera.png" style="width:15%"
</div>

Overview
========================================================

<small>The recent advances in mobile technology have enabled people to stay connected on the go. However, to communicate by text swiftly without error on a smartphone keyboard is rather challenging without any language prediction.</small> 

<small>In this backdrop, the purpose of the Data Science Capstone project was to develop a data product which uses natural language processing to predict the next word a user may want to type. A shiny application serves as the final product for this project.</small>

<small>The application is available at the following link:
<a href="http://45.55.48.122/" target="_blank">Shiny App</a>.</small>

Model and algorithm
========================================================

<small>The prediction algorithm developed is based on an N-Gram Language Model. This model uses a Markov Assumption in which each word depends only on the previous N words in a given string of text. For this project a series of four N-gram models have been constructed:</small><small>

* Unigram: previous words do not matter
* Bigram: only the previous word matters
* Trigram: only the previous two words matter
* Quadgram: only the previous three words matter.</small>

<small>
Given this dictionary of N-grams, the probability for possible next words is calculated through Maximum-Likelihood Estimation combined with Good Turing Smoothing. Depending on the length of text input, the prediction algorithm selects candidates from appropriately ranked N-grams. This mechanism is known as the "The Stupid Backoff algorithm", a highly efficient and inexpensive algorithm proposed by Thorsten Brants et al (2007). </small>   


The Application
========================================================
left: 55%
incremental: true
<div>
<img src="CapstoneApp.png" style="width:105%"
</div>
<small>
The user is presented with a text input box which when filled out with a word or short phrase returns:
* A top prediction 
* A dynamic table suggesting possible next words 
* A word cloud visualizing the predictions.</small> 

***
<small>
The Shiny app dashboard:
* Offers an intuitive and simple graphical user interface 
* Can easily be adapted for educational and commercial uses.</small>

Thanks!
========================================================
incremental: false

<small>
Shiny App    
<a href="http://45.55.48.122/" target="_blank">Link</a>.

Shiny App Source Code on Github    
<a href="https://github.com/wowkazmir/Data-Science-Capstone" target="_blank">Link</a>.

Data Science Capstone on Coursera    
<a href="https://www.coursera.org/learn/data-science-project" target="_blank">Link</a>.


**References**
<small>
Thorsten Brants, Ashok C. Popat, Peng Xu, Franz J. Och, Jeffrey Dean. (2007), Large language
models in machine translation. In Proceedings of the 2007 Joint Conference on Empirical Methods
in Natural Language Processing and Computational Language Learning, pages 858-867.</small> 
