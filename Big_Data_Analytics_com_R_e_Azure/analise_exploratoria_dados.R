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
boxplot(df)

# Histograma
# Indicam a frequência de valores dentro de cada bin (classe de valores)
hist(df$Sepal.Length)
hist(df$Sepal.Width)
hist(df$Petal.Width)



# Scatterplot Preço x Km
# Usando o preço como variável dependente (y)
plot(
  df$Sepal.Length
  ,df$Sepal.Width
  ,main = "Scatterplot"
  )

plot(
  df$Sepal.Length
  ,df$Petal.Length
  ,main = "Scatterplot"
  )

plot(
  df$Sepal.Length
  ,df$Petal.Width
  ,main = "Scatterplot"
)

plot(
  df$Petal.Length
  ,df$Petal.Width
  ,main="Scatterplot"
)


# Medidas de Dispersão
# Ao interpretar a variância, números maiores indicam que 
# os dados estão espalhados mais amplamente em torno da 
# média. O desvio padrão indica, em média, a quantidade 
# de cada valor diferente da média.
var(df$Sepal.Length)
sd(df$Sepal.Length)



##### Análise Exploratória de Dados Para Variáveis Categóricas ##### 

# Criando tabelas de contingência - representam uma única variável categórica
# Lista as categorias das variáveis nominais
?table
str(df)
table(df$Species)


# Calculando a proporção de cada categoria
model_table <- table(df$Species)
prop.table(model_table)

# Arrendondando os valores
model_table <- table(df$Species)
model_table <- prop.table(model_table) * 100
round(model_table, digits = 0)

