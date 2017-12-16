---
output:
  html_document:
    keep_md: yes
    toc: no
    self_contained: no
---
## PHAB

#### *Marcus W. Beck, marcusb@sccwrp.org, Raphael Mazor, raphaelm@sccwrp.org*

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCCWRP/PHAB?branch=master&svg=true)](https://ci.appveyor.com/project/SCCWRP/PHAB)
[![Travis-CI Build Status](https://travis-ci.org/SCCWRP/PHAB.svg?branch=master)](https://travis-ci.org/SCCWRP/PHAB)
[![DOI](https://zenodo.org/badge/108920024.svg)](https://zenodo.org/badge/latestdoi/108920024)

This package contains materials to calculate scores of physical habitat integrity, or PHAB, for California streams. 

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

Error checks are used to verify correct formatting of the input data.  The following checks are made:

* No duplicate station codes in `stations`
* All station codes in `stations` are in `phab` and the converse
* All required fields in `stations` and `phab`
* All required PHAB variables are present in the `variable` field of `phab` for each station and sample date
* No duplicate results for PHAB variables at each station and sample date
* All input variables for `stations` and `phab` are non-negative. The variables `XBKF_W`, `H_Aq_Hab`, `Ev_FlowHab`, and `H_SubNat` in `phab` must also be greater than zero.

The `chkinp` function can be used independently to check formatting of the input data.  The function will return an error if the data are formatted incorrectly. 

```r
stations$StationCode[1] <- stations$StationCode[2]
chkinp(stations, phab)
```

```
## Error: 
## 
## remove duplicated stations: 205PS0157
## 
## station 105PS0107 from phab not in stations
```

```r
data(stations)
phab <- subset(phab, !phab$Variable %in% 'XSLOPE')
chkinp(stations, phab)
```

```
## Error: 
## 
## Required PHAB variables not present:
## 
## 105PS0107, 9/14/2009:  XSLOPE
## 205PS0157, 6/19/2012:  XSLOPE
## 305PS0057, 6/16/2009:  XSLOPE
## 504PS0147, 6/23/2008:  XSLOPE
## 632PS0007, 7/23/2008:  XSLOPE
## 901PS0057, 5/14/2008:  XSLOPE
```

