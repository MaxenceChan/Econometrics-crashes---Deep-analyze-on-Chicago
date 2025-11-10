# 🎯 Objectif de la vidéo 

## 1) 📝 Présenter l’étude, la base de données et indiquer comment vous l’avez nettoyée (environ 1 minute) 
Bonjour,
notre étude analyse les accidents de la route à Chicago afin d’identifier les facteurs qui augmentent la probabilité qu’au moins une personne soit blessée. Nous utilisons le dataset officiel “Traffic Crashes” de la Ville de Chicago, sur la période [période]. L’unité d’observation est l’accident, soit [x] individus (lignes) et [y] variables au départ.

Nous avons retenu un Linear Probability Model (LPM) pour estimer l’effet de caractéristiques d’accident — heure de la journée, météo, vitesse, localisation, type de collision, etc. — sur la probabilité d’avoir au moins un blessé.

Côté préparation, nous avons d’abord exploré la structure des variables et la qualité des données : détection de valeurs manquantes, incohérences et doublons. Après filtres de cohérence (dates invalides, vitesses impossibles, enregistrements incomplets), nous avons exclu [x_individus_supprimés] observations, soit [pourcentage] % du total.

Comme le jeu contient de nombreuses variables qualitatives, nous les avons binarisées en indicateurs, en fixant comme modalité de référence la plus fréquente. Les valeurs “UNKNOWN” — [Z] occurrences — ont été regroupées dans “Other” pour éviter un biais de sélection lié à leur suppression.

Au final, notre échantillon d’estimation compte [x_final] accidents, prêt pour la phase de modélisation.

Voici les variables retenues : 

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
## 2) 🛠️ Présenter et justifier votre modèle économétrique et sa technique d’estimation (environ 1 minute) 

Pour expliquer la probabilité qu’un accident entraîne au moins un blessé, nous avons choisi modèle LPM (Linear Probability Model) estimé par MCO.

Ce modèle consiste simplement en une régression linéaire où la variable dépendante est binaire : blessure = 1 si au moins un blessé, 0 sinon.

Le LPM a plusieurs avantages dans le cas de notre étude :
– il est simple à interpréter ;
– les coefficients donnent directement l’effet marginal sur la probabilité de blessure ;
– l'interprétation des variables qualitatives avec de nombreuses modalités est facile.

Il étaient intéréssant dans notre cas d'utiliser ce type de modèle car nous avons observer que 95% des accidents concernait 0 ou 1 bléssés. De ce fait nous avons donc opter pour un modèle probabiliste plutot qu'un modèle linéaire multiple. 

Pour l’estimation des coéfficient, nous la feront avec sous forme de probabilité. Nous avons également corriger l’hétéroscédasticité identifiée par le test de Breusch–Pagan par les ecart-types robustes .

Enfin, nous avons supposé de l'endogénéité concernant la variable num_units. Nous avons donc recouru à une estimation en deux étapes IV/2SLS, utilisant trafficway_type_num comme instrument, que nous avons validé grâce au test de pertinence (F-stat > 10) et au test de Durbin–Wu–Hausman.

## 3) 📊 Présenter quelques statistiques descriptives (environ 2 minutes) ainsi que les résultats de vos estimations (environ 2 minutes)

## 4) ⚠️ Conclure en indiquant également les limites de votre étude (environ 1 minute).

---
