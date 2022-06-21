# Segmentação de Clientes com Base em Análise RFM (Recência, Frequência e Valor Monetário)


# Imports
library(tidyverse)
library(dplyr)
library(ggplot2)
library(caret)
library(plotly)
library(readxl)
library(rfm)
library(stats)
library(factoextra)

# Função para carregar os dados da planilha Excel
carrega_dados <- function()
{
  setwd("~/projetos_DS_R/Segmentacao_de_Clientes")
  sheet1 <- read_excel('online_retail_II.xlsx', sheet = 'Year 2009-2010')
  sheet2 <- read_excel('online_retail_II.xlsx', sheet = 'Year 2010-2011')
  dados_combinados <- rbind(sheet1, sheet2)
  return(dados_combinados)
}

# Executa a função
dados <- carrega_dados()
dim(dados)
View(dados)

# Função para checar valores ausentes
verifica_missing <- function(x)
{
  return(colSums(is.na(x)))
}

# Executa a função
verifica_missing(dados)