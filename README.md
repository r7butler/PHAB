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

# Installation

Install the package as follows:


```r
install.packages('devtools')
library(devtools)
install_github('SCCWRP/PHAB')
library(PHAB)
```

# Basic usage

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

The installation process may take a few seconds.  Both the devtools and PHAB packages depend on other R packages, all of which are installed together.  If an error is encountered during installation, an informative message is usually printed in the R console.  This information can help troubleshoot the problem, such as identifying which dependent packages may need to be installed separately.  Please contact SCCWRP staff if additional errors are encountered. 

After the package is successfully installed, you will be able to view the help file for the PHAB core function:


```r
?IPI
```

## Preparing the input data

The IPI is estimated using station and PHAB metric data as input. These data can be obtained from the state of California SWAMP reporting module.  Sample data are provided with the PHAB package to demonstrate the required format.  These data are loaded automatically once the package is installed and loaded.  You can view the `stations` and `phab` example data from the R console:


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

* `StationCode` unique station identifier
* `MAX_ELEV` maximum elevation in the watershed in meters
* `AREA_SQKM` watershed area in square kilometers
* `MEANP_WS` mean phosphorus geology from the watershed
* `New_Long` site longitude, decimal degrees
* `SITE_ELEV` site elevation
* `KFCT_AVE` average soil erodibility factor
* `New_Lat` site latitude, decimal degrees
* `MINP_WS` minimum phosphorus geology from the watershed
* `PPT_00_09` average precipitation (2000 to 2009) at the sample point, in hundredths of millimeters

The `phab` data include estimated physical habitat metrics that are compiled along with the `stations` data to get the IPI score. These data are in long format where multiple rows correspond to physical habitat metric values for a single site.  The following fields are required: 

* `StationCode` unique station identifier
* `SampleDate` date of the sample
* `Variable` name of the PHAB metric
* `Result` resulting metric value
* `Count_Calc` number of unique observations that were used to estimate the value in `Result` 

Values in the `Variable` column of the `phab` data indicate which PHAB metric was measured that corresponds to values in the `Result` column.  The required PHAB metrics that should be provided for every site specified by `StationCode` are as follows:

* `XSLOPE` mean slope of reach
* `XBKF_W` mean bankfull width
* `H_AqHab` Shannon diversity of aquatic habitat types
* `PCT_SAFN` percent substrate particles smaller than sand (<2 mm)
* `XCMG` riparian cover sum of three layers
* `Ev_FlowHab` evenness of flow habitat types
* `H_SubNat` Shannon diversity of natural substrate types
* `XC` mean upper canopy trees and saplings
* `PCT_POOL` percent pools in reach
* `XFC_ALG` mean filamentous algae cover
* `PCT_RC` percent concrete/asphalt

Each metric serves a specific purpose in the PHAB package.  The `H_AqHab`, `PCT_SAFN`, `XCMG`, `Ev_FlowHab`, and `H_SubNat` metrics are used to assess habitat condition.  The `XSLOPE`, `XBKF_W`, and `PCT_RC` metrics are used as predictors or score modifiers for different components of the IPI.  Finally, the `XC`, `PCT_POOL`, `XFC_ALG`, and `PCT_RC` metrics provide information that is used for quality assurance checks for selected metrics and the overall IPI score.

All required fields for the `stations` and `phab` data are case-sensitive and must be spelled correctly.  The order of the fields does not matter.  All `StationCode` values must be shared between the datasets.  As described below, the `IPI()` function automatically checks the format of the input data prior to estimating scores.

## Detailed metric descriptions

Five of the required PHAB metrics in the input data are used directly for scoring the IPI, whereas the remainder serve a supporting role as predictors or modifiers for different parts of the complete index.  Understanding what each of five core metrics describe about stream condition and how they vary with disturbance is critical for interpreting the index.  Below is a detailed description of each metric. 

*Diversity of aquatic habitats* `H_AqHab` measures the relative quantity and variety of natural structures in the stream, such as cobble, large and small boulders, fallen trees, logs and branches, and undercut banks, available as refugia, feeding, or sites for spawning and nursery functions of aquatic macrofauna. A wide variety and/or abundance of submerged structures in the stream provides macroinvertebrates and fish with a large number of niches, thus increasing habitat diversity. When variety and abundance of cover decreases (e.g., due to hydromodification, increased sedimentation, or active stream clearing), habitat structure becomes monotonous, diversity decreases, and the potential for recovery following disturbance decreases. Snags and submerged logs—especially old logs that have remained in-place for several years--are among the most productive habitat structure for macroinvertebrate colonization and fish refugia in low-gradient streams. 

*Percent sands and fines* `PCT_SAFN` measures the amount of small-grained sediment particles (i.e., <2 mm) that have accumulated in the stream bottom as a result of deposition. Deposition may result from soil disturbance in the catchment, landslides, and upstream bank erosion. Sediment deposition may cause the formation of islands or point bars, filling of runs and pools, and embeddedness of gravel, cobble, and boulders and snags, with larger substrate particles covered or sunken into the silt, sand, or mud of the stream bottom.  As habitat provided by cobbles or woody debris become embedded, and as interstitial spaces become inundated by sand or silt, the surface area available to macroinvertebrates and fish is decreased. High levels of sediment deposition are symptoms of an unstable and continually changing environment that becomes unsuitable for many organisms. Although human activity may deplete sands and fines (e.g., by upstream dam operations), and this depletion may harm aquatic life, the IPI only recognizes increases in this metric as a negative impact on habitat quality. Additionally, because channel armoring may lead to similar reductions in available habitat, the IPI includes concrete cover when evaluating this metric.

*Diversity of natural substrate types* `H_SubNat` measures the diversity of natural substrate types, assessing how well multiple size classes (e.g., gravel, cobble and boulder particles) are represented. In a stream with high habitat quality for benthic macroinvertebrates, layers of cobble and gravel provide diversity of niche space. Occasional patches of fine sediment, root mats and bedrock also provide important habitat for burrowers or clingers, but do not dominate the streambed. Lack of substrate diversity, e.g., where >75% of the channel bottom is dominated by one particle size or hard-pan, or with highly compacted particles with no interstitial space, represent poor physical conditions. Riffles and runs with a diversity of particle sizes often provide the most stable habitat in many small, high-gradient streams. 

*Evenness of flow microhabitats* `Ev_FlowHab` measures the evenness of riffles, pools, and other flow microhabitat types.  Optimal physical conditions include a relatively even mix of velocity/depth regimes, with regular alternation between riffles (fast-shallow), runs (fast-deep), glides (slow-shallow) and pools (slow-deep). Poor conditions occur when microhabitat dominates (usually glides, with pools and riffles absent). A stream that has a uniform flow regime will typically support far fewer types of organisms than a stream that has a variety of alternating flow regimes. Riffles in particular are a source of high-quality habitat and diverse fauna, and their regular occurrence along the length of a stream greatly enhances the diversity of the stream community. Pools are essential for many fish and amphibians.

*Riparian vegetation cover* `XCMG` measures the amount of vegetative protection afforded to the stream bank and the near-stream portion of the riparian zone. The root systems of plants growing on stream banks help hold soil in place, thereby reducing the amount of erosion likely to occur. The vegetative zone also serves as a buffer to pollutants entering a stream from runoff and provides shading and habitat and nutrient input into the stream. Banks that have full, multi-layered, natural plant growth are better for fish and macroinvertebrates than are banks without vegetative protection or those shored up with concrete or riprap.  Vegetative removal and reduced riparian zones occur when roads, parking lots, fields, lawns, bare soil, riprap, or buildings are near the stream bank. Residential developments, urban centers, golf courses, and high grazing pressure from livestock are the common causes of anthropogenic degradation of the riparian zone. Even within protected areas, upstream hydromodification and invasion by non-native species can reduce the cover and quality of riparian zone vegetation.

## Using the IPI function

The IPI score for a site is estimated from the station and PHAB data.  The score is estimated automatically by the `IPI()` function in the package following several steps.  First, reference expectations for a site are estimated for predictive metrics using the station data.  Then, the observed data are compared to the reference expectations for the predictive metrics or to the mean values observed at reference sites for metrics that aren't predicted.  Metric scores are based on the deviations from those observed at reference and high-activity sites.  The metric scores are then summed and standardized by the reference means to obtain the final IPI score.

The `IPI()` function can be used on station and PHAB data that are correctly formatted as shown above.  The `stations` and `phab` example data are in the correct format and are loaded automatically with the PHAB package.  These data are used here to demonstrate use of the `IPI()` function.


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

* `StationCode` unique station identifier 
* `SampleDate` date of the site visit
* `PHAB_SampleID` unique identifier of the sampling event.  Typically, the station code and sample data are sufficient to determine unique sampling events.
* `IPI` score for the index of physical integrity 
* `IPI_percentile` the percentile of the IPI score relative to scores at reference sites
* `Ev_FlowHab` evenness of flow habitat types, from the raw PHAB metric
* `Ev_FlowHab_score` IPI score for evenness of flow habitat types
* `H_AqHab` Shannon diversity of aquatic habitat types, from the raw PHAB metric
* `H_AqHab_pred` predicted Shannon diversity of aquatic habitat types
* `H_AqHab_score` scored Shannon diversity of aquatic habitat types
* `H_SubNat` Shannon Diversity of natural substrate types, from the raw PHAB metric
* `H_SubNat_score` scored Shannon diversity of natural substrate types
* `PCT_SAFN` percent substrates smaller than sand (<2 mm), from the raw PHAB metric
* `PCT_RC` percent concrete/asphalt, from the raw PHAB metric and is combined with `PCT_SAFN` to provide an overall estimate of substrate
* `PCT_SAFN_pred` predicted percent substrates smaller than sand (<2 mm)
* `PCT_SAFN_score` scored percent substrates smaller than sand (<2 mm), includes substrate from `PCT_RC`
* `XCMG` riparian cover as sum of three layers, from the raw PHAB metric
* `XCMG_pred` predicted riparian cover as sum of three layers
* `XCMG_score` scored riparian cover as sum of three layers
* `IPI_qa` quality assurance for the IPI score
* `Ev_FlowHab_qa` quality assurance for evenness of flow habitat types
* `H_AqHab_qa` quality assurance for Shannon diversity of aquatic habitat types
* `H_SubNat_qa` quality assurance for Shannon diversity of natural substrate types
* `PCT_SAFN_qa` quality assurance for percent substrates smaller than sand (<2 mm)
* `XCMG_qa` quality assurance for riparian cover as sum of three layers

Metrics are included in the output as observed PHAB metrics, predicted metrics, and scored metrics.  The observed PHAB metrics are returned as-is from the input data.  Some PHAB metrics include a predicted column that shows the modelled metric value based on the observed conditions at a site. Scored PHAB metrics are based on the difference between the observed and predicted scores for metrics with predictions, or estimated from the observed metric using an empirical formula for those without predicted values.  

The last five columns include quality assurance information for the IPI score and select metrics. QA values for metrics less than one indicate less quality assurance, usually resulting from less than the recommended locations being used at a sample site to assess a metric.  The QA value for the IPI is based on the lowest score among all metrics.  These columns are included by default and can be removed from the output by using the `qa = FALSE` argument.


```r
IPI(stations, phab, qa = FALSE)
```

## Interpreting IPI scores

Higher IPI scores returned by the `IPI()` function indicate better (i.e., more reference-like) physical habitat integrity at a station.  IPI scores near 1 represent locations with conditions similar to reference sites.  All metric scores are weighted equally to determine the overall IPI score.  The individual scored PHAB metrics vary from zero to one, with values closer to one indicating conditions that are likely to represent intact physical habitat.  For the observed PHAB metrics, all are expected to decrease under degraded physical conditions, except PCT_SAFN which is expected to increase. 

## Calibration data

An additional data file is available from the PHAB package that shows calibration data for scoring the IPI metrics.  This file is called `refcal` and includes observed and predicted scores at reference and stressed sites for the five PHAB metrics.  Metrics are scored based on deviation from the 5th and 95th percentile of scores at reference or calibration sites.  The `refcal` dataset includes observations at these sites that were used to identify the percentile cutoffs for estimating metric scores.


```r
head(refcal)
```

```
##     Variable StationCode      SampleID2   SiteSet Result Predicted
## 1 Ev_FlowHab   000CAT228 000CAT22840400    RefCal   0.77 0.6498149
## 2 Ev_FlowHab   101WE1111 101WE111137474 StressCal   0.94 0.6535123
## 3 Ev_FlowHab   103CDCHHR 103CDCHHR40435    RefCal   0.63 0.7295132
## 4 Ev_FlowHab   103WER026 103WER02637831    RefCal   0.75 0.6590854
## 5 Ev_FlowHab   103WER029 103WER02937832    RefCal   0.94 0.7125525
## 6 Ev_FlowHab   105BVCAGC 105BVCAGC40442    RefCal   0.84 0.6973526
```

* `Variable` name of the PHAB metric
* `StationCode` unique station identifier
* `SampleIDs`  unique identifier of the sampling event
* `SiteSet` indicating if a site was refernece or stressed
* `Result` resulting metric value
* `Predicted` predicted metric value

## Error checks for input data

The `IPI()` function will evaluate both the `stations` and `phab` input datasets for the correct format before estimating IPI scores.  The scores will not be calculated if any errors are encountered.  The following checks are made:

* No duplicate station codes in `stations`. That is, input data have one row per station.
* All station codes in `stations` are in `phab`, and vice-versa
* All required fields are present in `stations` and `phab` (see above)
* All required PHAB metrics are present in the `variable` field of `phab` for each station and sample date (see above)
* No duplicate results for PHAB variables at each station and sample date.  That is, one row per station, date, and metric.
* All input variables for `stations` and `phab` are non-negative.  Moreover, the variables `XBKF_W`, `H_Aq_Hab`, `Ev_FlowHab`, and `H_SubNat` in `phab` must also be greater than zero.

The `IPI()` function will print informative messages to the R console if any of these errors are encountered.  It is the responsibility of the analyst to correct any errors in the raw data before proceeding.  

