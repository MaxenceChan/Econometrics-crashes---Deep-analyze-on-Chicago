# 🎯 Objectif de la vidéo 

## 1) 📝 Présenter l’étude, la base de données et indiquer comment vous l’avez nettoyée (environ 1 minute) 
Bonjour,
notre étude analyse les accidents de la route à Chicago afin d’identifier les facteurs qui augmentent la probabilité qu’au moins une personne soit blessée. Nous utilisons le dataset officiel “Traffic Crashes” de la Ville de Chicago, sur la période [période]. L’unité d’observation est l’accident, soit [x] individus (lignes) et [y] variables au départ.

Nous avons retenu un Linear Probability Model (LPM) pour estimer l’effet de caractéristiques d’accident — heure de la journée, météo, vitesse, localisation, type de collision, etc. — sur la probabilité d’avoir au moins un blessé.

Côté préparation, nous avons d’abord exploré la structure des variables et la qualité des données : détection de valeurs manquantes, incohérences et doublons. Après filtres de cohérence (dates invalides, vitesses impossibles, enregistrements incomplets), nous avons exclu [x_individus_supprimés] observations, soit [pourcentage] % du total.

Comme le jeu contient de nombreuses variables qualitatives, nous les avons binarisées en indicateurs, en fixant comme modalité de référence la plus fréquente. Les valeurs “UNKNOWN” — [Z] occurrences — ont été regroupées dans “Other” pour éviter un biais de sélection lié à leur suppression.

Au final, notre échantillon d’estimation compte [x_final] accidents, prêt pour la phase de modélisation.
## 2) 🛠️ Présenter et justifier votre modèle économétrique et sa technique d’estimation (environ 1 minute) 

## 3) 📊 Présenter quelques statistiques descriptives (environ 2 minutes) ainsi que les résultats de vos estimations (environ 2 minutes)

## 4) ⚠️ Conclure en indiquant également les limites de votre étude (environ 1 minute).

---
