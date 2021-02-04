rm(list=ls());gc()
library(plm)
library(data.table)
library(readxl)
library(stargazer)
install.packages('MatchIt')
library(MatchIt)

#**** LOAD OBSERVATIONAL DATASET ***#
MyData<-read_excel('Data.xlsx')
MyData<- as.data.table(MyData)

#*** Propensity Score Matching ***#

#*** SET A FIXED SEED IN ORDER TO OBTAIN ALWAYS THE SAME RESULTS ***#
set.seed(123)

#*** MATCH TREATED AND CONTROL CUSTOMERS ON LIKELIHOOD OF TREATMENT ***#
Match <- matchit(Treat ~ IncCat+AgeCat+BefDist+OnlineInt+OnlinePur+OnlineRev+StoreInt+StorePur+StoreRev , data = MyData[Post == 0], method = 'nearest', caliper=0.001)

#*** SUMMARIZE QUALITY OF THE MATCHED SAMPLE ***#
summary(Match)

#*** IDENTIFY MATCHED SAMPLE ***#
MyData.match <- data.table(match.data(Match))
Matched.ids <- MyData$CustID %in% MyData.match$CustID
MyData[, match := Matched.ids]

#write.csv(MyData[match == TRUE],"Q6.csv",row.names = FALSE)

#*** PLM Model ***#
plm_Int <- plm(OnlineInt ~ Post, data=MyData[match == TRUE],
               index = c("CustID","Post"),model="within" )

plm_Pur <- plm(OnlinePur ~ Post, data=MyData[match == TRUE],
               index = c("CustID","Post"),model="within" )

plm_Rev <- plm(OnlineRev ~ Post, data=MyData[match == TRUE],
               index = c("CustID","Post"),model="within" )

stargazer(
  plm_Int,
  plm_Pur,
  plm_Rev,
  se=list(sqrt(diag(vcovHC(plm_Int, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(plm_Pur, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(plm_Rev, method="arellano", type="HC1")))),
  title="Effect of Store Opening on Online Channel",
  dep.var.labels=c('OnlinePurchaseInteraction', 'OnlinePurchaseQuantity', 'OnlinePurchaseRevenue'),
  covariate.labels=c("Post"),
  notes.align="c",
  type="text")

#*** RUN DIFFERENCES IN DIFFERENCES ***#
did_plm_Int <- plm(OnlineInt ~ Post+Post*Treat, data=MyData,
                   index = c("CustID","Post"),model="within" )
summary(did_plm_Int)
did_plm_Pur <- plm(OnlinePur ~ Post+Post*Treat, data=MyData,
                   index = c("CustID","Post"),model="within" )
summary(did_plm_Pur)
did_plm_Rev <- plm(OnlineRev ~ Post+Post*Treat, data=MyData,
                   index = c("CustID","Post"),model="within" )
summary(did_plm_Rev)
stargazer(
  did_plm_Int,
  did_plm_Pur,
  did_plm_Rev,
  se=list(sqrt(diag(vcovHC(did_plm_Int, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(did_plm_Pur, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(did_plm_Rev, method="arellano", type="HC1")))),
  title="Effect of Store Opening on Online Channel",
  dep.var.labels=c('OnlinePurchaseInteraction', 'OnlinePurchaseQuantity', 'OnlinePurchaseRevenue'),
  covariate.labels=c("Post", "Post:Treat"),
  notes.align="c",
  type="text")

#*** DIFFERENCES IN DIFFERENCES ON MATCHED CUSTOMERS ***#
did_match_plm_Int <- plm(OnlineInt ~ Post+Post*Treat, data=MyData[match==TRUE],
                         index = c("CustID","Post"),model="within" )
summary(did_match_plm_Int)
did_match_plm_Pur <- plm(OnlinePur ~ Post+Post*Treat, data=MyData[match==TRUE],
                         index = c("CustID","Post"),model="within" )
summary(did_match_plm_Pur)
did_match_plm_Rev <- plm(OnlineRev ~ Post+Post*Treat, data=MyData[match==TRUE],
                         index = c("CustID","Post"),model="within" )
summary(did_match_plm_Rev)

stargazer(
  did_match_plm_Int,
  did_match_plm_Pur,
  did_match_plm_Rev,
  se=list(sqrt(diag(vcovHC(did_match_plm_Int, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(did_match_plm_Pur, method="arellano", type="HC1"))),
          sqrt(diag(vcovHC(did_match_plm_Rev, method="arellano", type="HC1")))),
  title="Effect of Store Opening on Online Channel",
  dep.var.labels=c('OnlinePurchaseInteraction', 'OnlinePurchaseQuantity', 'OnlinePurchaseRevenue'),
  covariate.labels=c("Post", "Post:Treat"),
  notes.align="c",
  type="text")

