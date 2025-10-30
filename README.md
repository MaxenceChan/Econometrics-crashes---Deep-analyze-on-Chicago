# 🚗 Chicago Traffic Crashes — Econometric Analysis

## 🔗 Dataset

Source: City of Chicago — Traffic Crashes (Crashes)

> [https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if/about_data](https://data.cityofchicago.org/Transportation/Traffic-Crashes-Crashes/85ca-t3if/about_data)

---

## 🎯 Objective

Model the probability of injuries occurring during a traffic crash using explanatory variables describing conditions of the crash (location, time, environment, etc.).

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

<img width="769" height="728" alt="image" src="https://github.com/user-attachments/assets/f8d0fe71-464f-4cd4-b040-8a19f8b643a0" />

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
reg injuries ... , robust
```

<img width="788" height="745" alt="image" src="https://github.com/user-attachments/assets/b635a1ea-7b01-481c-b575-07037eacff96" />

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

## 📂 Project

```
# Econometrics-crashes---Deep-analyze-on-Chicago
DAMNNNNNNNNNNNN
```

---

