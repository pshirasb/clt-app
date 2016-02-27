library(ggplot2)

# Simulation
runSim = function(nsample = 40, nsim = 1000, lambda = 0.2) {
    ref = rexp(nsim, lambda)
    sim = data.frame( mean  = numeric()
                    , stringsAsFactors = F
                    )

    for(i in 1:nsim) {
        isample = rexp(nsample, lambda)
        sim = rbind(sim, data.frame( mean = mean(isample)
                                   , var  = var(isample)
                                   ))
    }
    return(list( sim = sim
               , ref = ref
               , nsample = nsample
               , nsim    = nsim
               , lambda  = lambda))
}

# Plots
drawPlots = function(simObject) {
    with(simObject, {
        par(mfrow=c(2,2))
        hist( sim$mean, col = "grey", freq=F, breaks = 40
            , main = "Distribution of sim"
            , xlab = "Mean"
            )
        curve(dexp(x,lambda), add = T, col = "blue")
        curve(dnorm(x, mean(sim$mean), sd(sim$mean)), add = T, col = "red")
        hist(ref, breaks = 40, col = "grey"
            , main = "Distribution of ref"
            , freq = F
            )
        curve(dexp(x,lambda), add = T, col = "blue")
        curve(dnorm(x, mean(ref), sd(ref)), add = T, col = "red")
        legend ( "topright"
               , fill   = c("red", "blue")
               , legend = c("normal","exp")
               )
        qqnorm(sim$mean)
        qqline(sim$mean, col = "red")
        qqplot( x    = ref
              , y    = sim$mean
              , main = "Sim vs Ref Q-Q Plot"
              , xlab = "Ref Quantiles"
              , ylab = "Sim Quantiles"
              )  
        qqline( y    = sim$mean
              , col  = "red"
              , distribution = function(p) qexp(p, 0.2)
              )

    })
}

# Server
shinyServer(function(input, output) {
    output$plot1  = renderPlot({
        simObj = runSim( nsample = input$sampleSlider
                       , nsim    = input$simSlider
                       , lambda  = input$lambdaSlider
                       )
        drawPlots(simObj)
    })
    output$simInfo = renderText({
        paste( ""  
             , (strong("1. sim:"))
             , "means of "
             , input$simSlider
             , "iterations of "
             , input$sampleSlider
             , "random samples drawn from an"
             , "exponential distribution with lambda = "
             , input$lambdaSlider
             , br()
             , (strong("2. ref:"))
             , input$sampleSlider
             , "random samples drawn from an exponential distribution"
             , "with lambda = "
             , input$lambdaSlider
             )
    })
})

