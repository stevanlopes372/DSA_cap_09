setwd("C:/Users/neo2g/OneDrive/Documentos/DataScience Academy/Big Data R Azure/Cap 09/DSA_cap_09")
getwd()


# Distribuição Poisson
?dpois

## Exemplo: considere um processo que tem uma taxa de 0,5 defeitos por unidade
### Qual a probabilidade de uma unidade apresentar dois defeitos?
dpois(2, 0.5)

### E nenhum defeito?
dpois(0, 0.5)

### e apenas 1 defeito?
dpois(1, 0.5)



# Distribuição normal
x <- rnorm(100)
hist(x)
