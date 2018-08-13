######
#' Calibration data
#'
#' Calibration data used to establish scoring limits for metrics
#'  
#' @format A \code{\link{data.frame}} of PHAB variables at reference and stressed sites used to estimate scoring limits
#' \describe{
#'   \item{\code{Variable}}{chr} name of the PHAB metric
#'   \item{\code{StationCode}}{chr} unique station identifier 
#'   \item{\code{SampleID2}}{chr} unique identifier of the sampling event
#'   \item{\code{SiteSet}}{chr} indicating reference or stressed site
#'   \item{\code{Result}}{num} resulting metric value
#'   \item{\code{Predicted}}{num} predicted metric value
#' }
#' 
#' @examples 
#' data(refcal)
"refcal"