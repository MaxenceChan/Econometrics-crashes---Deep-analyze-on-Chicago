# Econometrics-crashes---Deep-analyze-on-Chicago
DAMNNNNNNNNNNNN

lien du projet : https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if/about_data

 reg injuries num_units crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 
> speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num

      Source |       SS       df       MS              Number of obs =  973357
-------------+------------------------------           F( 31,973325) = 9038.31
       Model |  27006.9693    31  871.192557           Prob > F      =  0.0000
    Residual |  93817.7341973325  .096388908           R-squared     =  0.2235
-------------+------------------------------           Adj R-squared =  0.2235
       Total |  120824.703973356  .124132078           Root MSE      =  .31047

-----------------------------------------------------------------------------------------
               injuries |      Coef.   Std. Err.      t    P>|t|     [95% Conf. Interval]
------------------------+----------------------------------------------------------------
              num_units |   .1031204   .0008285   124.46   0.000     .1014965    .1047442
        crash_christmas |  -.0109139   .0008909   -12.25   0.000    -.0126601   -.0091677
            crash_night |   .0299887   .0014619    20.51   0.000     .0271235    .0328539
        crash_afternoon |  -.0034596   .0007912    -4.37   0.000    -.0050103   -.0019089
          crash_evening |   .0088383   .0011398     7.75   0.000     .0066044    .0110722
         location_south |   .0338218    .000891    37.96   0.000     .0320755    .0355681
         location_north |   .0023539   .0006985     3.37   0.001     .0009848     .003723
          speed_below30 |  -.0319928   .0008764   -36.51   0.000    -.0337105   -.0302751
          speed_above30 |   .0299072   .0011586    25.81   0.000     .0276364     .032178
weather_condition_clear |  -.0035586   .0011312    -3.15   0.002    -.0057757   -.0013416
        traffic_control |   .0275238   .0007113    38.69   0.000     .0261297     .028918
               daylight |  -.0039235   .0009877    -3.97   0.000    -.0058594   -.0019876
               dry_road |   .0160127   .0010514    15.23   0.000      .013952    .0180733
       damage_over_1500 |   .0733254   .0006751   108.61   0.000     .0720021    .0746486
                        |
   first_crash_type_num |
                     1  |   .1733776    .001239   139.93   0.000     .1709491     .175806
                     2  |   .1308969   .0115809    11.30   0.000     .1081988    .1535951
                     3  |   .2292042   .0018612   123.15   0.000     .2255564     .232852
                     4  |   .2581771   .0034992    73.78   0.000     .2513188    .2650354
                     5  |   .2366591    .006036    39.21   0.000     .2248288    .2484895
                     6  |   .2010701   .0033584    59.87   0.000     .1944878    .2076525
                     7  |   .4714171   .0130568    36.11   0.000     .4458263    .4970079
                     8  |          0  (base)
                     9  |   .6942082   .0025596   271.22   0.000     .6891915     .699225
                    10  |   .8549578   .0021742   393.23   0.000     .8506964    .8592191
                    11  |    .086778     .00103    84.25   0.000     .0847592    .0887968
                    12  |   .0251947   .0031027     8.12   0.000     .0191134    .0312759
                    13  |    .021721   .0067211     3.23   0.001     .0085479    .0348941
                    14  |   .0527298   .0039759    13.26   0.000     .0449371    .0605224
                    15  |   .0761164   .0027677    27.50   0.000     .0706918    .0815409
                    16  |   .0185582    .001088    17.06   0.000     .0164257    .0206908
                    17  |   .4646747   .0426575    10.89   0.000     .3810675    .5482819
                    18  |   .1130843   .0011491    98.41   0.000      .110832    .1153365
                        |
                  _cons |   -.242717   .0022666  -107.08   0.000    -.2471594   -.2382745
-----------------------------------------------------------------------------------------

. estat vif

    Variable |       VIF       1/VIF  
-------------+----------------------
   num_units |      1.41    0.710685
crash_chri~s |      1.05    0.956151
 crash_night |      1.85    0.539493
crash_afte~n |      1.53    0.652151
crash_even~g |      2.34    0.428102
location_s~h |      1.16    0.859076
location_n~h |      1.17    0.853559
speed_bel~30 |      1.11    0.896992
speed_abo~30 |      1.03    0.968251
weather_co~r |      2.08    0.480913
traffic_co~l |      1.25    0.798131
    daylight |      2.23    0.447580
    dry_road |      2.10    0.477249
damage_~1500 |      1.06    0.941071
first_cras~m |
          1  |      1.51    0.662322
          2  |      1.01    0.992039
          3  |      1.52    0.658452
          4  |      1.03    0.966892
          5  |      1.03    0.969692
          6  |      1.10    0.913211
          7  |      1.01    0.992512
          9  |      1.09    0.916538
         10  |      1.12    0.889046
         11  |      1.83    0.545021
         12  |      1.04    0.958813
         13  |      1.01    0.990054
         14  |      1.03    0.975100
         15  |      1.05    0.951824
         16  |      1.57    0.638216
         17  |      1.00    0.999504
         18  |      1.66    0.600852
-------------+----------------------
    Mean VIF |      1.35

. 
. 
end of do-file

. estat hettest   // Breusch–Pagan
invalid use of '/'
r(198);

. 
. estat imtest, white
op. sys. refuses to provide memory
    Stata's data-storage memory manager has already allocated 1472m bytes and it just attempted to allocate another 16m
    bytes.  The operating system said no.  Perhaps you are running another memory-consuming task and the command will work
    later when the task completes.  Perhaps you are on a multiuser system that is especially busy and the command will work
    later when activity quiets down.  Perhaps a system administrator has put a limit on what you can allocate; see help
    memory.  Or perhaps that's all the memory your computer can allocate to Stata.
r(909);

. estat hettest

Breusch-Pagan / Cook-Weisberg test for heteroskedasticity 
         Ho: Constant variance
         Variables: fitted values of injuries

         chi2(1)      = 93032.75
         Prob > chi2  =   0.0000

