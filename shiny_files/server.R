
library(shiny)
library(ggplot2)
library(gridExtra)

s <- shinyServer(function(input, output) 
{
    set.seed(123)
    plot1 <- reactive({
        nsamples <- 500
        mns0 <- rexp(nsamples, rate = input$lambda) 
        ggplot(data = data.frame(mns0), aes(x = mns0)) +
            geom_histogram(fill = "blue",
                           colour = "black",
                           alpha = 0.2,
                           binwidth = 1)+
            labs(title = "Fig1: Draws from exponential distribution",
                 x= "x", y = "Frequency")
    })
    plot2 <- reactive({
        n <- input$wt1
        avg_theory <- 1/input$lambda
        mns <- NULL
        for (i in 1 : input$wt2) {
            mns <- c(mns, mean(rexp(n, rate = input$lambda))) 
        }
        avg_sim <- mean(mns)
        
        sd_theory <- (1/input$lambda)
        var_theory <- sd_theory^2/n
        var_sim <- var(mns)
        sd_sim <- sd(mns)
        
        ggplot(data = data.frame(mns), aes(x = mns)) +
            geom_histogram(aes(y = ..density..), 
                           binwidth = 0.2,
                           fill = "blue",
                           colour = "black",
                           alpha = 0.2) +
            #geom_density(colour ="red") +
            geom_rug(colour = "green") +
            geom_vline(xintercept = avg_sim, colour = "red") +
            geom_vline(xintercept = avg_theory, colour = "blue") +
            labs(title = "Fig2: Histogram of sample mean",
                 x= "Mean", y = "Density") +
            stat_function(fun=dnorm,
                          color="blue",
                          args=list(mean = avg_theory, 
                                    sd = sqrt(var_theory)))
    })

    output$plotgraph <- renderPlot({
        plot_list <- list(plot1(),plot2())
        wtlist <- c(input$wt1,input$wt2)
        grid.arrange(grobs=plot_list, 
                     nrow=length(plot_list), ncol=1)
    })
    
    output$ex1 <- renderUI({
        withMathJax(helpText('Exponential distribution:
                             $$P(x) = \\lambda \\exp(-\\lambda x)$$'))
    })
    
    
})