#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram


shinyUI(fluidPage(
  title = "Data 608 : Module 3",
  
  sidebarLayout(
   
    sidebarPanel(
      
      
      passwordInput("in_gl_pass", "Password", value = "LUx123@", width = NULL,
                    placeholder = NULL),
      
      selectInput("in_gl_year", label = "Year:",
                  choices = c(paste(Ui_Year,sep=",")), 
                  selected = Ui_Year[1]),
      selectInput("in_gl_ICD", label = "ICD Category:",
                  choices = c(paste(Ui_Type,sep=",")), 
                  selected = Ui_Type[1]),
      conditionalPanel('input.dataset === "Question 1"',
"Question 1: As a researcher, you frequently compare mortality rates from particular causes across
different States. You need a visualization that will let you see (for 2010 only) the crude
mortality rate, across all States, from one cause (for example, Neoplasms, which are
effectively cancers). Create a visualization that allows you to rank States by crude mortality
for each cause of death." ),
      
      conditionalPanel('input.dataset === "Question 2"',
                       "Question 2: Often you are asked whether particular States are improving their mortality rates (per cause)
faster than, or slower than, the national average. Create a visualization that lets your clients
                       see this for themselves for one cause of death at the time. Keep in mind that the national
                       average should be weighted by the national population.",
        selectInput("in_StateMap", label = "Choose State: (Only for Customer Data)",
                    choices = c(paste(Ui_State,sep=",")), 
                    selected = Ui_State[1]))
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("Question 1",
                 fluidRow(h3('States by crude mortality for each cause of death.:')),
                 fluidRow(plotOutput("distPlottemp"))
        ),
        tabPanel("Question 2", 
                 h3('Explore the state for the cause:'),
                 fluidRow(htmlOutput("distPlotStateText"),
                   plotOutput("distPlotState"),
                   "Size of the cirle shows how crude rate was behaving over the year for the state. \n Closer it's to the bottom line, close it's to the national Avg rate.",
                   "Red trend line shows how it is moving as the year go forward.",
                          plotOutput("StatebyYear"),
                   "Crude Rate over the year in the state, size of cirle shows how close its to the National Avg Rate, small circle mean is close to Nat. Avg Rate., please note that Crude Rate/N_Rate gives the size so value on Y axis is key in noting how close state is.",
                          plotOutput('mktbyBC2'))
        )
      )
    )
  )
))
