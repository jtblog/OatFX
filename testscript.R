# library(websocket)
# library(lubridate)
# library(rqdatatable)
# 
# ws <- WebSocket$new("wss://ws.binaryws.com/websockets/v3?app_id=15805", autoConnect = TRUE)
# 
# dt = {}
# 
# ws$onOpen(
#   function(event){
#     cat("Connected")
#     ws$send('{"ticks":"R_100"}')
#   }
# )
# 
# ws$onMessage(
#   function(event) {
#     dt <<- event$data
#     cat(dt, "\n")
#     }
#   )
# 
# # Tick history and subscription
# # {
# #   "ticks_history": "R_50",
# #   "adjust_start_time": 1,
# #   "count": 5,
# #   "end": "latest",
# #   "start": 5000,
# #   "style": "candles",
# #   "granularity": 60,
# #   "subscribe": 1
# # }
# 
# # Tick history response
# # Response
# res0 = '{
#   "candles": [
#     {
#       "close": 132.1521,
#       "epoch": 1616261460,
#       "high": 132.2527,
#       "low": 132.1521,
#       "open": 132.1856
#     },
#     {
#       "close": 132.1076,
#       "epoch": 1616261520,
#       "high": 132.2089,
#       "low": 132.0826,
#       "open": 132.177
#     },
#     {
#       "close": 132.0855,
#       "epoch": 1616261580,
#       "high": 132.1781,
#       "low": 132.0681,
#       "open": 132.0974
#     },
#     {
#       "close": 132.0876,
#       "epoch": 1616261640,
#       "high": 132.0894,
#       "low": 131.9912,
#       "open": 132.0864
#     },
#     {
#       "close": 132.0909,
#       "epoch": 1616261700,
#       "high": 132.1589,
#       "low": 132.0825,
#       "open": 132.1052
#     }
#   ],
#   "echo_req": {
#     "adjust_start_time": 1,
#     "count": 5,
#     "end": "latest",
#     "granularity": 60,
#     "start": 5000,
#     "style": "candles",
#     "ticks_history": "R_50"
#   },
#   "msg_type": "candles",
#   "pip_size": 4
# }'
# 
# # Tick stream response
# res1 <- '{
#   "echo_req": {
#     "subscribe": 1,
#     "ticks": "R_50"
#   },
#   "msg_type": "tick",
#   "subscription": {
#     "id": "d949b0c2-2445-e1f3-eba9-44dffc13a0da"
#   },
#   "tick": {
#     "ask": 132.2574,
#     "bid": 132.2374,
#     "epoch": 1616262478,
#     "id": "d949b0c2-2445-e1f3-eba9-44dffc13a0da",
#     "pip_size": 4,
#     "quote": 132.2474,
#     "symbol": "R_50"
#   }
# }'
# 
# # Forget all ticks response
# # {
# #   "echo_req": {
# #     "forget_all": "ticks"
# #   },
# #   "forget_all": [
# #     "d949b0c2-2445-e1f3-eba9-44dffc13a0da"
# #   ],
# #   "msg_type": "forget_all"
# # }
# 
# # Authorize
# # {
# #   "authorize": "1aStI5HCcty55Ly"
# # }
# 
# #Authorize response
# # {
# #   "authorize": {
# #     "account_list": [
# #       {
# #         "currency": "USD",
# #         "is_disabled": 0,
# #         "is_virtual": 0,
# #         "landing_company_name": "svg",
# #         "loginid": "CR508314"
# #       },
# #       {
# #         "currency": "USD",
# #         "is_disabled": 0,
# #         "is_virtual": 1,
# #         "landing_company_name": "virtual",
# #         "loginid": "VRTC1521900"
# #       }
# #     ],
# #     "balance": 23584.69,
# #     "country": "ng",
# #     "currency": "USD",
# #     "email": "jtob91@yahoo.com",
# #     "fullname": "  ",
# #     "is_virtual": 1,
# #     "landing_company_fullname": "Deriv Limited",
# #     "landing_company_name": "virtual",
# #     "local_currencies": {
# #       "NGN": {
# #         "fractional_digits": 2
# #       }
# #     },
# #     "loginid": "VRTC1521900",
# #     "scopes": [
# #       "read",
# #       "trade",
# #       "payments",
# #       "admin"
# #     ],
# #     "upgradeable_landing_companies": [
# #
# #     ],
# #     "user_id": 5632887
# #   },
# #   "echo_req": {
# #     "authorize": "<not shown>"
# #   },
# #   "msg_type": "authorize"
# # }
# 
# #ws$connect()
# 
# ws$send('{"forget_all":"ticks"}')
# 
# #library(jsonlite)
# #dt = jsonlite::fromJSON(dt)
# 
# #lubridate::as_datetime(1616259596)
# #lubridate::now("UTC")
# 
# coint <- function(vars) {
#   d<-as.matrix(vars) #convert data frame to Matrix
#   n<-length(colnames(vars)) #calculate the total number of variables
#   m<-combn(n,2) #calculate all possible combinations of pairs for all variables
#   col_m<-dim(m)[2] #number of all possible combinations
#   result<-matrix(NA,nrow=col_m,ncol=3) #empty result matrix
#   colnames(result)<-c("Var1","Var2","value")
#   for (i in 1:col_m){
#     Var_1<-m[1,i]
#     Var_2<-m[2,i]
#     res <- lm(d[,Var_1] ~ d[,Var_2] + 0)$residuals
#     p<-tseries::adf.test(res, alternative = "stationary", k = 0)$p.value
#     result[i,1]<-colnames(vars)[Var_1]
#     result[i,2]<-colnames(vars)[Var_2]
#     result[i,3]<-round(p,4)
#   }
#   tmpdt <- data.frame(result)
#   for(name in colnames(vars)){
#     tmpdt[nrow(tmpdt)+1,] = list("Var1" = name,"Var2" = name,"value" = 0.01)
#   }
#   result <- data.frame("Var1" = as.factor(tmpdt[,"Var1"]),
#                        "Var2" = as.factor(tmpdt[,"Var2"]),
#                        "value" = as.numeric(tmpdt[,"value"]))
#   m = dcast(result, Var1 ~ Var2)
#   row.names(m) <- as.vector(m[,"Var1"])
#   m[,"Var1"] <- NULL
#   n <- as.data.frame(t(m))
#   m$ID = as.vector(rownames(m))
#   n$ID = as.vector(rownames(n))
#   final <- natural_join(m, n, by="ID", jointype="FULL")
#   row.names(final) <- as.vector(final[,"ID"])
#   final[,"ID"] <- NULL
#   result <- final
# 
#   return(result)
# }
# 
# library(tseries)
# 
# 
# mydata <- mtcars[, c(1,3,4,5,6,7)]
# cormat <- round(cor(mydata),4)
# cointmat <- round(coint(mydata),4)
# 
# # Get lower triangle of the correlation matrix
# get_lower_tri<-function(cormat){
#   cormat[upper.tri(cormat)] <- NA
#   return(cormat)
# }
# # Get upper triangle of the correlation matrix
# get_upper_tri <- function(cormat){
#   cormat[lower.tri(cormat)]<- NA
#   return(cormat)
# }
# 
# reorder_cormat <- function(cormat){
#   # Use correlation between variables as distance
#   dd <- as.dist((1-cormat)/2)
#   hc <- hclust(dd)
#   cormat <-cormat[hc$order, hc$order]
# }
# 
# cormat <- reorder_cormat(cormat)
# upper_tri <- get_upper_tri(cormat)
# # Melt the correlation matrix
# melted_cormat <- melt(upper_tri, na.rm = TRUE)
# 
# cointmat <- as.matrix(coint(mydata))
# cointmat <- reorder_cormat(cointmat)
# upper_tri <- get_upper_tri(cointmat)
# melted_cormat <- melt(upper_tri, na.rm = TRUE)
# # melted_cormat <- reorder_cormat(melted_cormat)
# # Create a ggheatmap
# ggheatmap <- ggplot(melted_cointmat, aes(Var2, Var1, fill = value)) +
#   geom_tile()+
#   scale_fill_gradient2(low = "blue", high = "red",
#                        midpoint = 0.05, limit = c(0,1), space = "Lab",
#                        name="Augmented\nDickey\nFuller\nP_Values") +
#   theme_minimal()+ # minimal theme
#   # theme(axis.text.x = element_text(angle = 45, vjust = 1,
#   #                                  size = 12, hjust = 1))+
#   coord_fixed()
# 
# ggheatmap <- ggheatmap +
#   geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) #+
#   # theme(
#   #   axis.title.x = element_blank(),
#   #   axis.title.y = element_blank(),
#   #   panel.grid.major = element_blank(),
#   #   panel.border = element_blank(),
#   #   panel.background = element_blank(),
#   #   axis.ticks = element_blank(),
#   #   legend.justification = c(1, 0),
#   #   # legend.position = c(0.6, 0.7),
#   #   legend.direction = "vertical") +
#   #   guides(fill = guide_colorbar(barwidth = 1, barheight = 7,
#   #                              title.position = "top", title.hjust = 0.5)
#   #        )
# 
# print(ggheatmap)
# 
# # # Create a ggheatmap
# # ggheatmap <- ggplot(melted_cormat, aes(Var2, Var1, fill = value)) +
# #   geom_tile(color = "white")+
# #   scale_fill_gradient2(low = "blue", high = "blue", mid = "red",
# #                        midpoint = 0, limit = c(-1,1), space = "Lab",
# #                        name="Pearson\nCorrelation") +
# #   theme_minimal()+ # minimal theme
# #   theme(axis.text.x = element_text(angle = 45, vjust = 1,
# #                                    size = 12, hjust = 1))+
# #   coord_fixed()
# #
# # ggheatmap <- ggheatmap +
# #   geom_text(aes(Var2, Var1, label = value), color = "black", size = 4) +
# #   theme(
# #     axis.title.x = element_blank(),
# #     axis.title.y = element_blank(),
# #     panel.grid.major = element_blank(),
# #     panel.border = element_blank(),
# #     panel.background = element_blank(),
# #     axis.ticks = element_blank(),
# #     legend.justification = c(1, 0),
# #     # legend.position = c(0.6, 0.7),
# #     legend.direction = "vertical") +
# #   guides(fill = guide_colorbar(barwidth = 1, barheight = 7,
# #                                title.position = "top", title.hjust = 0.5)
# #   )
# 
# 
# test <- function(i){
#   seconds_left = (60-second(lubridate::now("UTC"))) * 1000
#   i <<- i+1
#   print(i)
#   cat(paste(seconds_left,"\n",sep = ""))
#   tclTaskChange(id="test", expr = test(i), wait=seconds_left, redo = T)
# }
# 
# i=1
# seconds_left = (60-second(lubridate::now("UTC"))) * 1000
# tclTaskSchedule(seconds_left, test(i), id="test", redo = T)
# tclTaskDelete("test")