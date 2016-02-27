shinyUI(fluidPage(

    # Title
    titlePanel("Central Limit Theorem Demonstration"),

    # Layout
    sidebarLayout(
        sidebarPanel(
            h2("Parameters"),
            sliderInput(
                       , inputId = "sampleSlider",
                       , label   = "Number of samples per iteration",
                       , min     = 1,
                       , max     = 1000,
                       , value   = 40,
                       , step    = 10
                       ),
            sliderInput(
                       , inputId = "simSlider",
                       , label   = "Number of iterations",
                       , min     = 1,
                       , max     = 2000,
                       , value   = 1000,
                       , step    = 10
                       ),
            sliderInput(
                       , inputId = "lambdaSlider",
                       , label   = "Lambda",
                       , min     = 0.1,
                       , max     = 10,
                       , value   = 0.2,
                       , step    = 0.1
                       )
        ),
        mainPanel(
            h2("Simulation"),
            
            p( "You use this simulation to see"
             , a("Central Limit Theorem"
                , href = "https://en.wikipedia.org/wiki/Central_limit_theorem"
                )
             , "in action. There are two datasets generated:"
             ),      
            
            htmlOutput("simInfo"),
            br(),
            
            p( "Use the parameters on the left panel to adjust the number of"
             , "iterations, number of samples and lambda."
             ),

            p( "By looking at the plots below, you can see that as the number"
             , "of iterations increase,"
             , strong("sim")
             , "data becomes more normal (topleft plot) even though the underlying distribution"
             , "is exponential (topright)"
             , "You can also look at the normal Q-Q plot and sim/ref Q-Q plot"
             , "to visually confirm the normality (or lack thereof) of"
             , strong("sim")
             , "dataset."
             ),

            plotOutput("plot1", height = "600px")
        )
    )

))
