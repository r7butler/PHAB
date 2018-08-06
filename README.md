---
output:
  html_document:
    keep_md: yes
    toc: no
    self_contained: no
---
# PHAB

#### *Marcus W. Beck, marcusb@sccwrp.org, Raphael D. Mazor, raphaelm@sccwrp.org, Andrew C. Rehn, andy.rehn@wildlife.ca.gov*

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCCWRP/PHAB?branch=master&svg=true)](https://ci.appveyor.com/project/SCCWRP/PHAB)
[![Travis-CI Build Status](https://travis-ci.org/SCCWRP/PHAB.svg?branch=master)](https://travis-ci.org/SCCWRP/PHAB)
[![DOI](https://zenodo.org/badge/108920024.svg)](https://zenodo.org/badge/latestdoi/108920024)

The PHAB package contains materials to calculate an index of physical integrity (IPI) for California streams. This index is estimated using site-specific data and available metrics of physical habitat to describe overall integrity.  

This tutorial assumes that the user is familiar with basic operations in the R programming language, such as data import, export, and manipulation. Although not required, we recommend using an integrated development environment for R, such as R-studio, which can be downloaded at [http://www.rstudio.com](http://www.rstudio.com). New users are encouraged to pursue training opportunities, such as those hosted by local R user groups. A list of such groups may be found here: http://blog.revolutionanalytics.com/local-r-groups.html. R training material developed by SCCWRP can also be found online: [https://sccwrp.github.io/SCCWRP_R_training/](https://sccwrp.github.io/SCCWRP_R_training/)

## Installation and basic usage

Install the package as follows:


```r
install.packages('devtools')
library(devtools)
install_github('SCCWRP/PHAB')
library(PHAB)
```

The core function is `IPI` that requires station and phab data as input.



```r
IPI(stations, phab)
```

```
##   StationCode SampleDate       PHAB_SampleID  IPI IPI_percentile
## 1   105PS0107  9/14/2009 105PS0107_9/14/2009 1.16           0.90
## 2   205PS0157  6/19/2012 205PS0157_6/19/2012 1.04           0.62
## 3   305PS0057  6/16/2009 305PS0057_6/16/2009 0.79           0.04
## 4   504PS0147  6/23/2008 504PS0147_6/23/2008 0.78           0.03
## 5   632PS0007  7/23/2008 632PS0007_7/23/2008 1.10           0.79
## 6   901PS0057  5/14/2008 901PS0057_5/14/2008 1.08           0.74
##   Ev_FlowHab Ev_FlowHab_score H_AqHab H_AqHab_pred H_AqHab_score H_SubNat
## 1       0.85             0.89    1.59         1.11          1.00     1.57
## 2       0.96             1.00    1.42         1.35          0.80     1.41
## 3       0.50             0.51    1.32         1.42          0.70     0.49
## 4       0.28             0.28    1.24         1.30          0.72     0.98
## 5       0.90             0.95    1.51         1.41          0.82     1.80
## 6       0.70             0.73    1.52         1.38          0.84     1.80
##   H_SubNat_score PCT_SAFN PCT_RC PCT_SAFN_pred PCT_SAFN_score XCMG
## 1           0.83        6      0         24.60           1.00   99
## 2           0.74       51      2         22.06           0.40  131
## 3           0.26       83      0         29.51           0.12  152
## 4           0.52        1      0         34.38           1.00   55
## 5           0.95       14      0         13.49           0.79  126
## 6           0.95       40      3         34.46           0.69  122
##   XCMG_pred XCMG_score IPI_qa Ev_FlowHab_qa H_AqHab_qa H_SubNat_qa
## 1     93.64       0.78   1.00             1          1           1
## 2    104.72       0.90   1.00             1          1           1
## 3    106.05       1.00   1.00             1          1           1
## 4     95.41       0.51   1.00             1          1           1
## 5    123.10       0.76   1.00             1          1           1
## 6    102.16       0.86   0.95             1          1           1
##   PCT_SAFN_qa XCMG_qa
## 1           1    1.00
## 2           1    1.00
## 3           1    1.00
## 4           1    1.00
## 5           1    1.00
## 6           1    0.95
```

# Detailed usage

The PHAB package can be installed from the R console with just a few lines of code.  The current version of the package can be found on SCCWRP's GitHub page [here](https://github.com/SCCWRP/PHAB) and can be installed using the devtools package.  The devtools package must be installed first before the PHAB package can be installed.  Start by installing and loading devtools:


```r
install.packages('devtools')
library(devtools)
```

Now the `install_github()` function from devtools can be used to install PHAB from GitHub.  The package can be loaded after installation.


```r
install_github('SCCWRP/PHAB')
library(PHAB)
```

The installation process may take a few seconds.  Both the devtools and PHAB packages depend on other R packages, all of which are installed together.  If an error is encountered during installation, an informative message is usually printed in the R console.  This information can help troubleshoot the problem, such as identifying which dependent packages may need to be installed separately by the user.  Please contact SCCWRP staff if additional errors are encountered. 

After the package is successfully installed, you will be able to view the help file for the PHAB core function:


```r
?IPI
```

## Preparing the input data

The `IPI()` function is used to calculate PHAB scores using both station and PHAB metric data as input. These data can be obtained from the state of California SWAMP reporting module.  Sample data are provided with the PHAB package to demonstrate the required format.  These data are loaded automatically once the package is installed and loaded.  You can view the `stations` and `phab` example data from the R console:


```r
head(stations)
```

```
##   StationCode MAX_ELEV  AREA_SQKM ELEV_RANGE MEANP_WS  New_Long SITE_ELEV
## 1   105PS0107     2587 2002.90397    2050.96 882.4179 -123.0173    536.04
## 2   205PS0157     1111  600.95071    1074.00 604.9312 -121.8352     37.00
## 3   305PS0057     1152 1261.70747    1107.36 544.3272 -121.5114     44.64
## 4   504PS0147     2144 1954.62572    2059.52 781.2332 -122.2178     84.48
## 5   632PS0007     3348   98.66497    1240.06 962.0929 -119.5937   2107.94
## 6   901PS0057     1734   92.31964    1671.43 495.7878 -117.6696     62.57
##    KFCT_AVE  New_Lat MINP_WS PPT_00_09
## 1 0.1776000 41.71375 10.9294   54996.9
## 2 0.2927333 37.30141  0.7059   40023.9
## 3 0.2840000 36.95052  0.6623   42432.2
## 4 0.2181000 39.77572  2.7024   53740.0
## 5 0.1217000 38.53335 17.9569   67846.9
## 6 0.2854000 33.52814  0.5268   29440.0
```

```r
head(phab)
```

```
##   StationCode SampleDate      Variable Result Count_Calc
## 1   105PS0107  9/14/2009  W1_HALL_EMAP   0.00         11
## 2   105PS0107  9/14/2009 W1_HALL_SWAMP   0.00         14
## 3   105PS0107  9/14/2009      PCT_CPOM  24.00        105
## 4   105PS0107  9/14/2009      Ev_AqHab   0.77          8
## 5   105PS0107  9/14/2009    Ev_FlowHab   0.85          4
## 6   105PS0107  9/14/2009     Ev_SubNat   0.75          8
```

The `stations` data includes site-specific information that are derived from geospatial analysis. These data are in wide format where one row corresponds to data for one site. The following fields are required:

* `StationCode` unique station identifier (character string)
* `MAX_ELEV` maximum elevation in the watershed in meters (numeric)
* `AREA_SQKM` watershed area in square kilometers (numeric)
* `MEANP_WS` mean phosphorus geology from the watershed (numeric)
* `New_Long` site longitude, decimal degrees (numeric)
* `SITE_ELEV` site elevation (numeric)
* `KFCT_AVE` average soil erodibility factor (numeric)
* `New_Lat` site latitude, decimal degrees (numeric)
* `MINP_WS` minimum phosphorus geology from the watershed (numeric)
* `PPT_00_09` average precipitation (2000 to 2009) at the sample point, in hundredths of millimeters (numeric)

The `phab` data include estimated physical habitat metrics that are compiled along with the station data to get the IPI score. These data are in long format where multiple rows correspond to physical habitat metric values for a single site.  The following fields are required: 

* `StationCode` unique station identifier (character string)
* `SampleDate` date of the sample (character string)
* `Variable` name of the PHAB metric (character string)
* `Result` resulting metric value (numeric)
* `Count_Calc` number of unique observations that were used to estimate the value in `Result` (numeric)

Values in the `Variable` column of the `phab` data indicate which PHAB metric was measured that corresponds to values in the `Result` column.  The required PHAB metrics that should be provided for every site specified by `StationCode` are as follows:

* `XSLOPE` mean slope of reach
* `XBKF_W` mean bankfull width
* `H_AqHab` Shannon Diversity of aquati chabitat types
* `PCT_SAFN` percent substrates smaller than sand (<2 mm)
* `XCMG` riparian cover sum of three layers
* `Ev_FlowHab` evenness of flow habitat types
* `H_SubNat` Shannon Diversity of natural substrate types
* `XC` mean upper canopy trees and saplings
* `PCT_POOL` percent pool of reach
* `XFC_ALG` mean filamentous algae cover
* `PCT_RC` percent concrete/asphalt

Each metric serves a specific purpose in the PHAB package.  The `H_AqHab`, `PCT_SAFN`, `XCMG`, `Ev_FlowHab`, and `H_SubNat` metrics are used to assess habitat condition.  The `XSLOPE`, `XBKF_W`, and `PCT_RC` metrics are used as predictors or score modifiers for different components of the IPI.  Finally, the `XC`, `PCT_POOL`, `XFC_ALG`, and `PCT_RC` metrics provide information that is used for quality assurance checks for select metrics and the overall IPI score.

All required fields for the `stations` and `phab` data are case-sensitive and must be spelled correctly.  The order of the fields does not matter.  All `StationCode` values must be shared between the datasets.  As described below, the `IPI()` function automatically checks the format of the input data prior to estimating scores.

## Using the IPI function

The `IPI()` function can be used on station and PHAB data that are correctly formatted as shown above.  The `stations` and `phab` example data are in the correct format and are loaded automatically with the PHAB package.


```r
IPI(stations, phab)
```

```
##   StationCode SampleDate       PHAB_SampleID  IPI IPI_percentile
## 1   105PS0107  9/14/2009 105PS0107_9/14/2009 1.16           0.90
## 2   205PS0157  6/19/2012 205PS0157_6/19/2012 1.04           0.62
## 3   305PS0057  6/16/2009 305PS0057_6/16/2009 0.79           0.04
## 4   504PS0147  6/23/2008 504PS0147_6/23/2008 0.78           0.03
## 5   632PS0007  7/23/2008 632PS0007_7/23/2008 1.10           0.79
## 6   901PS0057  5/14/2008 901PS0057_5/14/2008 1.08           0.74
##   Ev_FlowHab Ev_FlowHab_score H_AqHab H_AqHab_pred H_AqHab_score H_SubNat
## 1       0.85             0.89    1.59         1.11          1.00     1.57
## 2       0.96             1.00    1.42         1.35          0.80     1.41
## 3       0.50             0.51    1.32         1.42          0.70     0.49
## 4       0.28             0.28    1.24         1.30          0.72     0.98
## 5       0.90             0.95    1.51         1.41          0.82     1.80
## 6       0.70             0.73    1.52         1.38          0.84     1.80
##   H_SubNat_score PCT_SAFN PCT_RC PCT_SAFN_pred PCT_SAFN_score XCMG
## 1           0.83        6      0         24.60           1.00   99
## 2           0.74       51      2         22.06           0.40  131
## 3           0.26       83      0         29.51           0.12  152
## 4           0.52        1      0         34.38           1.00   55
## 5           0.95       14      0         13.49           0.79  126
## 6           0.95       40      3         34.46           0.69  122
##   XCMG_pred XCMG_score IPI_qa Ev_FlowHab_qa H_AqHab_qa H_SubNat_qa
## 1     93.64       0.78   1.00             1          1           1
## 2    104.72       0.90   1.00             1          1           1
## 3    106.05       1.00   1.00             1          1           1
## 4     95.41       0.51   1.00             1          1           1
## 5    123.10       0.76   1.00             1          1           1
## 6    102.16       0.86   0.95             1          1           1
##   PCT_SAFN_qa XCMG_qa
## 1           1    1.00
## 2           1    1.00
## 3           1    1.00
## 4           1    1.00
## 5           1    1.00
## 6           1    0.95
```

A data frame of IPI scores estimated at each site on each unique sample date is returned.  The output data are in wide format with one row for each sample date at a site. Detailed information for each output column is as follows:

* `StationCode` unique station identifier (character string)
* `SampleDate` date of the sample (character string)
* `PHAB_SampleID` unique station identifier and sample date, used if more than one sample was collected at a station (character string)
* `IPI` score for the index of physical integrity (numeric)
* `IPI_percentile` the percentile of the IPI score relative to all other stations (numeric)
* `Ev_FlowHab` evenness of flow habitat types, from the raw PHAB metric
* `Ev_FlowHab_score` IPI score for evenness of flow habitat types
* `H_AqHab` Shannon Diversity of aquatic habitat types, from the raw PHAB metric
* `H_AqHab_pred` predicted Shannon Diversity of aquatic habitat types
* `H_AqHab_score` scored Shannon Diversity of aquatic habitat types
* `H_SubNat` Shannon Diversity of natural substrate types, from the raw PHAB metric
* `H_SubNat_score` scored Shannon Diversity of natural substrate types
* `PCT_SAFN` percent substrates smaller than sand (<2 mm), from the raw PHAB metric
* `PCT_RC` percent concrete/asphalt, from the raw PHAB metric
* `PCT_SAFN_pred` predicted percent substrates smaller than sand (<2 mm)
* `PCT_SAFN_score` scored percent substrates smaller than sand (<2 mm)
* `XCMG` riparian cover as sum of three layers, from the raw PHAB metric
* `XCMG_pred` predicted riparian cover as sum of three layers
* `XCMG_score` scored riparian cover as sum of three layers
* `IPI_qa` quality assurance for score for the index of physical integrity 
* `Ev_FlowHab_qa` quality assurance for evenness of flow habitat types
* `H_AqHab_qa` quality assurance for Shannon Diversity of aquatic habitat types
* `H_SubNat_qa` quality assurance for Shannon Diversityh of natural substrate types
* `PCT_SAFN_qa` quality assurance for percent substrates smaller than sand (<2 mm)
* `XCMG_qa` quality assurance for riparian cover as sum of three layers

Metrics are included in the output as observed PHAB metrics, predicted metrics, and scored metrics.  The observed PHAB metrics are returned as is from the input data.  Some PHAB metrics include a predicted column that shows the modelled metric value based on the observed conditions at a site. Scored PHAB metrics are based on the difference between the observed and predicted scores for metrics with predictions, or estimated from the observed metric using an empirical formula for those without predicted values.  

The last five columns include quality assurance information for the IPI score and select metrics. QA values for metrics less than one indicate less quality assurance.  The QA value for the IPI is based on the lowest score among all metrics.  These columns are included by default and can be removed from the output by using the `qa = FALSE` argument.


```r
IPI(stations, phab, qa = FALSE)
```

## Error checks for input data

The `IPI()` function will evaluate both the `stations` and `phab` input datasets for the correct format before estimating IPI scores.  The scores will not be calculated if any errors are encountered.  The following checks are made:

* No duplicate station codes in `stations`
* All station codes in `stations` are in `phab` and the converse
* All required fields are present in `stations` and `phab`, see above
* All required PHAB variables are present in the `variable` field of `phab` for each station and sample date
* No duplicate results for PHAB variables at each station and sample date
* All input variables for `stations` and `phab` are non-negative. The variables `XBKF_W`, `H_Aq_Hab`, `Ev_FlowHab`, and `H_SubNat` in `phab` must also be greater than zero.

The `IPI()` function will print informative messages to the R console if any of these errors are encountered.  It is the responsibility of the analyst to correct any errors in the raw data before proceeding.  

