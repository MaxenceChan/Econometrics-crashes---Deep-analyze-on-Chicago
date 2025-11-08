# 🚗 Chicago Traffic Crashes — Econometric Analysis

## 📂 Project

# What Causes Injuries in Chicago Car Crashes? An Econometric Study
This project analyzes traffic crashes in Chicago using econometric methods to understand the factors that increase the likelihood of injuries during an accident.
Using the official Traffic Crashes dataset from the City of Chicago, we estimate a Linear Probability Model (LPM) to measure how crash characteristics (time of day, weather, speed, location, crash type, etc.) affect the probability that at least one person is injured.

---

## 🔗 Dataset

Source: City of Chicago — Traffic Crashes (Crashes)

> [https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if/about_data](https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if/about_data)

---

## 🎯 Objective

Model the probability of injuries occurring during a traffic crash using explanatory variables describing conditions of the crash (location, time, environment, etc.).

---

## 📊 Descriptive Statistics — Visual Exploration

Below are several visualizations summarizing the main features of the dataset.  
These figures provide an overview of the distributions and relationships among key variables (e.g., traffic conditions, number of units involved, injury counts, damage levels).

> ⚠️ **Important note**  
For this project, **we were strictly required to use Stata 12 (July 2011)**, running inside a **virtual machine**, with **no possibility of installing external libraries or upgrading the software**.  
Because of this constraint, many modern visualization features (e.g., transparency, continuous color gradients, advanced theming, `colorvar()`, etc.) were unavailable.  
As a result, **some types of plots could not be generated**, and **the graphical output is visually limited and less polished**.  
Please keep this context in mind when evaluating the appearance and diversity of the charts.

### ✅ Examples of included charts
- Bar charts displaying the distribution of qualitative variables  
- Horizontal bar charts with counts and/or percentages  
- Pie charts (limited customization due to software constraints)  
- Scatter plots illustrating relationships between quantitative variables  
- Scatter + fitted line models using `lfit`  

Each plot is displayed below and accompanied by a brief description.

### ✅ Figure — Distribution of Total Injuries per Crash

📌 **Description**  
Histogram showing the percentage distribution of the total number of injuries recorded per crash (`INJURIES_TOTAL`).

<img width="1744" height="1243" alt="image" src="https://github.com/user-attachments/assets/4f9e8a6e-6c38-4e30-a629-f1c882942688" />

📝 **Interpretation**  
The distribution is highly concentrated near zero:  
the vast majority of crashes result in **no injuries or only a very small number of injuries**.  
Occurrences with more than 3–4 injuries are extremely rare, and values above 10 are exceptional.  
This confirms that most reported accidents involve minimal physical harm, while severe injury events represent only a very small fraction of total crashes.

### ✅ Figure — Injuries vs. Number of Units Involved

📌 **Description**  
Scatter plot of the total number of injuries per crash (`INJURIES_TOTAL`) against the number of units involved (`NUM_UNITS`), with a fitted linear regression line.

<img width="1748" height="1241" alt="Capture d&#39;écran 2025-11-08 101010" src="https://github.com/user-attachments/assets/73e183a8-b08c-4b74-982f-6721386bd4bb" />

📝 **Interpretation**  
Most crashes involve relatively few units (typically fewer than 5) and result in only a small number of injuries.  
A weak positive trend is visible: crashes with more units tend to be associated with a slightly higher number of injuries, but the relationship is very limited.  
The fitted line confirms that the linear association is weak, and there is considerable variability in injury counts even for the same number of involved units.  
Overall, the number of units is not a strong predictor of injury severity.

### ✅ Figure — Distribution of Damage Level Categories

📌 **Description**  
Pie chart showing the proportion of crashes by estimated damage cost category.

<img width="1756" height="1271" alt="Capture d&#39;écran 2025-11-07 175700" src="https://github.com/user-attachments/assets/8eb2e6eb-3a2e-4187-9a01-337d09e09786" />

📝 **Interpretation**  
A large majority of crashes (≈ **64%**) fall in the **“over $1,500”** damage category, suggesting that most incidents result in substantial material losses.  
About **25%** of crashes incur damages between **$501 and $1,500**, while only **≈11%** result in damages of **$500 or less**.  
This distribution indicates that low-cost incidents are relatively rare compared to medium- or high-cost crashes.

### ✅ Figure — Distribution of Weather Conditions

📌 **Description**  
Horizontal bar chart showing the frequency of recorded weather conditions at the time of crashes.

<img width="1618" height="1244" alt="Capture d&#39;écran 2025-11-07 175104" src="https://github.com/user-attachments/assets/cf46655c-1a27-4d6f-b413-ec20965803a7" />

📝 **Interpretation**  
Most crashes occurred under **clear weather conditions**, which account for the overwhelming majority of cases (≈785,000).  
Rain and cloudy/overcast conditions are the next most common, though far below clear conditions.  
Severe phenomena (e.g., snow, sleet, hail, blowing sand/dirt, or strong crosswinds) represent a very small share of crashes.  
This suggests that poor weather is not the primary factor in most recorded accidents, though it may still contribute in a minority of cases.

### ✅ Figure — Distribution of Lighting Conditions

📌 **Description**  
Horizontal bar chart showing the frequency of lighting conditions present at the time of crashes.

<img width="1627" height="1245" alt="Capture d&#39;écran 2025-11-07 174737" src="https://github.com/user-attachments/assets/f799f3eb-bc3d-4412-a4ce-a99ffa5ea21c" />

📝 **Interpretation**  
Most crashes occurred during **daylight**, accounting for more than 640,000 cases.  
The next most common condition is **darkness with road lighting**, followed by **dusk** and complete **darkness**.  
Crashes during **dawn** are relatively rare, and a small portion of cases fall into the **unknown** category.  
Overall, daylight appears to be the context for the majority of crashes, suggesting that visibility is not the determining factor in most incidents.

### ✅ Figure — Distribution of Road Sign Types

📌 **Description**  
Horizontal bar chart showing the frequency of each road signage type (`traffic_control_device`) recorded at crash locations.

<img width="1757" height="1237" alt="Capture d&#39;écran 2025-11-07 173758" src="https://github.com/user-attachments/assets/9f430128-2cf0-42b6-9a88-924793fcf288" />

📝 **Interpretation**  
The majority of crashes occurred at locations **without any traffic control device**, which represents by far the largest category (over 560,000 cases).  
Traditional controls such as **traffic signals** and **stop signs/flashers** appear next in frequency but remain far behind.  
Other signage categories, including pedestrian crossings, school zones, and railroad signals, represent only a small share of total crashes.  
This suggests that areas lacking traffic control infrastructure are associated with a disproportionately large number of accidents.

### ✅ Figure — Injuries by Crash Type

📌 **Description**  
Horizontal boxplot displaying the distribution of total injuries for each crash type.  
Extreme outliers are excluded to improve readability.

<img width="1736" height="1259" alt="image" src="https://github.com/user-attachments/assets/336c51ff-d084-4815-94ec-864c7df9641c" />

📝 **Interpretation**  
Crash types involving pedestrians, pedalcyclists, overturned vehicles, or head-on collisions show higher median injury counts, indicating that these scenarios are generally more severe.  
Most other crash types cluster near zero, reflecting low injury frequency for the majority of accidents.  
Only a few categories exhibit longer right-tails, suggesting that serious injury outcomes are concentrated within specific crash mechanisms.

### ✅ Figure — Cross-tab of Injury Count by Hour of Crash

📌 **Description**  
This table reports the distribution of crashes by hour of day (rows) and total number of injuries per crash (columns).  
Each cell indicates how many crashes occurred at a given hour with a specified number of injuries.  
The rightmost column shows the hourly crash totals, and the bottom row shows totals by injury count.

CRASH_HOUR |         0          1          2          3          4          5          6          7          8          9         10         11         12         13         14         15         16         17         19         21 |     Total
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         0 |    17,818      2,651        731        245        110         39         18          7          2          0          0          0          0          0          0          0          0          0          0          0 |    21,621 
           |     82.41      12.26       3.38       1.13       0.51       0.18       0.08       0.03       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         1 |    15,246      2,211        651        205         76         28         19         11          2          1          0          0          0          0          0          0          0          0          0          0 |    18,450 
           |     82.63      11.98       3.53       1.11       0.41       0.15       0.10       0.06       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         2 |    12,936      1,925        557        227         86         28         13          6          5          0          0          0          0          0          0          1          0          0          0          0 |    15,784 
           |     81.96      12.20       3.53       1.44       0.54       0.18       0.08       0.04       0.03       0.00       0.00       0.00       0.00       0.00       0.00       0.01       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         3 |    10,729      1,599        452        141         60         23          8          3          2          0          0          0          0          0          0          0          0          0          0          0 |    13,017 
           |     82.42      12.28       3.47       1.08       0.46       0.18       0.06       0.02       0.02       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         4 |     9,442      1,503        388        105         40          7          7          1          0          1          0          0          0          0          0          0          0          0          0          0 |    11,494 
           |     82.15      13.08       3.38       0.91       0.35       0.06       0.06       0.01       0.00       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         5 |    11,441      1,676        372        100         30          6          4          3          0          0          1          0          1          0          1          0          0          0          0          1 |    13,636 
           |     83.90      12.29       2.73       0.73       0.22       0.04       0.03       0.02       0.00       0.00       0.01       0.00       0.01       0.00       0.01       0.00       0.00       0.00       0.00       0.01 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         6 |    18,214      2,492        553        121         47         12          2          6          0          1          2          0          0          0          0          0          0          0          0          1 |    21,451 
           |     84.91      11.62       2.58       0.56       0.22       0.06       0.01       0.03       0.00       0.00       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         7 |    36,729      4,488        873        255         88         38         14          1          2          1          1          0          0          1          0          0          0          0          1          0 |    42,492 
           |     86.44      10.56       2.05       0.60       0.21       0.09       0.03       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         8 |    46,023      5,420      1,145        309         87         39         14          4          5          1          0          0          0          0          0          0          0          0          0          0 |    53,047 
           |     86.76      10.22       2.16       0.58       0.16       0.07       0.03       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
         9 |    39,730      4,483        947        265         79         21          7          6          2          2          0          0          1          0          0          0          0          0          1          2 |    45,546 
           |     87.23       9.84       2.08       0.58       0.17       0.05       0.02       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        10 |    39,534      4,279        981        278         72         28          9          5          1          0          0          1          1          0          0          1          0          0          0          0 |    45,190 
           |     87.48       9.47       2.17       0.62       0.16       0.06       0.02       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        11 |    43,944      4,878      1,108        324        124         30          6          5          4          0          0          2          0          0          0          0          0          0          0          0 |    50,425 
           |     87.15       9.67       2.20       0.64       0.25       0.06       0.01       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        12 |    50,905      5,375      1,254        363        129         41         16          6          2          0          1          0          1          0          0          1          0          0          0          0 |    58,094 
           |     87.63       9.25       2.16       0.62       0.22       0.07       0.03       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        13 |    52,268      5,900      1,325        402        141         55         22          4          5          1          0          0          1          1          0          1          0          0          0          0 |    60,126 
           |     86.93       9.81       2.20       0.67       0.23       0.09       0.04       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        14 |    57,627      6,700      1,533        460        125         45         17          4          3          2          1          0          0          0          0          0          0          0          0          0 |    66,517 
           |     86.63      10.07       2.30       0.69       0.19       0.07       0.03       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        15 |    67,141      7,907      1,655        471        155         61         23         10          7          1          3          1          0          1          0          1          0          0          0          0 |    77,437 
           |     86.70      10.21       2.14       0.61       0.20       0.08       0.03       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        16 |    66,065      7,904      1,637        502        196         69         24         14          6          4          1          2          2          0          0          0          0          0          0          0 |    76,426 
           |     86.44      10.34       2.14       0.66       0.26       0.09       0.03       0.02       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        17 |    63,520      8,138      1,610        476        177         65         24          9          1          5          2          0          0          0          0          0          0          1          0          0 |    74,028 
           |     85.81      10.99       2.17       0.64       0.24       0.09       0.03       0.01       0.00       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        18 |    51,894      6,826      1,437        423        146         53         19         17          4          1          0          0          0          0          0          1          0          0          0          0 |    60,821 
           |     85.32      11.22       2.36       0.70       0.24       0.09       0.03       0.03       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        19 |    37,837      5,334      1,152        371        147         41         11          9          1          1          1          1          0          0          0          2          1          0          0          0 |    44,909 
           |     84.25      11.88       2.57       0.83       0.33       0.09       0.02       0.02       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        20 |    30,415      4,472      1,001        334        139         55         24          6          2          3          0          1          0          0          0          0          0          0          0          0 |    36,452 
           |     83.44      12.27       2.75       0.92       0.38       0.15       0.07       0.02       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        21 |    26,970      4,087        932        328        136         53         25          8          5          3          1          0          0          0          0          0          1          0          0          0 |    32,549 
           |     82.86      12.56       2.86       1.01       0.42       0.16       0.08       0.02       0.02       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        22 |    24,782      3,626        921        295        127         59         19          5          1          2          2          0          0          0          0          0          0          0          0          0 |    29,839 
           |     83.05      12.15       3.09       0.99       0.43       0.20       0.06       0.02       0.00       0.01       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
        23 |    21,485      3,148        828        300         95         39         24          5          1          1          0          2          0          0          0          0          0          0          0          0 |    25,928 
           |     82.86      12.14       3.19       1.16       0.37       0.15       0.09       0.02       0.00       0.00       0.00       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 
-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------
     Total |   852,695    107,022     24,043      7,300      2,612        935        369        155         63         31         16         10          7          3          1          8          2          1          2          4 |   995,279 
           |     85.67      10.75       2.42       0.73       0.26       0.09       0.04       0.02       0.01       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00       0.00 |    100.00 


📝 **Interpretation**  
Most crashes occur during typical daytime and evening traffic hours, especially between **7:00–18:00**, reflecting periods of higher road usage.  
Across all time periods, crashes resulting in **zero injuries** strongly dominate the dataset, representing the vast majority of events.  

Crashes involving **one or more injuries** are much less frequent and show no extreme hourly concentration, though slightly elevated counts appear around late afternoon and early evening.  
Higher-injury crashes (≥3 injured) are rare and scattered across hours with no clear temporal pattern, suggesting that severe crashes are not strongly time-dependent.

---

## 📐 Model — Linear Probability Model (LPM)

### ✅ Regression

```
reg injuries \
    num_units crash_christmas crash_night crash_afternoon crash_evening \
    location_south location_north \
    speed_below30 speed_above30 \
    weather_condition traffic_control daylight dry_road damage_over_1500 \
    ib8.first_crash_type_num
```

### 📊 Output (LPM)

<img width="750" height="872" alt="image" src="https://github.com/user-attachments/assets/0b46c305-137b-45dc-817f-2837344ecaea" />

---

## 🏷️ Reference Categories (Baseline)

For each qualitative variable group, categories are mutually exclusive and exhaustive.  
Therefore, the reference category is the one **not included in the regression**.

| Variable group | Dummies included in model | Reference (baseline) |
|----------------|--------------------------|----------------------|
| Time of crash  | crash_afternoon, crash_evening, crash_night | **crash_morning** |
| Holiday        | crash_christmas          | **Not Christmas** |
| Location       | location_south, location_north | **location_center** |
| Speed          | speed_below30, speed_above30 | **speed_eq30** |
| Weather        | weather_condition        | **Other weather conditions** |
| Traffic control| traffic_control          | **No traffic control** |
| Daylight       | daylight                 | **Not daylight (night/twilight)** |
| Road surface   | dry_road                 | **Not dry** |
| Damage         | damage_over_1500         | **Damage ≤ $1500** |
| Crash type     | ib8.first_crash_type_num | **Type 8 — PARKED MOTOR VEHICLE** |

---

## 🔎 Multicollinearity — VIF

```
estat vif
```

<img width="336" height="697" alt="image" src="https://github.com/user-attachments/assets/f5db6d6b-a103-4d1e-88ab-0a12b5d54881" />

✅ No major multicollinearity concern (VIF < 10 generally acceptable).

---

## 📈 Heteroskedasticity — Breusch–Pagan Test

```
estat hettest
```

<img width="377" height="95" alt="image" src="https://github.com/user-attachments/assets/692cfe65-fce1-466b-a134-2ca2f569ad28" />

**Result:** p-value ≈ 0.000 → Reject H0 → **Heteroskedasticity detected**

→ Standard errors need correction.

---

## ✅ Robust LPM

Robust estimation to correct standard errors:

```
reg injuries \
    num_units crash_christmas crash_night crash_afternoon crash_evening \
    location_south location_north \
    speed_below30 speed_above30 \
    weather_condition traffic_control daylight dry_road damage_over_1500 \
    ib8.first_crash_type_num , robust
```

<img width="749" height="852" alt="image" src="https://github.com/user-attachments/assets/2deb1ea1-8d8a-4a88-9cd7-0bca7a4c1acc" />
" />

---

<img width="620" height="265" alt="image" src="https://github.com/user-attachments/assets/8917e602-8169-4a59-9f14-341ef8a041fa" />

The variable `predictions` represents the output generated by the fitted model.  
Across all observations:

- The predicted values range from approximately **–0.09 to 1.78**.  
  → While the target variable may theoretically be non-negative (e.g., injury counts or probabilities), linear models are not bounded, so predictions may fall slightly below 0 or above 1.


---

## 🚦 Crash Type Conversion Table

> Mapping of `first_crash_type_num` to crash labels (from Stata)

| Code | Label                        |
| ---- | ---------------------------- |
| 1    | ANGLE                        |
| 2    | ANIMAL                       |
| 3    | FIXED OBJECT                 |
| 4    | HEAD ON                      |
| 5    | OTHER NONCOLLISION           |
| 6    | OTHER OBJECT                 |
| 7    | OVERTURNED                   |
| 8    | PARKED MOTOR VEHICLE         |
| 9    | PEDALCYCLIST                 |
| 10   | PEDESTRIAN                   |
| 11   | REAR END                     |
| 12   | REAR TO FRONT                |
| 13   | REAR TO REAR                 |
| 14   | REAR TO SIDE                 |
| 15   | SIDESWIPE OPPOSITE DIRECTION |
| 16   | SIDESWIPE SAME DIRECTION     |
| 17   | TRAIN                        |
| 18   | TURNING                      |

---

### ✅ Interpretation (selected coefficients)

* **num_units ≈ +0.103** → More vehicles → higher injury probability
* **speed_below30 ≈ −0.032** → Low speed reduces injury probability
* **speed_above30 ≈ +0.030** → High speed increases injury probability
* **damage_over_1500 ≈ +0.073** → Major damage → higher injury probability
* **first_crash_type_num (9) ≈ +0.69** → Crash type greatly increases injury likelihood

---

## 🧾 Summary

| Step                        | Status      |
| --------------------------- | ----------- |
| LPM estimated               | ✅           |
| VIF checked                 | ✅ No issue  |
| Heteroskedasticity detected | ⚠️ Yes      |
| Robust SE applied           | ✅ Corrected |

---

## ✅ Conclusion

Even though the linear probability model has limitations, results are consistent with intuition:

* crash severity, vehicles involved, and speed conditions significantly increase the likelihood of injuries.
* Robust errors ensure valid inference under heteroskedasticity.

Further work:

* Consider non-linear models (Probit/Logit)
* Explore endogeneity & IV strategies
* Analyze spatial patterns

---
