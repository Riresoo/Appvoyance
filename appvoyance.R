library(shiny)


ui <- fluidPage(
  titlePanel("Voyance Divine"),
  tags$head(
    tags$style(
      HTML("
      body {
        font-family: 'Arial', sans-serif;
        background-color: #28004d;
        color: #ffffff;
      }
      .title {
        font-size: 30px;
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px;
        color: #ff00ff;
      }
      .intro {
        font-size: 18px;
        font-style: italic;
        text-align: center;
        margin-bottom: 20px;
      }
      .sidebar {
        background-color: #8a2be2;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px #888888;
      }
      .main {
        background-color: #9932cc;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0px 0px 10px #888888;
      }
      ")
    )
  ),
  sidebarLayout(
    sidebarPanel(
      class = "sidebar",
      numericInput("number", "Nombre mystique:", value = 0),
      selectInput("signe", "Votre signe astrologique:",
                  choices = c("Bélier", "Taureau", "Gémeaux", "Cancer", "Lion", "Vierge", "Balance", "Scorpion", "Sagittaire", "Capricorne", "Verseau", "Poissons")),
      actionButton("validate", "Découvrir votre destin")
    ),
    mainPanel(
      class = "main",
      tags$p(class = "intro", "Entrez dans le monde de la voyance pour découvrir ce que le futur vous réserve..."),
      textOutput("message")
    )
  )
)

server <- function(input, output) {
  
  validate_click <- eventReactive(input$validate, {
    list(number = input$number, signe = input$signe)
  })
  
  output$message <- renderText({
    req(validate_click())
    if (validate_click()$number == 11 && validate_click()$signe == "Lion") {
      return("Bravo, votre destin est béni! Les étoiles sont alignées en votre faveur.")
    } else {
      return("Attention! Les astres semblent contrariés... Préparez-vous à des défis à surmonter.")
    }
  })
}

# Exécution de l'application
shinyApp(ui = ui, server = server)

