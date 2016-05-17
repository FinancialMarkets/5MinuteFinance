library(xtable) 
library(tm)
library(wordcloud)
library(memoise)

# The list of valid books
books <<- list("April 2014" =  "minutes_april_2014",
               "March 2014" =  "minutes_march_2014",
               "January 2008" = "minutes_january_2008",
               "August 2007" = "minutes_august_2007",
               "September 2007" = "minutes_september_2007",
               "August 2007" = "minutes_august_2007")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(book %in% books))
    stop("Unknown book")

  text <- readLines(sprintf("./%s.txt.gz", book),
    encoding="UTF-8")

  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
         c(stopwords("SMART"), "Committee", "committee", "committee\'s", "the", "and", "but"))

  myDTM = TermDocumentMatrix(myCorpus,
              control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)

})
