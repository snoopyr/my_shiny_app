library(shiny)


shinyUI(fluidPage(
    titlePanel("Exponential distribution"),
    withMathJax(),
    sidebarLayout(position = "left",
                  sidebarPanel(
                               sliderInput("lambda","Fig1: Lambda",
                                           min=0.1,
                                           max=1.0,
                                           step=0.1,
                                           value=0.2),
                               sliderInput("wt1","Fig2: Number of draws per trial",
                                           min=10,
                                           max=100,
                                           step=10,
                                           value=40),
                               selectInput("wt2", "Fig2: Number of trials",
                                           choices = list("100" = 100,
                                                          "200" = 200,
                                                          "500" = 500,
                                                          "1000" = 1000,
                                                          "2000" = 2000), 
                                           selected = 100)
                               ),
                  mainPanel(
                            tabsetPanel("Plots",
                                        column(6,plotOutput(outputId="plotgraph", 
                                                          width="500px",
                                                          height="400px"),
                                               uiOutput('ex1'),
                                               h6("Fig1: Displays the histogram of sample
                                                  of draws from from an exponential 
                                                  distribution.  The rate is set by the
                                                  variable lambda on the sidepanel."),
                                               h6("Fig2: Displays the histogram of means of
                                                  the sample of draws from from an exponential 
                                                  distribution.  The number of draws per 
                                                  trial is set by the slider in the sidepanel.
                                                  The vertical blue line is the theoretical value,
                                                  and the red line is from the simulation. The 
                                                  continuous blue line is the theoretical normal
                                                  distribution.  It can be observed as the number
                                                  of trials increases, it approaches the theoretical
                                                  curve (which is the Central Limit Theorem in
                                                  practice).")
                                               ))  
                            
                            )
                  ))
    )