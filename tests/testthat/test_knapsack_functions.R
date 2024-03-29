context("knapsack")

test_that("inputs are correct.",{
  expect_error(knapsack("knapsack_objects[1:8,]", 3500)$greedy_knapsack(),"Please check your inputs.")
  expect_error(knapsack(knapsack_objects[1:8,], " ")$brute_force_knapsack(),"Please check your inputs.")
  expect_error(knapsack(knapsack_objects[1:8,], -1)$knapsack_dynamic(),"Please check your inputs.")
  x <- knapsack_objects[1:8,]
  x[1,1] <- NA
  expect_error(knapsack(data.frame(x),3500)$brute_force_knapsack(),"Please check your inputs.")
  x <- data.frame(knapsack_objects[1:8,][1,1] <- -1)
  expect_error(knapsack(x, 3500)$greedy_knapsack(),"Please check your inputs.")
})

test_that("outputs are correct by the brute force method.",{
  outputs <- knapsack(x = knapsack_objects[1:8,], W = 3500)$brute_force_knapsack()
  expect_equal(outputs$value,16770)
  expect_equal(outputs$elements,c(5,8))
  outputs <- knapsack(x = knapsack_objects[1:12,], W = 3500)$brute_force_knapsack()
  expect_equal(outputs$value,16770)
  expect_equal(outputs$elements,c(5,8))
  outputs <- knapsack(x = knapsack_objects[1:8,], W = 2000)$brute_force_knapsack()
  expect_equal(outputs$value,15428)
  expect_equal(outputs$elements,c(3,8))
  outputs <- knapsack(x = knapsack_objects[1:12,], W = 2000)$brute_force_knapsack()
  expect_equal(outputs$value,15428)
  expect_equal(outputs$elements,c(3,8))
})

test_that("outputs are correct by the dynamic method.",{
  outputs <- knapsack(x = knapsack_objects[1:8,], W = 2000)$knapsack_dynamic()
  expect_equal(outputs$value,15428)
  expect_equal(outputs$elements,c(3,8))
  outputs <- knapsack(x = knapsack_objects[1:12,], W = 2000)$knapsack_dynamic()
  expect_equal(outputs$value,15428)
  expect_equal(outputs$elements,c(3,8))
})

test_that("outputs are correct by the greedy method.",{
  outputs <- knapsack(x = knapsack_objects[1:800,], W = 3500)$greedy_knapsack()
  expect_equal(outputs$value,192647)
  expect_equal(outputs$elements,c(92, 574, 472, 80, 110, 537, 332, 117, 37, 776,
                                  577, 288, 234, 255, 500, 794, 55, 290, 436, 346,
                                  282, 764, 599, 303, 345, 300, 243, 43, 747, 35,
                                  77, 229, 719, 564))
  outputs <- knapsack(x = knapsack_objects[1:1200,], W = 2000)$greedy_knapsack()
  expect_equal(outputs$value,212337)
  expect_equal(outputs$elements,c(92, 574, 472, 80, 110, 840, 537, 1000,
                                  332, 117, 37, 1197, 1152, 947, 904,
                                  776, 577, 288, 1147, 1131, 234, 255,
                                  1006, 833, 1176, 1092, 873, 828,
                                   1059, 500, 1090, 794, 1033))
})
