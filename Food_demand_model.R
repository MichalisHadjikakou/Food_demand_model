#############################################################
## FOOD DEMAND ESTIMATES FOR AUSTRALIA ##
#############################################################

# Author: Michalis Hadjikakou, Deakin University (m.hadjikakou@deakin.edu.au)
# Last updated: 02 February 2021
# Purpose: Alternative projections for SSP food demand 

## 1.0 Setting working directory and loading data
#setwd("M:/LUF-Modelling/Food_demand_trade/Food_demand_model/CalorieDemand/R/")
setwd("N:/LES/Burwood/Planet-A/LUF-Modelling/Food_demand_trade/Food_demand_model/CalorieDemand/R/")

library(miceadds)
library(tidyverse)

# Loading all functions
source.all("N:/LES/Burwood/Planet-A/LUF-Modelling/Food_demand_trade/Food_demand_model/CalorieDemand/R/")

# Loading data
load("N:/LES/Burwood/Planet-A/LUF-Modelling/Food_demand_trade/Food_demand_model/CalorieDemand/data/demand_input.RDA")
load("N:/LES/Burwood/Planet-A/LUF-Modelling/Food_demand_trade/Food_demand_model/CalorieDemand/data/iso_reg.RDA")

# Running scenario
scenario_ssp2 <- demand_calculation(
  scenario_name = "ssp2",
  dat_scen=demand_input,
  pop_scen="pop_mio_ssp2",
  gdp_scen="gdp_mioUSD05MER_ssp2", 
  dem_regr_type=func_gA,
  ls_regr_type=func_hA
)  

# Accessing Australian results - #7 country

ls_share <- scenario_ssp2$country[7,1:69,2] # country/year/variable
Total_kcal <- scenario_ssp2$country[7,1:69,6] # To access calories per capita for Australia

# Exporting Australian results
Aus_results_ssp2 <- rbind(Total_kcal,ls_share) %>% t() %>% data.frame() %>% add_column(Year=row.names(.),.before = 1) %>%
  mutate(Animal_kcal=Total_kcal*ls_share)

write.csv(Aus_results_ssp2,"AUS_results_ssp2.csv")
