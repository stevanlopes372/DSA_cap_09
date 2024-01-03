# Análise Exploratória de Dados 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome
setwd("C:/Users/neo2g/OneDrive/Documentos/Github Repos/Data-Science-Academy")
getwd()


# Carregando o pacote readr
library(readr)

# Carregando o dataset
df <- data.frame(iris)

# Resumo dos dados
View(df)
str(df)

# Medidas de Tendência Central
summary(df)
summary(df[c('Sepal.Length', 'Petal.Width')])
summary(df$Species)


##### Análise Exploratória de Dados Para Variáveis Numéricas ##### 

# Usando as funções
mean(df$Sepal.Length)
median(df$Sepal.Length)
quantile(df$Sepal.Length)

# Plot

# Boxplot
# Leitura de Baixo para Cima - Q1, Q2 (Mediana) e Q3

# Histograma
# Indicam a frequência de valores dentro de cada bin (classe de valores)

# Scatterplot Preço x Km
# Usando o preço como variável dependente (y)

# Medidas de Dispersão
# Ao interpretar a variância, números maiores indicam que 
# os dados estão espalhados mais amplamente em torno da 
# média. O desvio padrão indica, em média, a quantidade 
# de cada valor diferente da média.
