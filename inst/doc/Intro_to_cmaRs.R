## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(cmaRs)

## -----------------------------------------------------------------------------
data(preddata.std)
head(preddata.std)

## -----------------------------------------------------------------------------
data(classdata.std)
head(classdata.std)

## -----------------------------------------------------------------------------
data(table.b6)
head(table.b6)

## ----echo=TRUE,  results='hide', eval=FALSE-----------------------------------
#  prediction.model <-  cmaRs(Volume ~ ., degree = 2, nk = 20, data = trees)

## ---- eval=FALSE--------------------------------------------------------------
#  summary(prediction.model)
#  #> Call:
#  #> cmaRs(formula = Volume ~ ., data = trees, degree = 2, nk = 20)
#  
#  #> Volume = +29.1634
#  #> +4.9278 * pmax(0,Girth-14.2)
#  #> -3.2309 * pmax(0,14.2-Girth)
#  #> +0.7313 * pmax(0,Height-75)
#  #> -0.1684 * pmax(0,75-Height)
#  #> +0.1312 * pmax(0,Girth-8.3)*pmax(0,Height-75)
#  #> -1.2977 * pmax(0,Height-78)
#  
#  #> R2 0.9793 r 0.9896 RSS 168.0029

## ----eval=FALSE---------------------------------------------------------------
#  fig1 <- plot(prediction.model)

## ----fig1, echo=FALSE, fig.height=12------------------------------------------
knitr::include_graphics("Figure1.png")

## ----eval=FALSE---------------------------------------------------------------
#  predict(prediction.model)
#  #> [1] 9.259021 9.386200 9.695543 16.703820 20.239753 20.164926 17.308760
#  #> [8] 18.824519 22.046053 19.470698 22.996184 21.255036 21.255036 20.075638
#  #> [15] 22.055412 24.794797 29.229259 31.136370 26.874258 26.018423 32.955379
#  #> [22] 34.096100 30.473296 37.528153 43.074254 52.021298 53.805352 54.756953
#  #> [29] 55.315354 55.315354 77.168803

## ----results='hide', warning=FALSE, eval=FALSE, message=FALSE-----------------
#  library(earth)
#  library(cmaRs)
#  classification.model <- cmaRs(survived ~ age, nk = 35,
#                                classification = TRUE, data = etitanic)

## ----eval=FALSE---------------------------------------------------------------
#  summary(classification.model)
#  #> Call:
#  #> cmaRs(formula = survived ~ age, data = etitanic, classification = TRUE,
#  #> nk = 35)
#  #>
#  #> survived = -4.9489
#  #> -0.3084 * pmax(0,age-18)
#  #> +0.3321 * pmax(0,18-age)
#  #> -0.427 * pmax(0,age-53)
#  #> +0.3564 * pmax(0,age-67)
#  #> -0.3291 * pmax(0,age-64)
#  #> +1.1664 * pmax(0,age-46)
#  #> +0.7742 * pmax(0,age-57)
#  #> -0.1451 * pmax(0,age-35)
#  #> -0.7469 * pmax(0,age-58)
#  #> +0.2288 * pmax(0,age-61)
#  #> +0.0725 * pmax(0,age-41)
#  #> -1.0824 * pmax(0,age-45)
#  #> -0.5147 * pmax(0,age-48)
#  #> +0.3658 * pmax(0,age-51)
#  #> +0.281 * pmax(0,age-44)
#  #> +0.0994 * pmax(0,age-34)
#  #> +0.6316 * pmax(0,age-2)
#  #> -0.32 * pmax(0,age-3)
#  #>
#  #> AUC 0.6221 MCR 0.3681 PCC 0.6319 precision 0.6339 recall 0.895 specificity 0.2506

## ----echo=TRUE, results='hide', warning=FALSE, eval=FALSE---------------------
#  classification.model.threshold <- cmaRs(survived ~ age, nk = 35,
#                                classification = TRUE, data = etitanic,
#                                threshold.class = 0.1, Auto.linpreds = FALSE)

## ----eval=FALSE---------------------------------------------------------------
#  summary(classification.model.threshold)
#  #> Call:
#  #> cmaRs(formula = survived ~ age, data = etitanic, classification = TRUE,
#  #> threshold.class = 0.1, nk = 35, Auto.linpreds = FALSE)
#  #>
#  #> survived = -4.9489
#  #> -0.3084 * pmax(0,age-18)
#  #> +0.3321 * pmax(0,18-age)
#  #> -0.427 * pmax(0,age-53)
#  #> +0.3564 * pmax(0,age-67)
#  #> -0.3291 * pmax(0,age-64)
#  #> +1.1664 * pmax(0,age-46)
#  #> +0.7742 * pmax(0,age-57)
#  #> -0.1451 * pmax(0,age-35)
#  #> -0.7469 * pmax(0,age-58)
#  #> +0.2288 * pmax(0,age-61)
#  #> +0.0725 * pmax(0,age-41)
#  #> -1.0824 * pmax(0,age-45)
#  #> -0.5147 * pmax(0,age-48)
#  #> +0.3658 * pmax(0,age-51)
#  #> +0.281 * pmax(0,age-44)
#  #> +0.0994 * pmax(0,age-34)
#  #> +0.6316 * pmax(0,age-2)
#  #> -0.32 * pmax(0,age-3)
#  #>
#  #> AUC 0.6221 MCR 0.5746 PCC 0.4254 precision 1 recall 0.0291 specificity 1

## ----eval=FALSE---------------------------------------------------------------
#  fig2 <- plot(classification.model)

## ----fig2, echo=FALSE, fig.height=6-------------------------------------------
knitr::include_graphics("Figure2.png")

