## PHAB

#### *Marcus W. Beck, marcusb@sccwrp.org, Raphael Mazor, raphaelm@sccwrp.org*

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCCWRP/PHAB?branch=master&svg=true)](https://ci.appveyor.com/project/SCCWRP/PHAB)
[![Travis-CI Build Status](https://travis-ci.org/SCCWRP/PHAB.svg?branch=master)](https://travis-ci.org/SCCWRP/PHAB)
[![DOI](https://zenodo.org/badge/108920024.svg)](https://zenodo.org/badge/latestdoi/108920024)

This package contains materials to calculates scores of physical habitat integrity, or PHAB, for California streams. 

### Installation

Install the package as follows:


```r
install.packages('devtools')
library(devtools)
install_github('SCCWRP/PHAB')
library(PHAB)
```

### Usage

The core function is `IPI` that requires station and phab data as input.



```r
IPI(stations, phab)
```

```
##   StationCode SampleDate       PHAB_SampleID       IPI IPI_percentile
## 1   105PS0107  9/14/2009 105PS0107_9/14/2009 1.1550124           0.90
## 2   205PS0157  6/19/2012 205PS0157_6/19/2012 1.0385380           0.62
## 3   305PS0057  6/16/2009 305PS0057_6/16/2009 0.7874925           0.04
## 4   504PS0147  6/23/2008 504PS0147_6/23/2008 0.7751553           0.03
## 5   632PS0007  7/23/2008 632PS0007_7/23/2008 1.1002041           0.79
## 6   901PS0057  5/14/2008 901PS0057_5/14/2008 1.0784681           0.74
##   Ev_FlowHab Ev_FlowHab_score H_AqHab H_AqHab_pred H_AqHab_score H_SubNat
## 1       0.85        0.8918919    1.59     1.105924     1.0000000     1.57
## 2       0.96        1.0000000    1.42     1.350044     0.7966793     1.41
## 3       0.50        0.5135135    1.32     1.419722     0.7034496     0.49
## 4       0.28        0.2756757    1.24     1.301968     0.7241932     0.98
## 5       0.90        0.9459459    1.51     1.405082     0.8158890     1.80
## 6       0.70        0.7297297    1.52     1.376621     0.8370212     1.80
##   H_SubNat_score PCT_SAFN PCT_RC PCT_SAFN_pred PCT_SAFN_score XCMG
## 1      0.8263158        6      0      24.60357      1.0000000   99
## 2      0.7421053       51      2      22.05900      0.4045157  131
## 3      0.2578947       83      0      29.50620      0.1208327  152
## 4      0.5157895        1      0      34.38157      1.0000000   55
## 5      0.9473684       14      0      13.49353      0.7873400  126
## 6      0.9473684       40      3      34.46130      0.6863057  122
##   XCMG_pred XCMG_score Ev_FlowHab_qa H_AqHab_qa H_SubNat_qa PCT_SAFN_qa
## 1  93.64243  0.7777895             1          1           1           1
## 2 104.72493  0.8993322             1          1           1           1
## 3 106.04933  1.0000000             1          1           1           1
## 4  95.41057  0.5118503             1          1           1           1
## 5 123.10263  0.7634943             1          1           1           1
## 6 102.16183  0.8619301             1          1           1           1
##   XCMG_qa IPI_qa
## 1    1.00   1.00
## 2    1.00   1.00
## 3    1.00   1.00
## 4    1.00   1.00
## 5    1.00   1.00
## 6    0.95   0.95
```

