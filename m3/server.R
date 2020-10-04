#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  gl_pass  <- reactiveVal("")
  pass<- reactiveVal(FALSE) 
  
  observe({
    gl_pass(input$in_gl_pass)
    if(identical(gl_pass,"LUx123@")){
      pass(TRUE)
    }else{
      pass(FALSE)
    }
    
    
    
  })
  
  output$authorized_content <- renderUI({ })
  #--------- For Plot
  output$distPlot <- renderPlotly({
    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
    #-------------- Pass Check End 
    
    
    
    input_year <-input$in_gl_year
    input_brandType <-input$in_gl_ICD
    input_IDC <- input$in_gl_ICD
 
    
    fb <- cdc_data_long %>% filter(.,Year== c(paste(input_year)) & ICD.Chapter == c(paste(input_IDC))) %>% .[,c(1,5,4)] %>%
      ggplot(mapping = aes(  x= Crude.Rate, y= State)) + geom_col(position = "dodge")  + 
      ggtitle(" TEST PLOT") 
    ggplotly(fb)
    
  })
  
  
  output$distPlottemp <- renderPlot({
    
    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
    #-------------- Pass Check End 
    
    input_year <-input$in_gl_year
    input_brandType <-input$in_gl_ICD
    input_IDC <- input$in_gl_ICD
    
    gp<- cdc_data_long %>% filter(.,Year== input$in_gl_year & ICD.Chapter ==input$in_gl_ICD) %>% .[,c(1,5,4)] %>% arrange(desc(.$Crude.Rate))  %>%
      ggplot(mapping = aes(  y= Crude.Rate, x= reorder(State,desc(Crude.Rate)),label= State)) + geom_col(position = "dodge")  +  
      theme(axis.text.x = element_text(angle=90)) +
       theme_minimal()+
      labs(title="Crude.Rate across States in 2010", 
           subtitle = paste0(input$in_gl_ICD), 
           y="Crude Rate of state", 
           x="States",
           caption="Source: CUNY Data 608")
    
    gp
    
    
  })

  output$distPlotStateText <- renderUI({
    paste("National Avg is calculated per 100 of the (impacted population/Total Population). 
National Rate is calculated per 10000 of the (Impacted Population/Total Population ).
National Average was very low in most of the case due the lower ration of impacted population with total population.
")
  })

  output$distPlotState <- renderPlot({    
    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
    #-------------- Pass Check End 
    
    input_year <-input$in_gl_year
    input_IDC <- input$in_gl_ICD
    input_state <- input$in_StateMap



    point_na<- nat_Rat$N_Rate[which(nat_Rat$ICD.Chapter==input$in_gl_ICD & nat_Rat$Year== input$in_gl_year )]
    point_N_Avg <- nat_Rat$N_Avg[which(nat_Rat$ICD.Chapter==input$in_gl_ICD & nat_Rat$Year== input$in_gl_year )]
    print("TEST >.............")
    print(point_na)
    
    gp<- cdc_data_long %>% filter(.,Year== input$in_gl_year & ICD.Chapter ==input$in_gl_ICD) %>% .[,c(1,5,4)] %>% mutate(.,code=ifelse(State==input_state,"withcolor",NA))  %>%
      ggplot(mapping = aes(  y= Crude.Rate, x= reorder(State,desc(Crude.Rate)),label= State,fill=code)) + geom_col(position = "dodge",show.legend = F)  +  
      geom_hline(yintercept=point_na, linetype="dashed", color = "red",size=2) +
      geom_hline(yintercept=point_N_Avg, linetype="dashed", color = "green",size=1) +
      geom_label(aes(x = 25, y = point_na, label = "National Rate"),nudge_y=0.2,color='white',show.legend = F) +
      geom_label(aes(x = 25, y = point_N_Avg, label = "National Avg"),nudge_y=0.2,color='white',show.legend = F) +
      theme(axis.text.x = element_text(angle=90)) +
      theme_minimal()+ 
      labs(title=paste0("Crude.Rate for ",input_state, " in ", input_year), 
           subtitle = paste0(input$in_gl_ICD), 
           y="Crude Rate of state", 
           x="States",
           caption=paste("Source: CUNY Data 608","Nat. Rate=(Impacted/Total Nat. Population )*10000","Nat. Avg= Impacted/num of state /100",sep="\n"))
    
    gp


  

    
    
  })

  # Plot for Year and Rate comapte 
 output$StatebyYear <- renderPlot({
    
    input_year <-input$in_gl_year
    input_IDC <- input$in_gl_ICD
    input_state <- input$in_StateMap

    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
    #-------------- Pass Check End 
    
    # Some data 
  d_nap_n<- nat_Rat %>% filter(.,`ICD.Chapter`==input_IDC)
  d_nap_sf <- cdc_data_long %>% filter(.,State==input_state & ICD.Chapter ==input_IDC) %>% .[,c(1,2,5,4)] %>% left_join(.,d_nap_n,by="Year") 
  d_nap_sf$rate <- d_nap_sf$Crude.Rate/d_nap_sf$N_Rate
  
  d_nap_sf <-  d_nap_sf[order(d_nap_sf$Year),]
  d_nap_sf$N_Rate <- round(d_nap_sf$N_Rate,4) 
  d_nap_sf$N_Rate <- factor(d_nap_sf$N_Rate, levels = unique(d_nap_sf$N_Rate))
  
   gpp<-  d_nap_sf %>% ggplot(mapping = aes(y=rate,x=N_Rate,label=Year)) +
  geom_point(aes(col=Year, size=Crude.Rate),show.legend = F )  + 
    geom_text(color="blue", size=3,aes( y = rate + 0.2),
      position = position_dodge(2),
      vjust = 2) +
    geom_abline(intercept = min(d_nap_sf$rate),color ="red") +
    labs(title=paste0("Progress over years for ",input_state), 
        subtitle = paste0(input_IDC," from 1999 - 2010"),
        y="Crude Rate of state/ National Avg Rate", 
        x="National Rate",
        caption=paste("Source: CUNY Data 608","Nat. Rate=(Impacted/Total Nat. Population )*10000",sep="\n"))+
    theme(axis.text.x = element_text(angle=70),
          legend.position="bottom") + theme_minimal()
        gpp
   })

  # End of Year and Rate plot 
  # promo Data
  output$mktbyBC2 <- renderPlot({
    
    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
    #-------------- Pass Check End 
    input_year <-input$in_gl_year
    input_IDC <- input$in_gl_ICD
    input_state <- input$in_StateMap

    d_nap_n<- nat_Rat %>% filter(.,`ICD.Chapter`==input_IDC)
  d_nap_sf <- cdc_data_long %>% filter(.,State==input_state & ICD.Chapter ==input_IDC) %>% .[,c(1,2,5,4)] %>% left_join(.,d_nap_n,by="Year") 
  

    
      #    d_nap_sf <- cdc_data_long %>% filter(.,State==input_state & ICD.Chapter ==input_IDC) %>% .[,c(1,2,5,4)] %>% left_join(.,d_nap_n,by="Year") 
      #   d_nap_sf$Year <- as.factor(d_nap_sf$Year)

       gppp <-   d_nap_sf %>%   ggplot(aes(x=Year,y=Crude.Rate) ) +
       geom_point(aes(size=(Crude.Rate/N_Rate),color=(Crude.Rate)),alpha = 0.5) +
       theme(legend.position = "bottom")
          gppp
  })
  
  
  # Cust order by QT
  output$mktbyBC <- renderPlotly({
    #-------------- Pass Check 
    if(!identical(input$in_gl_pass,"LUx123@"))  # Check pass
      return() 
   
    mktbyBCPLOT <- mkt_Data_New %>% group_by(Year,Quarter) %>% summarise(order_unit = sum(`Order Quantity`)) %>%
      ggplot(mapping = aes(x= Quarter,y=order_unit,fill=as.factor(Year))) + geom_col(position = "dodge2") +
      ggtitle("Promo Order Quantity Over Each Quarter") +ylab("Ordered Unit") + xlab("Quarter") + scale_fill_discrete(name = "Year")
    
    
    ggplotly(mktbyBCPLOT)
    # ggplot(mkt_Data_New,mapping = aes(x=KUNNR_NEW ,y= `Order Quantity`, color=Quarter)) + geom_point() +ggtitle("Customer Order By Quarter")
    
    
  })
  
})
