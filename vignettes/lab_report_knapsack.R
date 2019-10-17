## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
devtools::install_github("mubhu398/lineprof")
library(lineprof)

library(lab6grp26)

## ---- eval=FALSE---------------------------------------------------------
#  system.time(
#    knapsack(x=knapsack_objects[1:16,], W=3500)$brute_force_knapsack()
#  )
#  
#  # example
#  #    user  system elapsed
#  #    0.24    0.03    0.26

## ---- eval=FALSE---------------------------------------------------------
#  system.time(
#    knapsack(x=knapsack_objects[1:500,], W=3500)$knapsack_dynamic()
#  )
#  
#  # example
#  #    user  system elapsed
#  #    9.28    0.05    9.34

## ----eval=FALSE----------------------------------------------------------
#  set.seed(42)
#  n <- 1000000
#  example <-
#  data.frame(
#  w=sample(1:4000, size = n, replace = TRUE),
#  v=runif(n = n, 0, 10000)
#  )
#  system.time(
#    knapsack(x=example, W=3500)$greedy_knapsack()
#  )
#  
#  # example
#  #    user  system elapsed
#  #    0.38    0.03    0.41

## ---- eval=FALSE---------------------------------------------------------
#  x1<-lineprof(knapsack(x=knapsack_objects[1:15,], W=3500)$brute_force_knapsack())
#  shine(x1)

## ---- eval=FALSE---------------------------------------------------------
#  ## single core
#  N1 <- 10
#  N2 <- 20
#  system.time(
#    knapsack(x=knapsack_objects[1:N1,], W=3500)$brute_force_knapsack()
#  )
#  #    user  system elapsed
#  #    0.02    0.00    0.01
#  system.time(
#    knapsack(x=knapsack_objects[1:N2,], W=3500)$brute_force_knapsack()
#  )
#  #    user  system elapsed
#  #    7.56    0.23    7.93
#  
#  ## multiple cores
#  system.time(
#    knapsack(x=knapsack_objects[1:N1,], W=3500)$brute_force_knapsack(TRUE)
#  )
#  #    user  system elapsed
#  #    0.13    0.07    1.95
#  
#  system.time(
#    knapsack(x=knapsack_objects[1:N2,], W=3500)$brute_force_knapsack(TRUE)
#  )
#  #    user  system elapsed
#  #    2.35    0.64    6.28

