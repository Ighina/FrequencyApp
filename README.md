# FrequencyApp
Shiny app to discover and visualise the occurrences of words and/or word-sets (i.e. dictionaries) in given txt files (up to 5)

<h2 style="color:blu;">What's in the Repository</h2>

The repository consists in a folder ('FrequencyApp'), which can be downloaded to run the relative shiny web application on locale, and a app.R file that is the same file contained in the SemanticApp folder but allows to run the app directly from GitHub.

1. To run the web app on your computer: download the SemanticApp folder and then use the following codes --> From R/RStudio: shiny::runApp('/FrequencyApp/app.R') From Windows Command Prompt: "the location of R on your computer\R.exe" -e "shiny::runApp('the FrequencyApp location on your computer/FrequencyApp/app.R')"
*NB: the Command Prompt will give a message saying "Listening on:" followed by an https address, copy the https address on your browser to open the web app.

2. To run the web app directly from GitHub use the following codes--> From R/Rstudio: shiny::runGitHub('Ighina/FrequencyApp','Ighina') From Windows Command Prompt: "the location of R on your computer\R.exe" -e "shiny::runGitHub('Ighina/FrequencyApp','Ighina') 
*NB: the Command Prompt will give a message saying "Listening on:" followed by an https address, copy the https address on your browser to open the web app.

The repository includes also a "Text&dictionary example" folder containing examples of how the app can be used.

*NB at the moment, for a better performance, is preferable to include every word in the dictionary twice, one with first letter capitalised and one without.

h2(What the App Does)

The app takes up to five texts (in .txt format) and look into them to find the occurrences of user-defined words or set of words (i.e. dictionaries). The set of words or dictionaries are included as an option in order to tackle the scenarios in which more than one word in a text points to a given concept of interest (e.g. synonims like aim/purpose). To deal with this problem, the app applies the same logic and, in part, the same codes used in my other repository 'SemanticNetworkVizR' and that can be explored further by looking, cloning or downloading the R Notebook in it by the name 'NotebookR SemanticNetwork.Rmd'.

There are two frequency options: absolute and relative. The first one report the number of times the words appear in the different texts, while the second report the same number over the total number of words appearing in the text (not counting, if the right language is chosen, the stopwords). The last option, the relative frequency, allows then to visualise what percentage of the text(s) are the given words.

There are two general options available from the navigation bar on top of the page: plot and data. The first option is the standard one and consists in the file input spots and in a barplot visualisation of the frequencies obtained from the inputs. The second option presents such frequencies in a numerical way through a table/dataframe.

