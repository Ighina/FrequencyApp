# FrequencyApp
Shiny app to discover and visualise the occurrences of words and/or word-sets (i.e. dictionaries) in given txt files (up to 5)

## Index

- [What's in the Repository](#first)
- [What the App Does](#second)
- [Using the App directly from the Browser](#third)

<a name="first"><h2>What's in the Repository</h2></a>

The repository consists in a folder ('FrequencyApp'), which can be downloaded to run the relative shiny web application on locale, and a app.R file that is the same file contained in the SemanticApp folder but allows to run the app directly from GitHub.

1. To run the web app on your computer: download the SemanticApp folder and then use the following codes --> From R/RStudio: shiny::runApp('/FrequencyApp/app.R') From Windows Command Prompt: "the location of R on your computer\R.exe" -e "shiny::runApp('the FrequencyApp location on your computer/FrequencyApp/app.R')"
*NB: the Command Prompt will give a message saying "Listening on:" followed by an https address, copy the https address on your browser to open the web app.

2. To run the web app directly from GitHub use the following codes--> From R/Rstudio: shiny::runGitHub('Ighina/FrequencyApp','Ighina') From Windows Command Prompt: "the location of R on your computer\R.exe" -e "shiny::runGitHub('Ighina/FrequencyApp','Ighina') 
*NB: the Command Prompt will give a message saying "Listening on:" followed by an https address, copy the https address on your browser to open the web app.

A "Text&dictionary example" folder containing texts and dictionaries for example purposes can be accessed by clicking [here](https://github.com/Ighina/SemanticNetworkVizR/tree/master/Text%26dictionaries%20example).

*NB at the moment, for a better performance, is preferable to include every word in the dictionary twice, one with first letter capitalised and one without.

<a name="second"><h2>What the App Does</h2></a>

The app takes up to five texts (in .txt format) and look into them to find the occurrences of user-defined words or set of words (i.e. dictionaries). The set of words or dictionaries are included as an option in order to tackle the scenarios in which more than one word in a text points to a given concept of interest (e.g. synonims like aim/purpose). To deal with this problem, the app applies the same logic and, in part, the same codes used in my other repository 'SemanticNetworkVizR' and that can be explored further by looking, cloning or downloading the R Notebook in it by the name 'NotebookR SemanticNetwork.Rmd'.

There are two frequency options: absolute and relative. The first one report the number of times the words appear in the different texts, while the second report the same number over the total number of words appearing in the text (not counting, if the right language is chosen, the stopwords). The last option, the relative frequency, allows then to visualise what percentage of the text(s) are the given words.

There are two general options available from the navigation bar on top of the page: plot and data. The first option is the standard one and consists in the file input spots and in a barplot visualisation of the frequencies obtained from the inputs. The second option presents such frequencies in a numerical way through a table/dataframe.

<a name=#third><h2>Using the App directly from the Browser</h2></a>

The app can be used directly online by using the online version of RStudio. In order to do so, then, go to [RStudio's cloud](https://rstudio.cloud/) and, if you don't have an account, create one. Once signed in, create a new project. Once inside the project you will see the RStudio console: install shiny with the following code **install.packages('shiny')**
Once shiny has been installed run the following code: **shiny::runGitHub('Ighina/FrequencyApp','Ighina')**
After having installed all the required packages, the app should appear on a new tab of your browser.

