Pair <- setRefClass("Pair",
                       fields = list(symbol = "character", data = "data.frame", hreq = "logical"),
                       methods = list(
                         # withdraw = function(x) {
                         #   # bal <<- bal - x
                         # },
                         # deposit = function(x) {
                         #   # bal <<- bal + x
                         # },
                         standardized_close = function(){
                           close1 = as.numeric(data$close)
                           # return ( close1 - mean(close1)) / sd(close1)
                           return(close1)
                         },
                         set_data = function(dt){
                           for(v in colnames(dt)){
                             if(v != "epoch"){
                               dt[,v] = as.numeric(dt[,v])
                             }
                           }
                           data <<- dt
                         }
                       )
)

Combination <- setRefClass("Combination",
                           fields = list(symbol1 = "character", symbol2 = "character", data = "data.frame", positively_correlated = "logical", adf_p = "numeric"),
                           methods = list(
                             # withdraw = function(x) {
                             #   # bal <<- bal - x
                             # },
                             # deposit = function(x) {
                             #   # bal <<- bal + x
                             # }
                             standardized_close = function(){
                               return (data$close - mean(data$close)) / sd(data$close)
                             },
                             set_data = function(dt){
                               data[,"res"] <<- dt[,"res"]
                             }
                           )
)

Account <- setRefClass("Account",
                    fields = list(balance = "numeric"),
                    methods = list(
                      withdraw = function(x) {
                        # balance <<- balance - x
                      },
                      deposit = function(x) {
                        # balance <<- balance + x
                      }
                    )
)

# a <- Pair$new(symbol = "frxAUDJPY", data = data.frame(), hreq = FALSE)
# a$deposit(100)
# a$symbol
