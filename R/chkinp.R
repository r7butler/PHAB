#' Check input data for IPI
#'
#' Check input data for IPI
#' 
#' @param stations \code{data.frame} of input station data
#' @param phab \code{data.frame} of input physical habitat data
#' @param qa logical value passed from \code{\link{IPI}} to suppress error checks on relevant metrics
#' @param allerr logical indicating if all errors are returned or the first encountered
#' 
#' @return An error message is returned if the input data are not correctly formatted. If a dataset has multiple errors, only the first is returned.
#' 
#' @importFrom dplyr filter group_by mutate select
#' @importFrom magrittr "%>%"
#' @importFrom tidyr gather nest
#' @importFrom purrr map
#' 
#' @details 
#' This function checks the following:
#' \describe{
#' \item{}{No duplicate station rows in \code{\link{stations}}}
#' \item{}{All stations in \code{\link{stations}} are in \code{\link{phab}} and the converse}
#' \item{}{All required fields in \code{\link{stations}} and \code{\link{phab}}}
#' \item{}{All required PHAB variables are present in the \code{variable} field of \code{\link{phab}} for each station and sample date}
#' \item{}{No duplicate results for PHAB variables at each station and sample date}
#' \item{}{All input variables for \code{\link{stations}} and \code{\link{phab}} are non-negative. The variables \code{XBKF_W}, \code{H_Aq_Hab}, \code{Ev_FlowHab}, and \code{H_SubNat} in \code{\link{phab}} must also be greater than zero.}
#' }
#' 
#' @export
#'
#' @examples
#' chkinp(stations, phab)
chkinp <- function(stations, phab, qa = TRUE, allerr = TRUE){

  errs <- list()
  
  ##
  # duplicated stations
  
  chk <- duplicated(stations$StationCode)
  if(any(chk)){
    
    dups <- paste(stations$StationCode[chk], collapse = ', ')
    msg <- paste0('remove duplicated stations: ', dups)
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check that stations in stations match stations in phab
  
  chk <- setdiff(stations$StationCode, phab$StationCode)
  if(length(chk) > 0){
    
    msg <- paste0('station ', paste(chk, collapse = ', '), ' from stations not in phab')
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
  
  }
  
  ##
  # check that stations in phab match stations in stations
  
  chk <- setdiff(phab$StationCode, stations$StationCode)
  if(length(chk) > 0){ 
    
    msg <- paste0('station ', paste(chk, collapse = ', '), ' from phab not in stations')
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check station fields are present
  
  stafld <- c('ProjectName', 'StationCode', 'MAX_ELEV', 'AREA_SQKM', 'ELEV_RANGE', 'MEANP_WS', 'New_Long', 
              'SITE_ELEV', 'KFCT_AVE', 'New_Lat', 'MINP_WS', 'PPT_00_09')
  chk <- stafld %in% names(stations)
  if(any(!chk)){
    
    msg <- paste0('Required fields not present in stations: ', paste(stafld[!chk], collapse = ', '))
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check phab fields are present
  
  phafld <- c('ProjectName', 'StationCode', 'SampleDate', 'Variable', 'Result', 'Count_Calc')
  chk <- phafld %in% names(phab)
  if(any(!chk)){
    
    msg <- paste0('Required fields not present in phab: ', paste(phafld[!chk], collapse = ', '))
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }

  ##
  # check if phab variables present, need to return sample and date with missing vars
  
  phavar <- c('XSLOPE', 'XBKF_W', 'H_AqHab', 'PCT_SAFN', 'XCMG', 'Ev_FlowHab', 'H_SubNat', 'XC', 'PCT_POOL', 'XFC_ALG', 'PCT_SA', 'PCT_RC')
  chk <- phab %>% 
    select(StationCode, SampleDate, Variable) %>% 
    unique %>% 
    group_by(StationCode, SampleDate) %>%
    nest %>% 
    mutate(
      misvar = map(data, ~ phavar[phavar %in% .x$Variable]),
      misvar = map(misvar, ~ setdiff(phavar, .x))
    ) %>% 
    filter(map(misvar, ~ length(.x) > 0) %>% unlist)
  
  if(nrow(chk) > 0){
    
    stadts <- paste0(chk$StationCode, ', ', chk$SampleDate, ': ') 
    misvar <- map(chk$misvar, ~ paste(.x, collapse = ', ')) %>% unlist
    misall <- paste(stadts, misvar) %>% paste(collapse = '\n')
    
    msg <- paste0('Required PHAB variables not present:\n\n', misall)
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check for duplicate phab variables by station, sample date
  
  chk <- phab %>% 
    select(StationCode, SampleDate, Variable) %>% 
    unique %>% 
    group_by(StationCode, SampleDate) %>%
    nest %>% 
    mutate(
      dupvar = map(data, ~ .x$Variable[duplicated(.x$Variable)])
    ) %>% 
    filter(map(dupvar, ~ length(.x) > 0) %>% unlist)
  
  if(nrow(chk) > 0){
    
    stadts <- paste0(chk$StationCode, ', ', chk$SampleDate, ': ') 
    dupvar <- map(chk$dupvar, ~ paste(.x, collapse = ', ')) %>% unlist
    dupall <- paste(stadts, dupvar) %>% paste(collapse = '\n\n')

    msg <- paste0('Duplicate PHAB variables are present:\n\n', dupall)
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)

  }
  
  ##
  # check for negative values in station fields
  chk <- stations[, stafld] %>%
    select(-ProjectName, -StationCode, -New_Long) %>% 
    gather('var', 'val') %>% 
    group_by(var) %>% 
    filter(val < 0) %>% 
    .$var %>% 
    unique
    
  if(length(chk) > 0){
  
    msg <- paste0('Negative values for station variables: ', paste(chk, collapse = ', '))
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check for negative values in phab
  
  # use full phab variables if t, otherwise remove some
  if(qa) selphab <- phavar
  else selphab <- phavar[!phavar %in% c('PCT_POOL', 'PCT_SA', 'XC', 'XFC_ALG')]
    
  chk <- phab %>% 
    select(Variable, Result) %>% 
    unique %>% 
    filter(Variable %in% selphab) %>% 
    group_by(Variable) %>% 
    filter(Result < 0) %>% 
    .$Variable %>% 
    unique
  
  if(length(chk) > 0){
    
    msg <- paste0('Negative values for phab variables: ', paste(chk, collapse = ', '))
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }
  
  ##
  # check for zero values in phab variables XBKF_W, H_Aq_Hab, Ev_FlowHab, and H_SubNat
  chk <- phab %>% 
    select(Variable, Result) %>% 
    unique %>% 
    filter(Variable %in% c('XBKF_W', 'H_Aq_Hab', 'Ev_FlowHab', 'H_SubNat')) %>% 
    group_by(Variable) %>% 
    filter(Result == 0) %>% 
    .$Variable %>% 
    unique
  
  if(length(chk) > 0){
    
    msg <- paste0('Values for phab variables include zero: ', paste(chk, collapse = ', '))
    errs <- c(errs, msg)
    
    if(!allerr)
      stop(msg, call. = FALSE)
    
  }

  # format errors and stop if any
  if(length(errs) > 0){
    
    errs <- do.call('c', errs) %>% 
      paste(collapse = '\n\n') %>% 
      paste0('\n\n', .)
    stop(errs, call. = FALSE)
    
  }
  
  return()
  
}