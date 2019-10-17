#'knapsack problem
#'
#'This is package of 'knapsack' problem.
#'
#'
#' @field x A data frame.
#' @field W A numeric.
#' @field item A vector.
#' 
#' @import methods
#' @importFrom parallel parSapply detectCores makeCluster stopCluster
#' 
#' @export knapsack
#' @exportClass knapsack

knapsack <- setRefClass("knapsack",
  fields = list(
    x = "data.frame",
    W = "numeric",
    item = "vector"
  ),
  methods = list(
    initialize = function(x, W){
      check(x,W)
      x <<- x
      W <<- W
      item <<- rep(0,nrow(x))
    },
    #check the inputs
    check = function(a,b){
      a[a<=0]<-NA
      if(!is.data.frame(a)||is.na(sum(a))||b<0)
        stop("Please check your inputs.")
    },
    #Brute force search
    brute_force_knapsack = function(parallel = FALSE){
      n <- nrow(x)
      idx <- 1:(2^n-1)
      t <- vector()
      if(parallel==TRUE){
        clnum<-parallel::detectCores()
        cl <- parallel::makeCluster(getOption("cl.cores", clnum))
        mat <- parallel::parSapply(cl, idx, function(id){
          t <- cbind(t, as.integer(intToBits(id)))
          t
        })
        parallel::stopCluster(cl)
      }else{
        mat <- sapply(idx, function(id){
          t <- cbind(t, as.integer(intToBits(id)))
          t
        })
      }
      results <- t(x)%*%mat[1:nrow(x),]
      MAX <- max(as.matrix(results[,results[1,]<=W])[2,])
      best <- mat[,which(results[2,]==MAX)]
      list(value=round(MAX,0), elements=which(best==1))
    },
    #Dynamic programming
    knapsack_dynamic = function(){
      n <- nrow(x)
      rows <- 1:n
      cols <- 1:W
      w <- x[,1]
      v <- x[,2]
      mat <- matrix(rep(0,n*W),nrow = n)
      colnames(mat)<-cols
      rownames(mat)<-rows
      for(j in 1:W){
        for(i in 1:n){
          if(cols[j]<w[i]){
            if(i-1==0)
              mat[i,j] <- 0
            else
              mat[i,j] <- mat[i-1,j]
          }else{
            if(i-1==0||(j-w[i]==0))
              mat[i,j] <- 0
            else{
              V_add <- mat[i-1,(j-w[i])]
              V_unadd <- mat[i-1,j]
              mat[i,j] <- max(V_unadd, V_add + v[i])
            }
          }
        }
      }
      FindWhat<-function(i, j){
        if(i>0){
          if((i-1)==0)
            va <- 0
          else
            va <- mat[i-1,j]
          if((j-w[i])==0||(i-1)==0)
            va2 <- 0
          else
            va2 <- mat[i-1,(j-w[i])]
          if(mat[i,j]==va){
            item[i]<<-0
            FindWhat(i-1,j)
          }
          else if( j-w[i]>=0 && mat[i,j]==va2+v[i]){
            item[i]<<-1
            FindWhat(i-1,j-w[i])
          }
        }
      }
      FindWhat(n,W)
      list(value=round(max(mat),0), elements=which(item==1))
    },
    #Greedy heuristic
    greedy_knapsack = function(){
      x1 <- x
      x1$rows_idx <- row(x1)    # mark the goods with numbers
      x1 <- x1[x1$w < W,]        # only select the goods who can carry
      x1$vw_ratio <- x1$v/x1$w   # calculate their price-quality ratios
      dsc_ordr <- order(x1$vw_ratio, decreasing = TRUE)
      x1 <- x1[dsc_ordr,]

      rslt <- list(value = 0)
      curr_weight <- 0
      i <- 1
      repeat{
        if(curr_weight <= W){
          curr_weight <- curr_weight + x1$w[i]
          rslt$value <- rslt$value + x1$v[i]
          rslt$elements[i] <- x1$row[i]
          i <- i + 1
          if(i>nrow(x1) || curr_weight+x1$w[i]>W){
            break()
          }
        }
      }
      rslt$value <- round(rslt$value,0)
      return(rslt)
    }
  )
)
