# Solução Lista de Exercícios - Capítulo 10 

# Obs: Caso tenha problemas com a acentuação, consulte este link:
# https://support.rstudio.com/hc/en-us/articles/200532197-Character-Encoding

# Configurando o diretório de trabalho
# Coloque entre aspas o diretório de trabalho que você está usando no seu computador
# Não use diretórios com espaço no nome

setwd("C:/Users/neo2g/OneDrive/Documentos/Github Repos/Data-Science-Academy/DSA Files/Cap 10")
getwd()


# Pacotes
install.packages("dplyr")
install.packages("nycflights13")

library("ggplot2")
library("dplyr")
library("nycflights13")
View(flights)
?flights

# Definindo o Problema de Negócio
# Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)

# H0 = Não há diferença estatisticamente significativa entre os atrasos de vôo _
# da DL e da UA
# atraso DL = atraso UA

# HA = Os atrasos nos vôos da DL são mais longos que os da UA
# atraso DL > atraso UA



##### ATENÇÃO #####
# Você vai precisar do conhecimento adquirido em outros capítulos do curso 
# estudados até aqui para resolver esta lista de exercícios!


# Exercício 1 - Construa o dataset pop_data com os dados de voos das 
  # companhias aéreas UA (United Airlines) e DL (Delta Airlines). 
# O dataset deve conter apenas duas colunas, nome da companhia e atraso nos voos de chegada.
# Os dados devem ser extraídos do dataset flights para construir o dataset pop_data
# Vamos considerar este dataset como sendo nossa população de voos


class(flights)

nome_companhia <- c(flights$carrier)
atraso <- c(flights$arr_delay)
pop_data <- data_frame(Companhia = nome_companhia, Atraso = atraso)
pop_data <- pop_data[pop_data$Companhia == "UA" | pop_data$Companhia == "DL", ]
pop_data <- pop_data[pop_data$Atraso >= 0, ]
pop_data <- na.omit(pop_data)
View(pop_data)


# Exercício 2  - Crie duas amostras de 1000 observações cada uma a partir do 
# dataset pop_data apenas com dados da companhia DL para amostra 1 e apenas dados 
# da companhia UA na amostra 2

# DL = amostra 1
# UA = amostra 2

pop_data_DL <- subset(pop_data, Companhia == "DL")
pop_data_DL <- pop_data_DL[sample(nrow(pop_data_DL), 1000), ]
View(pop_data_DL)
write.csv(pop_data_DL, file = "pop_data_dl.csv", row.names = FALSE)


pop_data_UA <- subset(pop_data, Companhia == "UA")
pop_data_UA <- pop_data_UA[sample(nrow(pop_data_UA),1000), ]
View(pop_data_UA)
write.csv(pop_data_UA, file = "pop_data_ua.csv", row.names = FALSE)

# Dica: inclua uma coluna chamada sample_id preenchida com número 1 para a primeira 
  # amostra e 2 para a segunda amostra
pop_data_DL$amostra <- 1
pop_data_UA$amostra <- 2


# Exercício 3 - Crie um dataset contendo os dados das 2 amostras criadas no item anterior. 
pop_data <- rbind(pop_data_DL, pop_data_UA)
View(pop_data)


# Exercício 4 - Calcule o intervalo de confiança (95%) da amostra1
# Usamos a fórmula: erro_padrao_amostra1 = sd(amostra1$arr_delay) / sqrt(nrow(amostra1))

# Esta fórmula é usada para calcular o desvio padrão de uma distribuição da média amostral
# (de um grande número de amostras de uma população). Em outras palavras, só é aplicável 
# quando você está procurando o desvio padrão de médias calculadas a partir de uma amostra de 
# tamanho n𝑛, tirada de uma população.

# Digamos que você obtenha 10000 amostras de uma população qualquer com um tamanho de amostra de n = 2.
# Então calculamos as médias de cada uma dessas amostras (teremos 10000 médias calculadas).
# A equação acima informa que, com um número de amostras grande o suficiente, o desvio padrão das médias 
# da amostra pode ser aproximado usando esta fórmula: sd(amostra) / sqrt(nrow(amostra))
  
# Deve ser intuitivo que o seu desvio padrão das médias da amostra será muito pequeno, 
# ou em outras palavras, as médias de cada amostra terão muito pouca variação.

# Com determinadas condições de inferência (nossa amostra é aleatória, normal, independente), 
# podemos realmente usar esse cálculo de desvio padrão para estimar o desvio padrão de nossa população. 
# Como isso é apenas uma estimativa, é chamado de erro padrão. A condição para usar isso como 
# uma estimativa é que o tamanho da amostra n é maior que 30 (dado pelo teorema do limite central) 
# e atende a condição de independência n <= 10% do tamanho da população.

# Erro padrão
# erro_padrao_amostra1 = sd(amostra1$arr_delay) / sqrt(nrow(amostra1))


t_test_ua <- t.test(pop_data_UA$Atraso)
ic_ua <- t_test_ua$conf.int
mean_ua <- t_test_ua$estimate


# Exercício 5 - Calcule o intervalo de confiança (95%) da amostra2
t_test_dl <- t.test(pop_data_DL$Atraso)
ic_dl <- t_test_dl$conf.int
mean_dl <- t_test_dl$estimate

# Exercício 6 - Crie um plot Visualizando os intervalos de confiança criados nos itens anteriores
# Dica: Use o geom_point() e geom_errorbar() do pacote ggplot2

df_ic_appended <- data.frame(Companhia = c("UA", "DL"))
df_ic_appended$Mean <- c(mean_ua, mean_dl)
df_ic_appended$Min <- c(ic_ua[1], ic_dl[1])
df_ic_appended$Max <- c(ic_ua[2], ic_dl[2])

ggplot(df_ic_appended, aes(x=Companhia, y=Mean)) + 
  geom_point() +
  geom_errorbar(aes(ymin=Min, ymax=Max), width=0.2)


# Exercício 7 - Podemos dizer que muito provavelmente, as amostras vieram da _
  # mesma população? 
# Por que?
resultado_teste <- t.test(pop_data_UA$Atraso, pop_data_DL$Atraso, alternative = "greater")
#sendo p-value = 0,5613, ou seja, maior que 0,05, nós falhamos em rejeitar a _
  # hipótese nula.
#Isso pode ser interpretado como tendo evidência suficiente para concluir que _
  # as médias das duas populações NÃO são diferentes, ou seja, as amostras podem _
  # ter vindo da mesma população.


# Exercício 8 - Crie um teste de hipótese para verificar se os voos da Delta Airlines (DL)
# atrasam mais do que os voos da UA (United Airlines)

# H0 e H1 devem ser mutuamente exclusivas.


# H0 = Não há diferença estatisticamente significativa entre os atrasos de vôo _
# da DL e da UA
# atraso DL = atraso UA

# HA = Os atrasos nos vôos da DL são mais longos que os da UA
# atraso DL > atraso UA


# para o teste t funcionar precisamos de 5 condições:
# 1- os dados são aleatórios e representativos da população
# 2- A variável dependente é contínua
# 3- Ambos os grupos são independentes (exaustivos excludentes)
# 4- Os resíduos do modelo são normalmente distribuídos
# 5- A variância residual é homogênea (princípio da homocedasticidade) _
# Isso significa dizer que a variÂncia entre os dois grupos é a mesma



# 1- os dados são aleatórios e representativos da população
  # ok - utilizamos uma amostra de 1000 itens aleatórios para ambas as companhias


# 2- A variável dependente é contínua
  # ok


# 3- Ambos os grupos são independentes (exaustivos excludentes)
  # sabemos que uma companhia pode influenciar nos horários de outra companhia (como por exemplo atrasos cumulativos).
  # mas para fins didáticos aceitaremos esse item como OK



# 4- Os resíduos do modelo são normalmente distribuídos
#verificando DL
shapiro.test(pop_data_DL$Atraso)

#verificando UA
shapiro.test(pop_data_UA$Atraso)

#verificado que ambos possuem p-value menor que 0,05 (2,2e-16), o que nos permite assumir distribuição normal



# 5- A variância residual é homogênea (princípio da homocedasticidade) _
# Isso significa dizer que a variÂncia entre os dois grupos é a mesma

var.test(pop_data_DL$Atraso, pop_data_UA$Atraso)

