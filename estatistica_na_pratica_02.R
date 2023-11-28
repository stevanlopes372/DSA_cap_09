setwd("C:/Users/neo2g/OneDrive/Documentos/DataScience Academy/Big Data R Azure/Cap 09/DSA_cap_09")
getwd()


# “Existe diferença significativa na média de sono dos 2 grupos de pacientes, ou seja, 
# há diferença significativa entre os dois medicamentos que ajudam no distúrbio do sono?”

if(!require(car)) install.packages("car")
library(car)

if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

View(sleep)

