setwd("C:/Users/neo2g/OneDrive/Documentos/DataScience Academy/Big Data R Azure/Cap 09/DSA_cap_09")
getwd()

if(!require(car)) install.packages("car")
library(car)

if(!require(tidyverse)) install.packages("tidyverse")
library(tidyverse)

View(sleep)

# “Existe diferença significativa na média de sono dos 2 grupos de pacientes, _
  # ou seja, há diferença significativa entre os dois medicamentos que ajudam _
  # no distúrbio do sono?”




# estratégia 01: avaliar a diferença entre as médias de cada grupo _
  # como temos apenas dois grupos, podemos avaliar usando o teste t _
  # (se tivéssemos 3 grupos poderíamos usar o teste ANOVA)

# para o teste t funcionar precisamos de 5 condições:

# 1- os dados são aleatórios e representativos da população
# 2- A variável dependente é contínua
# 3- Ambos os grupos são independentes (exaustivos excludentes)
# 4- Os resíduos do modelo são normalmente distribuídos
# 5- A variância residual é homogênea (princípio da homocedasticidade). _
  # Isso significa dizer que a variÂncia entre os dois grupos é a mesma

# para esse estudo de caso iremos adotar como verdadeiras as suposições _
  # 1 a 3 e validaremos as suposições 4 (teste de Shapiro-Wilk) e 5 (teste F)


# Validação da suposição 4 - teste de Shapiro-Wilk
# método 1: qqPlot
## grupo 01
grupo01 <- sleep$group == 1
qqPlot(sleep$extra[grupo01])

## grupo 02
grupo02 <- sleep$group == 2
qqPlot(sleep$extra[grupo02])

# se os pontos estiverem dentro do intervalo de confiança (área sombreada) _
  # provavelmente a variável segue a distribuição normal


# um teste mais objetivo é o teste de Shapiro-Wilk
# Para dizer que uma distribuição é normal, o valor-p precisa ser _
  # maior do que 0,05.

shapiro.test(sleep$extra[grupo01])
shapiro.test(sleep$extra[grupo02])


# O valor-p do teste de cada grupo é maior que 0.05 e então falhamos em _
  # rejeitar a H0.
# Podemos assumir que os dados seguem uma distribuição normal.



# Validação da suposição 5 - teste F
# preciso comparar a variância de dois grupos
# Para rejeitar a hipótese nula de que as médias do grupo são iguais, _
  # precisamos de um valor F alto.
# H0 = As médias de dados extraídos de uma população normalmente distribuída _
  # tem a mesma variância.

# para o teste F não podemos ter valores ausentes nos dados
#qtd_valores_na <- sum(is.na(sleep$extra))
#print(paste("Quantidade de valores ausentes: ", as.character(qtd_valores_na)))
colSums(is.na(sleep))

var.test(extra ~ group, data = sleep)

# O valor-p é de 0.7983426, logo, maior que 0.05. Falhamos em rejeitar a H0.
# Não há diferença significativa enre as variâncias dos 2 grupos.










#Finalizado as validações das suposições 4 e 5, podemos aplicar o teste T

# sintaxe do teste T de Student:
# t.test(variável_dependente ~ variavel_independente, data = nome_do_df, var.equal = TRUE)

t.test(extra ~ group, data = sleep, var.equal = TRUE)


# O valor-p do teste é 0.07919, logo, maior que 0.05. Falhamos em rejeitar a H0.
# Podemos concluir que os 2 grupos não tem diferença significativa.
# Não há diferença significativa entre os medicamentos aplicados para tratar _
  # distúrbios do sono.





















































































