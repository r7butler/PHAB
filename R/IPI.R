#' IPI scores
#'
#' Estimate IPI scores for PHAB using station and physical habitat data
#' 
#' @param stations \code{data.frame} of input station data
#' @param phab \code{data.frame} of input physical habitat data
#' @param qa logical indicating of quality assurance columns are appended to the output
#' @param allerr logical indicating if all errors are returned or the first encountered
#' 
#' @return A results \code{data.frame} of IPI and metric scores, quality assurance results are returned if \code{qa = TRUE} (default)
#' 
#' @importFrom dplyr mutate
#' @importFrom magrittr "%>%"
#' @importFrom plyr ddply join summarize
#' @importFrom reshape2 dcast
#' @importFrom tidyr gather spread
#'
#' @import randomForest
#' 
#' @export
#'
#' @examples
#' IPI(stations, phab)
IPI <- function(stations, phab, qa = TRUE, allerr = TRUE){
  
  # sanity checks
  chkinp(stations, phab, qa = qa, allerr = allerr)
 
  # append unique SampleID
  phab$PHAB_SampleID<-paste(phab$StationCode, phab$SampleDate, sep="_")
  
  # sel.metrics
  sel.metrics<-c("Ev_FlowHab", "H_AqHab", "XCMG", "H_SubNat", "PCT_SAFN")

  # subset phab by required metrics
  all.req.phab<-c("XSLOPE","XBKF_W", "H_AqHab","PCT_SAFN","XCMG","Ev_FlowHab","H_SubNat","XC",
                  "PCT_POOL","XFC_ALG","PCT_SA","PCT_RC")
  phab<-phab[which(phab$Variable %in% all.req.phab),c("StationCode","SampleDate","PHAB_SampleID", "Variable","Result","Count_Calc")]
  
  # What are the required predictors?
  preds.req<-unique(c(row.names(H_AqHab$importance),row.names(XCMG$importance),row.names(PCT_SAFN$importance)))
  field.preds.req<-c("XSLOPE","XBKF_W")
  gis.preds.req<-setdiff(preds.req, field.preds.req)
  
  # Field predictors
  phab.preds<-phab[which(phab$Variable %in% field.preds.req),]
  phab.preds<-dcast(phab.preds, StationCode+SampleDate+PHAB_SampleID~Variable, value.var = "Result")
  
  ##########
  #Assemble predictor matrix
  preds<-merge(phab.preds, unique(stations[c("StationCode",gis.preds.req)]))

  #Assemble phab output
  phab.scores<-dcast(phab[which(phab$Variable %in% c(sel.metrics,"PCT_RC")),],StationCode+SampleDate+PHAB_SampleID~Variable, value.var = "Result")
  
  #Ev_FlowHab: Unmodeled decreaser
  phab.scores$Ev_FlowHab_pred<-NA
  phab.scores$Ev_FlowHab_score<-  (phab.scores$Ev_FlowHab - 0.025)/(0.95  - 0.025)
  phab.scores$Ev_FlowHab_score[which(phab.scores$Ev_FlowHab_score>1)]<-1
  phab.scores$Ev_FlowHab_score[which(phab.scores$Ev_FlowHab_score<0)]<-0
  
  #H_NatSub: Unmodeled decreaser
  phab.scores$H_SubNat_pred<-NA
  phab.scores$H_SubNat_score<-   (phab.scores$H_SubNat - 0)/(1.9  - 0)
  phab.scores$H_SubNat_score[which(phab.scores$H_SubNat_score>1)]<-1
  phab.scores$H_SubNat_score[which(phab.scores$H_SubNat_score<0)]<-0
  
  #PCT_SAFN: Modeled, increaser
  phab.scores$PCT_SAFN_pred<-  predict(PCT_SAFN, newdata = preds)
  # # Original scoring
  # phab.scores$PCT_SAFN_score<-  ((phab.scores$PCT_SAFN-phab.scores$PCT_SAFN_pred) - 53.2)/((-16.4)  - 53.2)
  # phab.scores$PCT_SAFN_score[which(phab.scores$PCT_SAFN_score>1)]<-1
  # phab.scores$PCT_SAFN_score[which(phab.scores$PCT_SAFN_score<0)]<-0
  
  #PCT_SAFN + PCT_RC, if desired
  phab.scores$PCT_SAFN_score<-  ((phab.scores$PCT_SAFN + phab.scores$PCT_RC -phab.scores$PCT_SAFN_pred) - 63.1)/((-16.4)  - 63.1)
  phab.scores$PCT_SAFN_score[which(phab.scores$PCT_SAFN_score>1)]<-1
  phab.scores$PCT_SAFN_score[which(phab.scores$PCT_SAFN_score<0)]<-0
  
  #XCMG: Modeled, decreaser
  phab.scores$XCMG_pred<-  predict(XCMG, newdata = preds)
  phab.scores$XCMG_score<-  ((phab.scores$XCMG-phab.scores$XCMG_pred) - (-128.5))/(43.6  - (-128.5))
  phab.scores$XCMG_score[which(phab.scores$XCMG_score>1)]<-1
  phab.scores$XCMG_score[which(phab.scores$XCMG_score<0)]<-0
  
  #H_AqHab: Modeled, decreaser
  phab.scores$H_AqHab_pred<-  predict(H_AqHab, newdata = preds)
  phab.scores$H_AqHab_score<-  ((phab.scores$H_AqHab-phab.scores$H_AqHab_pred) - (-1.38))/(0.44  - (-1.38))
  phab.scores$H_AqHab_score[which(phab.scores$H_AqHab_score>1)]<-1
  phab.scores$H_AqHab_score[which(phab.scores$H_AqHab_score<0)]<-0
  
  #Calculate overall index
  phab.scores$IPI_raw<-  rowMeans(phab.scores[,c("Ev_FlowHab_score","H_SubNat_score","PCT_SAFN_score","XCMG_score","XCMG_score","H_AqHab_score")])
  phab.scores$IPI<-phab.scores$IPI_raw/0.761
  phab.scores$IPI_percentile<-round(pnorm(q=phab.scores$IPI, mean=1, sd=0.123),2)
  
  # round results to two decimals
  phab.scores <- phab.scores %>% 
    gather('var', 'val', -StationCode, -SampleDate, -PHAB_SampleID) %>% 
    mutate(val = round(val, 2)) %>% 
    spread(var, val)

  #Combine metrics and qa in a single report, with columns in a better order
  report<- phab.scores[,c("StationCode","SampleDate","PHAB_SampleID",
                          "IPI","IPI_percentile",
                          "Ev_FlowHab","Ev_FlowHab_score",
                          "H_AqHab","H_AqHab_pred","H_AqHab_score",
                          "H_SubNat","H_SubNat_score",
                          "PCT_SAFN","PCT_RC", "PCT_SAFN_pred","PCT_SAFN_score",
                          "XCMG","XCMG_pred","XCMG_score")]
  
  #Calculate the QA for each metric
  if(qa){
    
    phab.qa2<-
      ddply(phab, ~PHAB_SampleID, summarize,
            Ev_FlowHab_qa=round(mean(Count_Calc[which(Variable=="PCT_POOL")])/10,2),
            H_AqHab_qa=round(mean(Count_Calc[which(Variable=="XFC_ALG")])/11,2),
            H_SubNat_qa=round(mean(Count_Calc[which(Variable=="PCT_SA")])/105,2),
            PCT_SAFN_qa=round(mean(Count_Calc[which(Variable=="PCT_SA")])/105,2),
            XCMG_qa=round(mean(Count_Calc[which(Variable=="XC")])/22,2)
            # XWD_RAT_qa=round(mean(Count_Calc[which(Variable=="XWIDTH")])/21,2)
      )
    
    #Report the "worst" qa as the overall qa for the index.
    phab.qa2$IPI_qa<-apply(phab.qa2[,2:6], 1, min)
    
    # arrange columns, add to output
    phab.qa2 <- phab.qa2[, c('PHAB_SampleID', 'IPI_qa', 'Ev_FlowHab_qa', 'H_AqHab_qa', 'H_SubNat_qa', 'PCT_SAFN_qa', 'XCMG_qa')]
    report<-suppressMessages(join(report, phab.qa2))
    
  }

  return(report)

}
