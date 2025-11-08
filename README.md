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
