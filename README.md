---
output:
  html_document:
    keep_md: yes
    toc: no
    self_contained: no
---
# PHAB

#### *Marcus W. Beck, marcusb@sccwrp.org, Raphael Mazor, raphaelm@sccwrp.org*

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/SCCWRP/PHAB?branch=master&svg=true)](https://ci.appveyor.com/project/SCCWRP/PHAB)
[![Travis-CI Build Status](https://travis-ci.org/SCCWRP/PHAB.svg?branch=master)](https://travis-ci.org/SCCWRP/PHAB)
[![DOI](https://zenodo.org/badge/108920024.svg)](https://zenodo.org/badge/latestdoi/108920024)

The PHAB package contains materials to calculate scores of physical habitat integrity for California streams. 

This tutorial assumes that the user is familiar with basic operations in the R programming language, such as data import, export, and manipulation. Although not required, we recommend using graphic interface for R, such as R-studio, which can be downloaded at [http://www.rstudio.com](http://www.rstudio.com). New users are encouraged to pursue training opportunities, such as those hosted by local R user groups. A list of such groups may be found here: http://blog.revolutionanalytics.com/local-r-groups.html. R training material developed by SCCWRP can also be found online: [https://sccwrp.github.io/SCCWRP_R_training/](https://sccwrp.github.io/SCCWRP_R_training/)

# Short version

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

Now the `install_github()` function can be used to install PHAB from GitHub.  The package can be loaded after it's installed.


```r
install_github('SCCWRP/PHAB')
library(PHAB)
```

The installation process may take a few seconds.  Both the devtools and PHAB packages depend on other R packages, all of which are installed together.  If an error is encountered during installation, an informative message is usually printed in the R console.  This information can help troubleshoot the problem.  Please contact SCCWRP staff if additional errors are encountered. 

After the package is successfully installed, you should be able to view the help file for the PHAB core function:

```r
?IPI
```

## Preparing the input data

The `IPI()` function is used to calculate PHAB scores using both station and PHAB metric data as input.  The input data must follow a particular format and sample data are provided with the PHAB package as a demonstration.  These data are loaded automatically once the package is installed and loaded.  You can view the `stations` and `phab` input data from the R console:


```r
head(stations)
```

```
##                                   ProjectName StationCode
## 1 Statewide Perennial Streams Assessment 2009   105PS0107
## 2 Statewide Perennial Streams Assessment 2012   205PS0157
## 3 Statewide Perennial Streams Assessment 2009   305PS0057
## 4 Statewide Perennial Streams Assessment 2008   504PS0147
## 5 Statewide Perennial Streams Assessment 2008   632PS0007
## 6 Statewide Perennial Streams Assessment 2008   901PS0057
##                         StationName           GIS_source_file
## 1 Scott River below Big Ferry Creek Original CSCI development
## 2 Coyote Creek ~1mi above Tully Rd.                   Round 4
## 3  Pajaro River above Millers Canal        All Sites Screened
## 4                       Stony Creek Original CSCI development
## 5                 Silver King Creek Original CSCI development
## 6                 Arroyo Trabuco 57 Original CSCI development
##                                  Compilation_file StationCode.1
## 1                               sample.data.4.csv     105PS0107
## 2 CSCI scores stragglers with ancillary data pt 3     205PS0157
## 3 CSCI scores stragglers with ancillary data pt 3     305PS0057
## 4                               sample.data.4.csv     504PS0147
## 5                               sample.data.4.csv     632PS0007
## 6                               sample.data.4.csv     901PS0057
##                                          SampleID   BugCode SampleDate
## 1 105PS0107_105PS0107_9/14/2009 0:00:00_BMI_RWB_1 105PS0107  9/14/2009
## 2                          205PS015741079BMI_RWB1 205PS0157  6/19/2012
## 3                          305PS005739980BMI_RWB1 305PS0057  6/16/2009
## 4 504PS0147_504PS0147_6/23/2008 0:00:00_BMI_RWB_1 504PS0147  6/23/2008
## 5 632PS0007_632PS0007_7/23/2008 0:00:00_BMI_RWB_1 632PS0007  7/23/2008
## 6 901PS0057_901PS0057_5/14/2008 0:00:00_BMI_RWB_1 901PS0057  5/14/2008
##        SampleID2 CollectionMethodCode Replicate           Invasives Count
## 1 105PS010740070              BMI_RWB         1 NoInvasivesDetected   565
## 2 205PS015741079              BMI_RWB         1                       617
## 3 305PS005739980              BMI_RWB         1            Detected    77
## 4 504PS014739622              BMI_RWB         1 NoInvasivesDetected   576
## 5 632PS000739652              BMI_RWB         1 NoInvasivesDetected   592
## 6 901PS005739582              BMI_RWB         1   InvasivesDetected   600
##   CountOTU PercentUnambiguous SelectedSamples   SiteSet   SiteStatus
## 1      506           89.55752        Selected     Other Intermediate
## 2       NA           99.35170        Selected StressCal     Stressed
## 3       NA          100.00000        Selected StressCal     Stressed
## 4      567           98.43750        Selected     Other Intermediate
## 5      577           97.46622        Selected    RefCal    Reference
## 6      598           99.66667        Selected StressCal     Stressed
##           PSARegion PSA9c_1987 PSA6c PSA9c PSA10c Eco_III_1987
## 1       North_Coast         NC    NC    NC     NC           78
## 2 Coastal_Chaparral       CHco    CH  CHco   CHco            6
## 3 Coastal_Chaparral       CHco    CH  CHco   CHco            6
## 4    Central_Valley         CV    CV    CV     CV            7
## 5  Central_Lahontan       SNcl    SN  SNcl   SNcl            5
## 6               SMC        SCx    SC   SCx    SCx            6
##   Eco_III_2010  New_Lat  New_Long ELEV_RANGE  BDH_AVE PPT_00_09 LPREM_mean
## 1           78 41.71375 -123.0173    2050.96 1.446800   54996.9    -0.4523
## 2            6 37.30141 -121.8352    1074.00 1.476833   40023.9     0.6932
## 3            6 36.95052 -121.5114    1107.36 1.493100   42432.2     0.4078
## 4            7 39.77572 -122.2178    2059.52 1.506500   53740.0    -0.6076
## 5            5 38.53335 -119.5937    1240.06 1.380800   67846.9    -1.2952
## 6           85 33.52814 -117.6696    1671.43 1.556100   29440.0    -0.3549
##    KFCT_AVE TEMP_00_09 P_MEAN N_MEAN  PRMH_AVE  AREA_SQKM SITE_ELEV
## 1 0.1776000     1819.3 0.1380 0.1074  3.576400 2002.90397    536.04
## 2 0.2927333     2205.1 0.1063 0.4719  1.397367  600.95071     37.00
## 3 0.2840000     2297.5 0.1078 0.2742  2.108800 1261.70747     44.64
## 4 0.2181000     2413.1 0.1238 0.0807  2.417300 1954.62572     84.48
## 5 0.1217000     1309.1 0.1947 0.0097 14.059800   98.66497   2107.94
## 6 0.2854000     2410.9 0.1289 0.2413  4.209300   92.31964     62.57
##   MgO_Mean S_Mean  SumAve_P CaO_Mean Ag_2000_1K Ag_2000_5K Ag_2000_WS
## 1   6.7102 0.0671 4645.1465 5.232600     0.0000     0.0000   5.037400
## 2   7.8047 0.2102  466.3624 3.352367     0.0000     0.0000   2.531244
## 3   3.4310 0.3564  404.3616 6.351400    95.1443    83.9646  13.606400
## 4   6.1785 0.0774 1670.4222 7.972300    15.2123    21.5657   0.466900
## 5   2.3847 0.0256 4902.5752 4.802500     0.0000     0.0000   0.000000
## 6   2.5290 0.4422  924.1017 5.186600     0.0000     0.0000   0.000000
##   CODE_21_2000_1K CODE_21_2000_5K CODE_21_2000_WS URBAN_2000_1K
## 1         2.11790         2.91770         3.10100       0.00000
## 2        37.66234        34.72991         4.48666      43.91972
## 3         4.03110         9.23390         7.64020       0.82460
## 4         0.00000         4.13590         2.86920       0.00000
## 5         0.00000         0.00000         0.00000       0.00000
## 6        19.10670        13.51350        10.21350      67.24570
##   URBAN_2000_5K URBAN_2000_WS RoadDens_1K RoadDens_5K RoadDens_WS
## 1       0.00000      0.135000   0.3558888   1.5555033  1.48429236
## 2      48.33159      3.136574   6.1621362   7.0786385  1.02089022
## 3       5.86240      5.688500   0.9038084   1.4301867  1.83907329
## 4       0.18460      0.106000   0.0000000   1.1926224  0.49966828
## 5       0.00000      0.000000   0.7133312   0.2220757  0.05824088
## 6      40.81630     23.522500  14.9276836   7.0464540  4.81730399
##   PAVED_INT_1K PAVED_INT_5K PAVED_INT_WS PerManMade_WS InvDamDist MINES_5K
## 1            1            2          233     1.7471549 0.00000000        1
## 2            2            8          227     9.0758949 0.05121186        1
## 3            0           13          648     2.8675591 0.09823182        0
## 4            0            5          478     0.3072925 0.08920607        0
## 5            0            0            0     0.0000000 0.00000000        0
## 6            1            6          208     0.0000000 0.00000000        1
##   MINES_WS MaxOfCOND MaxOfW1_HALL BPJ_Nonref  UCS_Mean      AtmCa  AtmMg
## 1       36     209.8     0.000000      FALSE 125.63480 0.03100000 0.0088
## 2       NA     704.0     1.870000      FALSE  42.67267 0.04413333 0.0360
## 3       11     178.9     2.830000      FALSE  63.58140 0.04170000 0.0291
## 4       15     289.3     0.090900      FALSE  87.40510 0.03550000 0.0373
## 5        0      68.2     0.000000      FALSE 146.56220 0.07110000 0.0114
## 6        5    1226.0     2.584182      FALSE  78.48770 0.05780000 0.0315
##      AtmSO4 MINP_WS MEANP_WS  TMAX_WS  XWD_WS MAXWD_WS PCT_CENOZ PCT_NOSED
## 1 0.1202000 10.9294 882.4179 283.8185 77.0805  10.8393  0.000000  22.87216
## 2 0.2557333  0.7059 604.9312 298.4064 55.3896   9.4545 49.371470   0.00000
## 3 0.2333000  0.6623 544.3272 303.9424 50.4524   8.7149  0.000000   0.00000
## 4 0.2209000  2.7024 781.2332 329.9459 62.1459  10.0056  7.224442  12.74685
## 5 0.2554000 17.9569 962.0929 205.5086 78.7459  10.3811  0.000000 100.00000
## 6 0.3894000  0.5268 495.7878 311.8571 36.9681   6.4078 19.505383  18.99693
##    PCT_QUART PCT_SEDIM PCT_VOLCNC   MAFLOWU MAX_ELEV NHD_SO   LogWSA
## 1  0.0000000  63.70895    13.4189 847.81728     2587      5 3.301660
## 2 49.3714703  50.62853     0.0000 133.98843     1111      5       NA
## 3  0.0000000 100.00000     0.0000  32.36804     1152      5 3.100959
## 4  0.2346025  87.01855     0.0000   0.88792     2144      6 3.291064
## 5  0.0000000   0.00000     0.0000  51.99282     3348      3 1.994163
## 6  0.0000000  81.00313     0.0000   2.12058     1734      3 1.965294
##   W1_Hall_screening  CondQR01 CondQR50  CondQR99 CondQR99c W1HallPF CondPF
## 1          0.000000 23.000000 138.9318  427.0000  427.0000     Pass   Pass
## 2                NA 36.000000 349.6777 1162.8209        NA     Fail   Pass
## 3          2.830000 46.000000 370.0000 1164.0907 2000.0000                
## 4          0.090900 44.000000 289.0000  638.4604  638.4604     Pass   Pass
## 5          0.000000  9.409028  53.0000  203.1000  203.1000     Pass   Pass
## 6          2.584182 77.000000 429.7632 1161.7191 2000.0000     Fail   Pass
##   AgPF UrbPF AgUrbPF Cd21PF RoadDensPF IntersectionsPF DamsPF ManMadePF
## 1 Fail  Pass    Pass   Pass       Pass            Fail   Pass      Pass
## 2 Pass  Fail    Fail   Fail       Fail            Fail   Pass      Pass
## 3                                                                      
## 4 Fail  Pass    Fail   Pass       Pass            Fail   Pass      Pass
## 5 Pass  Pass    Pass   Pass       Pass            Pass   Pass      Pass
## 6 Pass  Fail    Fail   Fail       Fail            Fail   Pass      Pass
##   MinesPF    O         E    OoverE       MMI      CSCI Year   Round
## 1    Fail 13.0 11.911302 1.0914004 0.6730492 0.8822248 2009 Round 2
## 2    Fail  6.9 10.163244 0.6789171 0.3786630 0.5287900   NA Round 4
## 3          4.0  8.952339 0.4468106 0.5466658 0.4967382   NA Round 2
## 4    Pass  6.0  9.266510 0.6474930 0.5617334 0.6046132 2008 Round 2
## 5    Pass 17.0 13.794428 1.2323816 0.8685904 1.0504860 2008 Round 2
## 6    Fail  8.0  7.621518 1.0496597 0.5050333 0.7773465 2008 Round 2
##   IMPERVMEAN_2000_1k IMPERVMEAN_2000_5k IMPERVMEAN_2000_WS
## 1             0.1010             0.0588             0.2123
## 2            22.5400            26.3672             1.7875
## 3             0.7656             2.8779             3.2616
## 4             0.0000             0.4747             0.1563
## 5             0.0529             0.0207             0.0054
## 6            34.8716            20.2628            12.4542
##   IMPERVMEAN_2006_1k IMPERVMEAN_2006_5k IMPERVMEAN_2006_WS
## 1             0.1006             0.0584             0.2348
## 2            24.7681            27.4615             1.9046
## 3             0.7427             2.9928             3.4476
## 4             0.0000             0.5251             0.1882
## 5             0.0579             0.0207             0.0054
## 6            35.2251            21.4759            12.6735
```

```r
head(phab)
```

```
##   EcoregionCode RWQCB  ProtocolCode
## 1            78     1 SWAMP_2007_WS
## 2            78     1 SWAMP_2007_WS
## 3            78     1 SWAMP_2007_WS
## 4            78     1 SWAMP_2007_WS
## 5            78     1 SWAMP_2007_WS
## 6            78     1 SWAMP_2007_WS
##                                   ProjectName StationCode
## 1 Statewide Perennial Streams Assessment 2009   105PS0107
## 2 Statewide Perennial Streams Assessment 2009   105PS0107
## 3 Statewide Perennial Streams Assessment 2009   105PS0107
## 4 Statewide Perennial Streams Assessment 2009   105PS0107
## 5 Statewide Perennial Streams Assessment 2009   105PS0107
## 6 Statewide Perennial Streams Assessment 2009   105PS0107
##                         StationName TargetLatitude TargetLongitude
## 1 Scott River below Big Ferry Creek       41.71233       -123.0186
## 2 Scott River below Big Ferry Creek       41.71233       -123.0186
## 3 Scott River below Big Ferry Creek       41.71233       -123.0186
## 4 Scott River below Big Ferry Creek       41.71233       -123.0186
## 5 Scott River below Big Ferry Creek       41.71233       -123.0186
## 6 Scott River below Big Ferry Creek       41.71233       -123.0186
##   SampleDate      SampleID2             Group   Class
## 1  9/14/2009 105PS010740070         Humn Dist Complex
## 2  9/14/2009 105PS010740070         Humn Dist Complex
## 3  9/14/2009 105PS010740070 Sub Size and Comp    Base
## 4  9/14/2009 105PS010740070 Hab Cmplx and Cvr    Base
## 5  9/14/2009 105PS010740070        Chan Morph    Base
## 6  9/14/2009 105PS010740070 Sub Size and Comp    Base
##                                        VariableName      Variable
## 1  Combined Riparian Human Disturbance Index - EMAP  W1_HALL_EMAP
## 2 Combined Riparian Human Disturbance Index - SWAMP W1_HALL_SWAMP
## 3                                     CPOM Presence      PCT_CPOM
## 4                 Evenness of Aquatic Habitat Types      Ev_AqHab
## 5                    Evenness of Flow Habitat Types    Ev_FlowHab
## 6               Evenness of Natural Substrate Types     Ev_SubNat
##   VariableResult Result Unit Count_Calc Comments
## 1             NA   0.00 none         11       NA
## 2             NA   0.00 none         14       NA
## 3             NA  24.00    %        105       NA
## 4             NA   0.77 none          8       NA
## 5             NA   0.85 none          4       NA
## 6             NA   0.75 none          8       NA
```


## Error checks for input data

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

