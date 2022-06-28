setwd("~/projetos_DS_R/mercado_financeiro")
getwd()

# Instalar e carregar os pacotes
install.packages("quantmod")
install.packages("xts")
install.packages("moments")
library(quantmod)
library(xts)
library(moments)

# Seleção do período de análise
startDate = as.Date("2018-01-21")
endDate = as.Date("2018-06-21")

# Download dos dados do período
# Obs: O Yahoo Finance está passando por mudanças 
# e o serviço de cotações online pode estar instável
getSymbols("PETR4.SA", src = "yahoo", from = startDate, to = endDate, auto.assign = T)

# Checando o tipo de dado retornado
class(PETR4.SA)
is.xts(PETR4.SA)