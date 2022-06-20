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

# Separamos as linhas pares das linhas ímpares
# Linhas impares não tem dados
linhas_pares <- seq(2, nrow(dados), 2)
df1 <- dados[linhas_pares, ]

# Verifica se temos valores ausentes no primeiro item de compra
sum(is.na(df1$Item01))

# Verifica se temos valores ausentes no segundo item de compra
sum(is.na(df1$Item02))

# Verifica se temos valores ausentes representados por espaço em branco
which(nchar(trimws(df1$Item01)) == 0)
which(nchar(trimws(df1$Item02)) == 0)

# Verifica se temos valores ausentes representados por espaço em branco (usando expressão regular)
grepl("^\\s*$", df1$Item02)

# Número de itens distintos
n_distinct(df1)

# Vamos trabalhar somente com os registros onde o item 2 não for nulo
# Se vamos recomendar produtos de clientes que compraram o mesmo produto
# É necessário o segundo produto
df1_2 <- df1[!grepl("^\\s*$", df1$Item02), ]

# Número de itens distintos após limpeza
n_distinct(df1_2)

# Prepara o pacote convertendo as variáveis para o tipo fator 
#Apenas das 6 primeiras colunas, pois não é uma boa pratica usar todas as colunas
#Poucos clientes compram mais de 6 produtos
pacote <- df1_2
pacote$item01 <- as.factor(pacote$Item01)
pacote$item02 <- as.factor(pacote$Item02)
pacote$item03 <- as.factor(pacote$Item03)
pacote$item04 <- as.factor(pacote$Item04)
pacote$item05 <- as.factor(pacote$Item05)
pacote$item06 <- as.factor(pacote$Item06)
str(pacote)

pacote_split <- split(pacote$Item01,
                      pacote$Item02,
                      pacote$Item03,
                      pacote$Item04,
                      pacote$Item05,
                      pacote$Item06)


View(pacote_split)

# Transações
transacoes <- as(pacote_split, "transactions")

# Vamos verificar as regras de um produto: Dust-Off Compressed Gas 2 pack
regra_produto <- apriori(transacoes, 
                         parameter = list(conf = 0.5, minlen = 3),
                         appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs"))

inspect(head(sort(regra_produto, by = "confidence"), 5))

# Vamos verificar novamente as regras do produto: Dust-Off Compressed Gas 2 pack, 
# alterando uma das métricas
regra_produto <- apriori(transacoes,
                         parameter = list(conf = 0.5, minlen = 3, supp = 0.2, target = "rules"),
                         appearance = list(rhs = "Dust-Off Compressed Gas 2 pack", default = "lhs"))

inspect(head(sort(regra_produto, by = "confidence"), 5))