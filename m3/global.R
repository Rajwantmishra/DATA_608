
# library(rmdformats)
library(tidyverse)
library(ggplot2)

library(DT)
library(stringr)
library(lubridate)
# library(corrr)
# library(psych)
library(readxl)
library(readr)
library(plotly)
# library(lme4)
# library(lmerTest)
library(leaflet)
# library(mongolite)
# library(gridExtra)

# install.packages("RInno")

# allzips <- readRDS("data/superzip.rds")
# allzips$latitude <- jitter(allzips$latitude)
# allzips$longitude <- jitter(allzips$longitude)
# allzips$college <- allzips$college * 100
# allzips$zipcode <- formatC(allzips$zipcode, width=5, format="d", flag="0")
# row.names(allzips) <- allzips$zipcode
# 
# cleantable <- allzips %>%
#   select(
#     City = city.x,
#     State = state.x,
#     Zipcode = zipcode,
#     Rank = rank,
#     Score = centile,
#     Superzip = superzip,
#     Population = adultpop,
#     College = college,
#     Income = income,
#     Lat = latitude,
#     Long = longitude
#   )

#---------------------------


#  options(shiny.port = 3497)
# options(shiny.host = "10.100.3.5")
#  shiny::runApp()

#---------------------------------

print("LOADING GLOBAL")
# 
# DT_SALES_FREE18_Cust_Order <- DT_SALES_FREE18 %>% group_by(Year,Quarter,SalesOrganization,KUNNR_NEW,Brand,Sales_Type) %>% summarise(Sum_Ordered_Units = sum(Ordered_Units))
# 
# #By BRAND
# mkt_Data_cust_brand<- mkt_Data_New %>% group_by(Year,Quarter,KUNNR_NEW,Brand) %>% summarise(Sum_Promo_Unit = sum(`Order Quantity`))
# 
# DT_SALES_FREE18_Cust_Order <- DT_SALES_FREE18 %>% group_by(Year,Quarter,SalesOrganization,KUNNR_NEW,Brand,Sales_Type) %>% summarise(Sum_Ordered_Units = sum(Ordered_Units))
# DT_SALES_CUST18_BY_BRAND <- DT_SALES_FREE18_Cust_Order[,c(1,2,4,5,6,7)] %>% spread(Sales_Type,Sum_Ordered_Units)
# mkt_Data_cust_brand <- left_join(mkt_Data_cust_brand,DT_SALES_CUST18_BY_BRAND, by =c (
#   "Year" ="Year","KUNNR_NEW" = "KUNNR_NEW" , "Brand" = "Brand", "Quarter"  = "Quarter"))
# summary(mkt_Data_cust_brand)
# 
# mkt_Data_Year_QT_brand_long <- mkt_Data_cust_brand %>% gather(key, value, -Year,-Quarter,-Brand,-KUNNR_NEW)
# mkt_Data_Year_QT_brand_long_group <- mkt_Data_Year_QT_brand_long %>% group_by(Year,Quarter,Brand,key) %>% summarise(value = sum(value,na.rm = TRUE))
# 
# 


## ---------------------ST.rmd ----------------------
## R Markdown
# Read ALL the data
workDir <- getwd()
filePath = paste0(workDir,"/data")
g_max <- 1048576 
cdc_data <- read_csv(paste0(filePath,"/cdcm.csv"),guess_max =g_max) #%>% .[,-c(1,2,3,4,5,6,7,8,14,16,30,31,32)]
cdc_data_wide <- cdc_data %>% pivot_wider(names_from = State, values_from = Deaths) 
cdc_data_long = cdc_data_wide %>% pivot_longer(cols = c(5:55),names_to="State", values_drop_na = TRUE)
slat <- read_csv(paste0(filePath,"/slatlot.csv"),guess_max =g_max) 

#national Population
National_pop <- cdc_data_long %>%  plyr::ddply(.,'Year',summarise,P_Total = sum(Population))

# mean RATE by CDC Chapter
# nat_Rat<- cdc_data_long %>% merge(. ,National_pop, by = "Year")  %>%  
#   plyr::ddply(.,c('ICD.Chapter','Year'),summarise,P_Count = sum(Population),
#               Mean_Rate =mean(Crude.Rate),P_Value= sum(value),
#               P_Total= mean(P_Total),N_Rate=P_Value/P_Total*10000)%>%  .[,c(1,2,7)]
nat_Rat<- cdc_data_long %>% merge(. ,National_pop, by = "Year")  %>%  plyr::ddply(.,c('ICD.Chapter','Year'),summarise,
                                                                                  P_Count = sum(Population),
                                                                                  Mean_Rate =mean(Crude.Rate),
                                                                                  P_Value= sum(value),
                                                                                  P_Total= mean(P_Total),
                                                                                  N_Rate=(P_Value/P_Total)*10000,
                                                                                  N_Avg= (P_Value/n())/100, 
                                                                                  N_RAT = (P_Value/P_Count)) %>%  .[,c(1,2,7,8,9)]

#Connect winth Mongo
# fs_MKT_SHARE <- gridfs(db = "MKT_SHARE", url = "mongodb+srv://msds_user:msds@cluster0-bqyhe.gcp.mongodb.net/", prefix = "LUX",options = ssl_options())
# create connection, database and collection
# Mongo_mkt_data = mongo(collection = "mkt_data", db = "MKT_SHARE", url = "mongodb+srv://msds_user:msds@cluster0-bqyhe.gcp.mongodb.net/") 



# Read ALL the data 
# mkt_Data_New <- read_csv(paste0(workDir,"/data/mkt_Data.csv"),guess_max =g_max) %>% .[,-c(1,2,3,4,5,6,7,8,14,16,30,31,32)]
# saveRDS(mkt_Data_New,paste0(workDir,"/data/r_mkt_Data_New.rds"))
# mkt_Data_New <- readRDS(paste0(workDir,"/data/r_mkt_Data_New.rds"))


# DT_SALES_FREE18 <- read_csv(paste0(workDir,"/data/DT_SALES_FREE18.csv"),guess_max =g_max) 
# saveRDS(DT_SALES_FREE18,paste0(workDir,"/data/r_DT_SALES_FREE18.rds"))
# DT_SALES_FREE18 <- readRDS(paste0(workDir,"/data/r_DT_SALES_FREE18.rds"))
# write_csv(DT_SALES_FREE18,"Data/DT_SALES_FREE18.csv")
# write_csv(mkt_Data_New_temp,"Data/mkt_Data.csv")

# Ui_Brandlist <- unique(mkt_Data_New$Brand) # used for dropdown
# Ui_City <- unique(mkt_Data_New$city)

Ui_Type <- unique(cdc_data$ICD.Chapter)
Ui_State <- unique(cdc_data$State)
Ui_Year <- unique(cdc_data$Year)
# Ui_Type <-  unique(mkt_Data_New$TYPE.x)
# Ui_Qt <- unique(mkt_Data_New$Quarter)
