library(shiny)
library(shinythemes)

ui_prova<-navbarPage('Sections',theme = shinytheme("journal"),
                     tabPanel('Plot',
  titlePanel(h1("Occurrences of concepts with R",h6("by",em("Iacopo Ghinassi")))),
  
  sidebarLayout(
    sidebarPanel(h2("Text Input",align='center'),width=3,
                 fluidRow(
                   fileInput("file1",h6("File input")),
                   fileInput("file2",h6("File input")),
                   fileInput("file3",h6("File input")),
                   fileInput("file4",h6("File input")),
                   fileInput("file5",h6("File input"))),
                 h4('Press Submit to include dictionaries and parameters'),
                 submitButton("Submit")),
    mainPanel(column(12,h2("Occurrences Plot"),align="center"),
              column(12,plotOutput(outputId = "graphfreq"),align="center",style="background-color:#ccccff"),
              column(12,br()),
              column(4, selectInput("type_of_frequency","Type of Frequency:",c(absolute="absolute",relative="relative"))),
                     column(4,selectInput('language','Language:',c('english','spanish', 'german','italian'))),
              br(),
  column(12,h3('Dictionaries (Concepts)'),align='center'),
                 fluidRow(column(3,textInput("dictionary1",label = "Insert 1st dictionary's words",
              value = "write something"),
    textInput("dictionary2",label = "Insert 2nd dictionary's words",
              value = "write something")),
    column(3,
    textInput("dictionary3",label = "Insert 3rd dictionary's words",
              value = "write something"),
    textInput("dictionary4",label = "Insert 4th dictionary's words",
              value = "write something")),
    
    column(3,textInput("dictionary5",label = "Insert 5th dictionary's words",
              value = "write something"),
    textInput("dictionary6",label = "Insert 6th dictionary's words",
              value = "write something")),
    column(3,textInput("dictionary7",label = "Insert 7th dictionary's words",
              value = "write something"),textInput("dictionary8",label = "Insert 8th dictionary's words",
              value = "write something")),
    column(6,
    textInput("dictionary9",label = "Insert 9th dictionary's words",
              value = "write something"),align='center'),
    column(6,
    textInput("dictionary10",label = "Insert 10th dictionary's words",
              value = "write something"),align='center'))))),
  tabPanel("Data",
           mainPanel(DT::dataTableOutput('data'))))

server_prova<-function(input,output,session){
  output$graphfreq <- renderPlot({
    library(tm)
    library(stringr)
    library(readr)
    library(ggplot2)
    if(is.null(input$file1)){
      return(title("No text"))
    }
    else{
      num_texts<-1
      if(length(input$file2))(num_texts<-num_texts+1)
      if(length(input$file3))(num_texts<-num_texts+1)
      if(length(input$file4))(num_texts<-num_texts+1)
      if(length(input$file5))(num_texts<-num_texts+1)
      print(num_texts)
      if(num_texts==1){
      text<-readLines(input$file1$datapath)
      text<-paste(text,collapse = " ")
      preproc_text<-gsub("((?:\b| )?([.,:;!?]+)(?: |\b)?)", " \\1 ", text, perl=T)
      preproc_text<-stemDocument(preproc_text)
      preproc_text<-paste(preproc_text, collapse = " ")
      print(head(preproc_text))
      dict_list<-list()
      dict_list[[1]]<-vector()
      dict_list[[1]]<-input$dictionary1
      dict_list[[1]]<-strsplit(dict_list[[1]], ",")
      dict_list[[1]]<-unlist(dict_list[[1]])
      dict_list[[1]]<-str_trim(dict_list[[1]])
      dict_list[[2]]<-vector()
      dict_list[[2]]<-input$dictionary2
      dict_list[[2]]<-strsplit(dict_list[[2]], ",")
      dict_list[[2]]<-unlist(dict_list[[2]])
      dict_list[[2]]<-str_trim(dict_list[[2]])
      dict_list[[3]]<-vector()
      dict_list[[3]]<-input$dictionary3
      dict_list[[3]]<-strsplit(dict_list[[3]], ",")
      dict_list[[3]]<-unlist(dict_list[[3]])
      dict_list[[3]]<-str_trim(dict_list[[3]])
      dict_list[[4]]<-vector()
      dict_list[[4]]<-input$dictionary4
      dict_list[[4]]<-strsplit(dict_list[[4]], ",")
      dict_list[[4]]<-unlist(dict_list[[4]])
      dict_list[[4]]<-str_trim(dict_list[[4]])
      dict_list[[5]]<-vector()
      dict_list[[5]]<-input$dictionary5
      dict_list[[5]]<-strsplit(dict_list[[5]], ",")
      dict_list[[5]]<-unlist(dict_list[[5]])
      dict_list[[5]]<-str_trim(dict_list[[5]])
      dict_list[[6]]<-vector()
      dict_list[[6]]<-input$dictionary6
      dict_list[[6]]<-strsplit(dict_list[[6]], ",")
      dict_list[[6]]<-unlist(dict_list[[6]])
      dict_list[[6]]<-str_trim(dict_list[[6]])
      dict_list[[7]]<-vector()
      dict_list[[7]]<-input$dictionary7
      dict_list[[7]]<-strsplit(dict_list[[7]], ",")
      dict_list[[7]]<-unlist(dict_list[[7]])
      dict_list[[7]]<-str_trim(dict_list[[7]])
      dict_list[[8]]<-vector()
      dict_list[[8]]<-input$dictionary8
      dict_list[[8]]<-strsplit(dict_list[[8]], ",")
      dict_list[[8]]<-unlist(dict_list[[8]])
      dict_list[[8]]<-str_trim(dict_list[[8]])
      dict_list[[9]]<-vector()
      dict_list[[9]]<-input$dictionary9
      dict_list[[9]]<-strsplit(dict_list[[9]], ",")
      dict_list[[9]]<-unlist(dict_list[[9]])
      dict_list[[9]]<-str_trim(dict_list[[9]])
      dict_list[[10]]<-vector()
      dict_list[[10]]<-input$dictionary10
      dict_list[[10]]<-strsplit(dict_list[[10]], ",")
      dict_list[[10]]<-unlist(dict_list[[10]])
      dict_list[[10]]<-str_trim(dict_list[[10]])
      for (i in 1:10) {
        if(length(dict_list[[i]])==0){
          dict_list[[i]][1]<-"write something"
        }
      }
      if (dict_list[[1]][1]=="write something") {
        title(warning("WRITE AT LEAST ONE DICTIONARY!"))
      }
      else{
        for (i in length(dict_list):1) {
          if (dict_list[[i]][1]=="write something") {
            dict_list[[i]]<-NULL
          }
        }
        for (i in 1:length(dict_list)) {
          dict_list[[i]]<-append(dict_list[[i]],stemDocument(dict_list[[i]],language = "english"))# Select the language that apply
        }
        
        All_dict_words_to1term <- function(starting_doc,dict,sub_term){
          for (i in 1:length(dict)) {
            if (i==1){
              new_doc<-str_replace_all(starting_doc,dict[i],sub_term)
            }
            else{
              new_doc<-str_replace_all(new_doc,dict[i],sub_term)
            }
          }
          return(new_doc)
        }
        
        # Function to iterate the previous function over several dictionaries and create a list of the texts thus processed (the final element of the list is the one processed after all of the dictionaries)
        All_dict_words_to1term_fin <-  function(starting_doc,dictionaries){
          result<-list()
          for (i in 1:length(dictionaries)) {
            if (i==1) {
              result[[i]]<-All_dict_words_to1term(starting_doc,dictionaries[[i]],dictionaries[[i]][1])
            }
            else{
              result[[i]]<-All_dict_words_to1term(result[[i-1]],dictionaries[[i]],dictionaries[[i]][1])
            }
          }
          return(result)
        }
        processed_text<-All_dict_words_to1term_fin(preproc_text,dict_list)
        processed_text<-processed_text[[length(dict_list)]]
        
        dict_new<-vector()
        for (i in 1:length(dict_list)) {
          dict_new[i] <- dict_list[[i]][1]
        }
        dict_new<-tolower(dict_new)
        print(dict_new)
        
        node_reference<- data.frame(dict_new, c(1:length(dict_new)))
        node_reference<-node_reference[,2]
        node_reference<-`names<-`(node_reference,dict_new)
        
        strsplit_space_tokenizer <- function(x)
          unlist(strsplit(as.character(x), "[[:space:]]+"))
        if(input$language=='english'){
          ctrl<- list(
            tokenize = strsplit_space_tokenizer,
            language="en", # Change the                                                           language if needed
            removePunctuation = TRUE,
            removeNumbers =TRUE,
            stopwords=TRUE)}
        if(input$language=='spanish'){
          ctrl<- list(
            tokenize = strsplit_space_tokenizer,
            language="spanish", # Change the                                                           language if needed
            removePunctuation = TRUE,
            removeNumbers =TRUE,
            stopwords=TRUE)}
        if(input$language=='german'){
          ctrl<- list(
            tokenize = strsplit_space_tokenizer,
            language="german", # Change the                                                           language if needed
            removePunctuation = TRUE,
            removeNumbers =TRUE,
            stopwords=TRUE)}
        if(input$language=='italian'){
          ctrl<- list(
            tokenize = strsplit_space_tokenizer,
            language="italian", # Change the                                                           language if needed
            removePunctuation = TRUE,
            removeNumbers =TRUE,
            stopwords=TRUE)}
        termFreq2<-function(x){
          termFreq(x, 
                   control = ctrl)
        }
        
        processed_text<-iconv(processed_text, "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage
        Text_freq<-termFreq2(processed_text)
        Text_freq<-Text_freq[dict_new]
        
        nodes_df<-data.frame(dict_new,node_reference,Text_freq)
        
        
        Occurrences<-vector()
        
        texts<-vector()
        
        dictionaries<-vector()
        
          texts<-append(texts,replicate(length(dict_new),paste('text',1)))
          dictionaries<-append(dictionaries,dict_new)
          Occurrences<- append(Occurrences,nodes_df[,3])
        
        
        newer_df<-data.frame(as.factor(texts),
                             as.factor(dictionaries),Occurrences)
        ggplot(data = newer_df,aes
               (x=newer_df$as.factor.texts.,y=newer_df$Occurrences,
                 fill= newer_df$as.factor.dictionaries.))+geom_col()+
          theme_classic()+xlab('Texts')+
          ylab('Absolute Frequency')+labs(fill='Dictionaries')}}
      else{
        list_text<-list()
          list_text[[1]]<-readLines(input$file1$datapath)
          list_text[[2]]<-readLines(input$file2$datapath)
        if(num_texts>2){list_text[[3]]<-readLines(input$file3$datapath)}
          if(num_texts>3){list_text[[4]]<-readLines(input$file4$datapath)}
          if(num_texts>4){list_text[[5]]<-readLines(input$file5$datapath)}
        for(i in 1:num_texts) {
          preproc_text_list[[i]]<-paste(list_text[[i]], collapse = ' ')
          preproc_text_list[[i]]<-gsub("((?:\b| )?([.,:;!?]+)(?: |\b)?)", " \\1 ", preproc_text_list[[i]], perl=T)#Add space between words and punctuation
          preproc_text_list[[i]]<-stemDocument(preproc_text_list[[i]])#Stemm the texts
          preproc_text_list[[i]]<-paste(preproc_text_list[[i]], collapse = " ")
          preproc_text_list[[i]]<-`names<-`(preproc_text_list[[i]],paste("text",i,"_c",sep = ""))
        }
        dict_list<-list()
        dict_list[[1]]<-vector()
        dict_list[[1]]<-input$dictionary1
        dict_list[[1]]<-strsplit(dict_list[[1]], ",")
        dict_list[[1]]<-unlist(dict_list[[1]])
        dict_list[[1]]<-str_trim(dict_list[[1]])
        dict_list[[2]]<-vector()
        dict_list[[2]]<-input$dictionary2
        dict_list[[2]]<-strsplit(dict_list[[2]], ",")
        dict_list[[2]]<-unlist(dict_list[[2]])
        dict_list[[2]]<-str_trim(dict_list[[2]])
        dict_list[[3]]<-vector()
        dict_list[[3]]<-input$dictionary3
        dict_list[[3]]<-strsplit(dict_list[[3]], ",")
        dict_list[[3]]<-unlist(dict_list[[3]])
        dict_list[[3]]<-str_trim(dict_list[[3]])
        dict_list[[4]]<-vector()
        dict_list[[4]]<-input$dictionary4
        dict_list[[4]]<-strsplit(dict_list[[4]], ",")
        dict_list[[4]]<-unlist(dict_list[[4]])
        dict_list[[4]]<-str_trim(dict_list[[4]])
        dict_list[[5]]<-vector()
        dict_list[[5]]<-input$dictionary5
        dict_list[[5]]<-strsplit(dict_list[[5]], ",")
        dict_list[[5]]<-unlist(dict_list[[5]])
        dict_list[[5]]<-str_trim(dict_list[[5]])
        dict_list[[6]]<-vector()
        dict_list[[6]]<-input$dictionary6
        dict_list[[6]]<-strsplit(dict_list[[6]], ",")
        dict_list[[6]]<-unlist(dict_list[[6]])
        dict_list[[6]]<-str_trim(dict_list[[6]])
        dict_list[[7]]<-vector()
        dict_list[[7]]<-input$dictionary7
        dict_list[[7]]<-strsplit(dict_list[[7]], ",")
        dict_list[[7]]<-unlist(dict_list[[7]])
        dict_list[[7]]<-str_trim(dict_list[[7]])
        dict_list[[8]]<-vector()
        dict_list[[8]]<-input$dictionary8
        dict_list[[8]]<-strsplit(dict_list[[8]], ",")
        dict_list[[8]]<-unlist(dict_list[[8]])
        dict_list[[8]]<-str_trim(dict_list[[8]])
        dict_list[[9]]<-vector()
        dict_list[[9]]<-input$dictionary9
        dict_list[[9]]<-strsplit(dict_list[[9]], ",")
        dict_list[[9]]<-unlist(dict_list[[9]])
        dict_list[[9]]<-str_trim(dict_list[[9]])
        dict_list[[10]]<-vector()
        dict_list[[10]]<-input$dictionary10
        dict_list[[10]]<-strsplit(dict_list[[10]], ",")
        dict_list[[10]]<-unlist(dict_list[[10]])
        dict_list[[10]]<-str_trim(dict_list[[10]])
        for (i in 1:10) {
          if(length(dict_list[[i]])==0){
            dict_list[[i]][1]<-"write something"
          }
        }
        if (dict_list[[1]][1]=="write something") {
          title(warning("WRITE AT LEAST ONE DICTIONARY!"))
        }
        else{
          for (i in length(dict_list):1) {
            if (dict_list[[i]][1]=="write something") {
              dict_list[[i]]<-NULL
            }
          }
          for (i in 1:length(dict_list)) {
            dict_list[[i]]<-append(dict_list[[i]],stemDocument(dict_list[[i]],language = "english"))# Select the language that apply
          }
          
          All_dict_words_to1term <- function(starting_doc,dict,sub_term){
            for (i in 1:length(dict)) {
              if (i==1){
                new_doc<-str_replace_all(starting_doc,dict[i],sub_term)
              }
              else{
                new_doc<-str_replace_all(new_doc,dict[i],sub_term)
              }
            }
            return(new_doc)
          }
          
          # Function to iterate the previous function over several dictionaries and create a list of the texts thus processed (the final element of the list is the one processed after all of the dictionaries)
          All_dict_words_to1term_fin <-  function(starting_doc,dictionaries){
            result<-list()
            for (i in 1:length(dictionaries)) {
              if (i==1) {
                result[[i]]<-All_dict_words_to1term(starting_doc,dictionaries[[i]],dictionaries[[i]][1])
              }
              else{
                result[[i]]<-All_dict_words_to1term(result[[i-1]],dictionaries[[i]],dictionaries[[i]][1])
              }
            }
            return(result)
          }
          
          processed_text_list<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-All_dict_words_to1term_fin(preproc_text_list[[i]], dict_list)
            processed_text_list[[i]]<-processed_text_list[[i]][[length(dict_list)]]}
          dict_new<-vector()
          for (i in 1:length(dict_list)) {
            dict_new[i] <- dict_list[[i]][1]
          }
          dict_new<-tolower(dict_new)
          print(dict_new)
          
          node_reference<- data.frame(dict_new, c(1:length(dict_new)))
          node_reference<-node_reference[,2]
          node_reference<-`names<-`(node_reference,dict_new)
            
          strsplit_space_tokenizer <- function(x)
            unlist(strsplit(as.character(x), "[[:space:]]+"))
          if(input$language=='english'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="en", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='spanish'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="spanish", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='german'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="german", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='italian'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="italian", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          termFreq2<-function(x){
            termFreq(x, 
                     control = ctrl)
          }
          
          # Creating texts' frequencies (i.e. absolute occurrences) vector for the concepts of interest
          Text_freq<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-iconv(processed_text_list[[i]], "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage
            Text_freq[[i]]<-termFreq2(processed_text_list[[i]])
            Text_freq[[i]]<-Text_freq[[i]][dict_new]
          }
          
          Text_freq_rel<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-iconv(processed_text_list[[i]], "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage  
            Text_freq_rel[[i]]<- Text_freq[[i]]/sum(termFreq2(processed_text_list[[i]]))*100
          }
          
          Nodes_df_list<-list()
          for (i in 1:num_texts) {
            Nodes_df_list[[i]]<- data.frame(dict_new,node_reference,Text_freq[[i]],Text_freq_rel[[i]])
            Nodes_df_list[[i]]<-`names<-`(Nodes_df_list[[i]], c('Label','ID','Absolute Occurence', 'Relative Occurrence'))
          }
          
          Occurrences<-vector()
          texts<-vector()
          dictionaries<-vector()
          
          texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file1[1]),1,nchar(as.character(input$file1[1]))-4)))
          texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file2[1]),1,nchar(as.character(input$file2[1]))-4)))
          if(length(input$file3))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file3[1]),1,nchar(as.character(input$file3[1]))-4)))
          if(length(input$file4))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file4[1]),1,nchar(as.character(input$file4[1]))-4)))
          if(length(input$file5))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file5[1]),1,nchar(as.character(input$file5[1]))-4)))
          
          for (i in 1:num_texts) {
            #texts<-append(texts,replicate(length(dict_new),paste('text',i)))
            dictionaries<-append(dictionaries,dict_new)
            Occurrences<- append(Occurrences,Nodes_df_list[[i]]$`Absolute Occurence`)
          }
          
          newer_df<-data.frame(as.factor(texts),
                               as.factor(dictionaries),Occurrences)
          
          # Same of before but with relative occurrences
          Rel_occurrences<-vector()
          for (i in 1:num_texts) {
            Rel_occurrences<-append(Rel_occurrences,Nodes_df_list[[i]]$`Relative Occurrence`)
          }
          
          newer_rel_df<-data.frame(as.factor(texts),
                                   as.factor(dictionaries),Rel_occurrences)
          
          #Create Plots with ggplot2
          #Absolute Occurrences
          Abs_plot<-ggplot(data = newer_df,aes
                           (x=newer_df$as.factor.texts.,y=newer_df$Occurrences,
                             fill= newer_df$as.factor.dictionaries.))+geom_col()+
            theme_classic()+xlab('Texts')+
            ylab('Absolute Frequency')+labs(fill='Dictionaries')
          #Relative Occurrences
          Rel_plot<-ggplot(data = newer_rel_df,aes
                           (x=newer_rel_df$as.factor.texts.,y=newer_rel_df$Rel_occurrences,
                             fill= newer_rel_df$as.factor.dictionaries.))+geom_col()+
            theme_classic()+xlab('Texts')+
            ylab('Relative Frequency')+labs(fill='Dictionaries')
          
          if(input$type_of_frequency=='absolute'){
            Abs_plot
          }
          else{
            Rel_plot
          }
        }}}})
  
  output$data<-DT::renderDataTable({
    library(tm)
    library(stringr)
    library(readr)
    library(ggplot2)
    if(is.null(input$file1)){
      return(title("No text"))
    }
    else{
      num_texts<-1
      if(length(input$file2))(num_texts<-num_texts+1)
      if(length(input$file3))(num_texts<-num_texts+1)
      if(length(input$file4))(num_texts<-num_texts+1)
      if(length(input$file5))(num_texts<-num_texts+1)
      print(num_texts)
      if(num_texts==1){
        text<-readLines(input$file1$datapath)
        text<-paste(text,collapse = " ")
        preproc_text<-gsub("((?:\b| )?([.,:;!?]+)(?: |\b)?)", " \\1 ", text, perl=T)
        preproc_text<-stemDocument(preproc_text)
        preproc_text<-paste(preproc_text, collapse = " ")
        dict_list<-list()
        dict_list[[1]]<-vector()
        dict_list[[1]]<-input$dictionary1
        dict_list[[1]]<-strsplit(dict_list[[1]], ",")
        dict_list[[1]]<-unlist(dict_list[[1]])
        dict_list[[1]]<-str_trim(dict_list[[1]])
        dict_list[[2]]<-vector()
        dict_list[[2]]<-input$dictionary2
        dict_list[[2]]<-strsplit(dict_list[[2]], ",")
        dict_list[[2]]<-unlist(dict_list[[2]])
        dict_list[[2]]<-str_trim(dict_list[[2]])
        dict_list[[3]]<-vector()
        dict_list[[3]]<-input$dictionary3
        dict_list[[3]]<-strsplit(dict_list[[3]], ",")
        dict_list[[3]]<-unlist(dict_list[[3]])
        dict_list[[3]]<-str_trim(dict_list[[3]])
        dict_list[[4]]<-vector()
        dict_list[[4]]<-input$dictionary4
        dict_list[[4]]<-strsplit(dict_list[[4]], ",")
        dict_list[[4]]<-unlist(dict_list[[4]])
        dict_list[[4]]<-str_trim(dict_list[[4]])
        dict_list[[5]]<-vector()
        dict_list[[5]]<-input$dictionary5
        dict_list[[5]]<-strsplit(dict_list[[5]], ",")
        dict_list[[5]]<-unlist(dict_list[[5]])
        dict_list[[5]]<-str_trim(dict_list[[5]])
        dict_list[[6]]<-vector()
        dict_list[[6]]<-input$dictionary6
        dict_list[[6]]<-strsplit(dict_list[[6]], ",")
        dict_list[[6]]<-unlist(dict_list[[6]])
        dict_list[[6]]<-str_trim(dict_list[[6]])
        dict_list[[7]]<-vector()
        dict_list[[7]]<-input$dictionary7
        dict_list[[7]]<-strsplit(dict_list[[7]], ",")
        dict_list[[7]]<-unlist(dict_list[[7]])
        dict_list[[7]]<-str_trim(dict_list[[7]])
        dict_list[[8]]<-vector()
        dict_list[[8]]<-input$dictionary8
        dict_list[[8]]<-strsplit(dict_list[[8]], ",")
        dict_list[[8]]<-unlist(dict_list[[8]])
        dict_list[[8]]<-str_trim(dict_list[[8]])
        dict_list[[9]]<-vector()
        dict_list[[9]]<-input$dictionary9
        dict_list[[9]]<-strsplit(dict_list[[9]], ",")
        dict_list[[9]]<-unlist(dict_list[[9]])
        dict_list[[9]]<-str_trim(dict_list[[9]])
        dict_list[[10]]<-vector()
        dict_list[[10]]<-input$dictionary10
        dict_list[[10]]<-strsplit(dict_list[[10]], ",")
        dict_list[[10]]<-unlist(dict_list[[10]])
        dict_list[[10]]<-str_trim(dict_list[[10]])
        for (i in 1:10) {
          if(length(dict_list[[i]])==0){
            dict_list[[i]][1]<-"write something"
          }
        }
        if (dict_list[[1]][1]=="write something") {
          title(warning("WRITE AT LEAST ONE DICTIONARY!"))
        }
        else{
          for (i in length(dict_list):1) {
            if (dict_list[[i]][1]=="write something") {
              dict_list[[i]]<-NULL
            }
          }
          for (i in 1:length(dict_list)) {
            dict_list[[i]]<-append(dict_list[[i]],stemDocument(dict_list[[i]],language = "english"))# Select the language that apply
          }
          
          All_dict_words_to1term <- function(starting_doc,dict,sub_term){
            for (i in 1:length(dict)) {
              if (i==1){
                new_doc<-str_replace_all(starting_doc,dict[i],sub_term)
              }
              else{
                new_doc<-str_replace_all(new_doc,dict[i],sub_term)
              }
            }
            return(new_doc)
          }
          
          # Function to iterate the previous function over several dictionaries and create a list of the texts thus processed (the final element of the list is the one processed after all of the dictionaries)
          All_dict_words_to1term_fin <-  function(starting_doc,dictionaries){
            result<-list()
            for (i in 1:length(dictionaries)) {
              if (i==1) {
                result[[i]]<-All_dict_words_to1term(starting_doc,dictionaries[[i]],dictionaries[[i]][1])
              }
              else{
                result[[i]]<-All_dict_words_to1term(result[[i-1]],dictionaries[[i]],dictionaries[[i]][1])
              }
            }
            return(result)
          }
          processed_text<-All_dict_words_to1term_fin(preproc_text,dict_list)
          processed_text<-processed_text[[length(dict_list)]]
          
          dict_new<-vector()
          for (i in 1:length(dict_list)) {
            dict_new[i] <- dict_list[[i]][1]
          }
          dict_new<-tolower(dict_new)
          print(dict_new)
          
          node_reference<- data.frame(dict_new, c(1:length(dict_new)))
          node_reference<-node_reference[,2]
          node_reference<-`names<-`(node_reference,dict_new)
          
          strsplit_space_tokenizer <- function(x)
            unlist(strsplit(as.character(x), "[[:space:]]+"))
          if(input$language=='english'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="en", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='spanish'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="spanish", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='german'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="german", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='italian'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="italian", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          termFreq2<-function(x){
            termFreq(x, 
                     control = ctrl)
          }
          
          processed_text<-iconv(processed_text, "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage
          Text_freq<-termFreq2(processed_text)
          Text_freq<-Text_freq[dict_new]
          
          nodes_df<-data.frame(dict_new,node_reference,Text_freq)
          
          
          Occurrences<-vector()
          
          texts<-vector()
          
          dictionaries<-vector()
          
          texts<-append(texts,replicate(length(dict_new),paste('text',1)))
          dictionaries<-append(dictionaries,dict_new)
          Occurrences<- append(Occurrences,nodes_df[,3])
          
          
          newer_df<-data.frame(as.factor(texts),
                               as.factor(dictionaries),Occurrences)
          ggplot(data = newer_df,aes
                 (x=newer_df$as.factor.texts.,y=newer_df$Occurrences,
                   fill= newer_df$as.factor.dictionaries.))+geom_col()+
            theme_classic()+xlab('Texts')+
            ylab('Absolute Frequency')+labs(fill='Dictionaries')}}
      else{
        list_text<-list()
        list_text[[1]]<-readLines(input$file1$datapath)
        list_text[[2]]<-readLines(input$file2$datapath)
        if(num_texts>2){list_text[[3]]<-readLines(input$file3$datapath)}
        if(num_texts>3){list_text[[4]]<-readLines(input$file4$datapath)}
        if(num_texts>4){list_text[[5]]<-readLines(input$file5$datapath)}
        for(i in 1:num_texts) {
          preproc_text_list[[i]]<-paste(list_text[[i]], collapse = ' ')
          preproc_text_list[[i]]<-gsub("((?:\b| )?([.,:;!?]+)(?: |\b)?)", " \\1 ", preproc_text_list[[i]], perl=T)#Add space between words and punctuation
          preproc_text_list[[i]]<-stemDocument(preproc_text_list[[i]])#Stemm the texts
          preproc_text_list[[i]]<-paste(preproc_text_list[[i]], collapse = " ")
          preproc_text_list[[i]]<-`names<-`(preproc_text_list[[i]],paste("text",i,"_c",sep = ""))
        }
        dict_list<-list()
        dict_list[[1]]<-vector()
        dict_list[[1]]<-input$dictionary1
        dict_list[[1]]<-strsplit(dict_list[[1]], ",")
        dict_list[[1]]<-unlist(dict_list[[1]])
        dict_list[[1]]<-str_trim(dict_list[[1]])
        dict_list[[2]]<-vector()
        dict_list[[2]]<-input$dictionary2
        dict_list[[2]]<-strsplit(dict_list[[2]], ",")
        dict_list[[2]]<-unlist(dict_list[[2]])
        dict_list[[2]]<-str_trim(dict_list[[2]])
        dict_list[[3]]<-vector()
        dict_list[[3]]<-input$dictionary3
        dict_list[[3]]<-strsplit(dict_list[[3]], ",")
        dict_list[[3]]<-unlist(dict_list[[3]])
        dict_list[[3]]<-str_trim(dict_list[[3]])
        dict_list[[4]]<-vector()
        dict_list[[4]]<-input$dictionary4
        dict_list[[4]]<-strsplit(dict_list[[4]], ",")
        dict_list[[4]]<-unlist(dict_list[[4]])
        dict_list[[4]]<-str_trim(dict_list[[4]])
        dict_list[[5]]<-vector()
        dict_list[[5]]<-input$dictionary5
        dict_list[[5]]<-strsplit(dict_list[[5]], ",")
        dict_list[[5]]<-unlist(dict_list[[5]])
        dict_list[[5]]<-str_trim(dict_list[[5]])
        dict_list[[6]]<-vector()
        dict_list[[6]]<-input$dictionary6
        dict_list[[6]]<-strsplit(dict_list[[6]], ",")
        dict_list[[6]]<-unlist(dict_list[[6]])
        dict_list[[6]]<-str_trim(dict_list[[6]])
        dict_list[[7]]<-vector()
        dict_list[[7]]<-input$dictionary7
        dict_list[[7]]<-strsplit(dict_list[[7]], ",")
        dict_list[[7]]<-unlist(dict_list[[7]])
        dict_list[[7]]<-str_trim(dict_list[[7]])
        dict_list[[8]]<-vector()
        dict_list[[8]]<-input$dictionary8
        dict_list[[8]]<-strsplit(dict_list[[8]], ",")
        dict_list[[8]]<-unlist(dict_list[[8]])
        dict_list[[8]]<-str_trim(dict_list[[8]])
        dict_list[[9]]<-vector()
        dict_list[[9]]<-input$dictionary9
        dict_list[[9]]<-strsplit(dict_list[[9]], ",")
        dict_list[[9]]<-unlist(dict_list[[9]])
        dict_list[[9]]<-str_trim(dict_list[[9]])
        dict_list[[10]]<-vector()
        dict_list[[10]]<-input$dictionary10
        dict_list[[10]]<-strsplit(dict_list[[10]], ",")
        dict_list[[10]]<-unlist(dict_list[[10]])
        dict_list[[10]]<-str_trim(dict_list[[10]])
        for (i in 1:10) {
          if(length(dict_list[[i]])==0){
            dict_list[[i]][1]<-"write something"
          }
        }
        if (dict_list[[1]][1]=="write something") {
          title(warning("WRITE AT LEAST ONE DICTIONARY!"))
        }
        else{
          for (i in length(dict_list):1) {
            if (dict_list[[i]][1]=="write something") {
              dict_list[[i]]<-NULL
            }
          }
          for (i in 1:length(dict_list)) {
            dict_list[[i]]<-append(dict_list[[i]],stemDocument(dict_list[[i]],language = "english"))# Select the language that apply
          }
          
          All_dict_words_to1term <- function(starting_doc,dict,sub_term){
            for (i in 1:length(dict)) {
              if (i==1){
                new_doc<-str_replace_all(starting_doc,dict[i],sub_term)
              }
              else{
                new_doc<-str_replace_all(new_doc,dict[i],sub_term)
              }
            }
            return(new_doc)
          }
          
          # Function to iterate the previous function over several dictionaries and create a list of the texts thus processed (the final element of the list is the one processed after all of the dictionaries)
          All_dict_words_to1term_fin <-  function(starting_doc,dictionaries){
            result<-list()
            for (i in 1:length(dictionaries)) {
              if (i==1) {
                result[[i]]<-All_dict_words_to1term(starting_doc,dictionaries[[i]],dictionaries[[i]][1])
              }
              else{
                result[[i]]<-All_dict_words_to1term(result[[i-1]],dictionaries[[i]],dictionaries[[i]][1])
              }
            }
            return(result)
          }
          
          processed_text_list<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-All_dict_words_to1term_fin(preproc_text_list[[i]], dict_list)
            processed_text_list[[i]]<-processed_text_list[[i]][[length(dict_list)]]}
          dict_new<-vector()
          for (i in 1:length(dict_list)) {
            dict_new[i] <- dict_list[[i]][1]
          }
          dict_new<-tolower(dict_new)
          print(dict_new)
          
          node_reference<- data.frame(dict_new, c(1:length(dict_new)))
          node_reference<-node_reference[,2]
          node_reference<-`names<-`(node_reference,dict_new)
          
          strsplit_space_tokenizer <- function(x)
            unlist(strsplit(as.character(x), "[[:space:]]+"))
          if(input$language=='english'){
          ctrl<- list(
            tokenize = strsplit_space_tokenizer,
            language="en", # Change the                                                           language if needed
            removePunctuation = TRUE,
            removeNumbers =TRUE,
            stopwords=TRUE)}
          if(input$language=='spanish'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="spanish", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='german'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="german", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          if(input$language=='italian'){
            ctrl<- list(
              tokenize = strsplit_space_tokenizer,
              language="italian", # Change the                                                           language if needed
              removePunctuation = TRUE,
              removeNumbers =TRUE,
              stopwords=TRUE)}
          termFreq2<-function(x){
            termFreq(x, 
                     control = ctrl)
          }
          
          # Creating texts' frequencies (i.e. absolute occurrences) vector for the concepts of interest
          Text_freq<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-iconv(processed_text_list[[i]], "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage
            Text_freq[[i]]<-termFreq2(processed_text_list[[i]])
            Text_freq[[i]]<-Text_freq[[i]][dict_new]
          }
          
          Text_freq_rel<-list()
          for (i in 1:num_texts) {
            processed_text_list[[i]]<-iconv(processed_text_list[[i]], "UTF-8",'latin1', sub = "") #change the parameters of conversion as needed, esepcially if errors are thrown at this stage  
            Text_freq_rel[[i]]<- Text_freq[[i]]/sum(termFreq2(processed_text_list[[i]]))*100
          }
          
          Nodes_df_list<-list()
          for (i in 1:num_texts) {
            Nodes_df_list[[i]]<- data.frame(dict_new,node_reference,Text_freq[[i]],Text_freq_rel[[i]])
            Nodes_df_list[[i]]<-`names<-`(Nodes_df_list[[i]], c('Label','ID','Absolute Occurence', 'Relative Occurrence'))
          }
          
          Occurrences<-vector()
          texts<-vector()
          dictionaries<-vector()
          
          texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file1[1]),1,nchar(as.character(input$file1[1]))-4)))
          texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file2[1]),1,nchar(as.character(input$file2[1]))-4)))
          if(length(input$file3))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file3[1]),1,nchar(as.character(input$file3[1]))-4)))
          if(length(input$file4))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file4[1]),1,nchar(as.character(input$file4[1]))-4)))
          if(length(input$file5))texts<-append(texts,replicate(length(dict_new),substr(as.character(input$file5[1]),1,nchar(as.character(input$file5[1]))-4)))
          
          
          
          for (i in 1:num_texts) {
            #texts<-append(texts,replicate(length(dict_new),paste('text',i)))
            dictionaries<-append(dictionaries,dict_new)
            Occurrences<- append(Occurrences,Nodes_df_list[[i]]$`Absolute Occurence`)
          }
          
          newer_df<-data.frame(as.factor(texts),
                               as.factor(dictionaries),Occurrences)
    DT::datatable(newer_df)}}}
  })}
    
        
        
        
shinyApp(ui=ui_prova,server=server_prova)
