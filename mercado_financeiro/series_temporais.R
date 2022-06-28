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

# Mostra os primeiros registros para as ações da Petrobras
head(PETR4.SA)
View(PETR4.SA)

# Analisando os dados de fechamento 
PETR4.SA.Close <- PETR4.SA[, "PETR4.SA.Close"]
is.xts(PETR4.SA.Close)
head(Cl(PETR4.SA), 5)

# Agora, vamos plotar o gráfico da Petrobras
# Gráfico de candlestick da Petrobras
candleChart(PETR4.SA)