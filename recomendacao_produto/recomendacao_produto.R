setwd("C:/Users/thayanne/Documents/projetos_DS_R/recomendacao_produto")
getwd()

# Carrega os pacotes
library(dplyr)
library(arules)
library(arulesViz)
library(htmlwidgets)
library(writexl)
options(warn=-1)

#Carregando dados
dados <- read.csv("dataset_bd3.csv")
dim(dados)
View(dados)
summary(dados)