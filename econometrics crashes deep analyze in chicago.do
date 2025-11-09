insheet using "U:\Mes documents\Traffic_Crashes_-_Crashes_20251030.csv"

keep posted_speed_limit traffic_control_device weather_condition lighting_condition first_crash_type roadway_surface_cond damage beat_of_occurrence num_units injuries_total crash_hour crash_month trafficway_type

*----------------------------*
*STATISTIQUES DESCRIPTIVES*
*----------------------------*

gen one = 1

graph pie, over(damage) title("Répartition des niveaux de dommages") plabel(_all percent)

hist injuries_total, percent title("Distribution du nombre total de blessés par accident") graphregion(color(white)) 

graph hbar (count) one, over(traffic_control_device) ylabel(, angle(horizontal)) blabel(bar) title("Repartition des types de""signalisation routiere") ytitle("Effectif")

graph hbar (count) one, over(weather_condition) ylabel(, angle(horizontal)) blabel(bar) title("Repartition des types de""conditions météorologiques") ytitle("Effectif") graphregion(margin(r=20))

graph hbar (count) one, over(lighting_condition) ylabel(, angle(horizontal)) blabel(bar) title("Repartition des types de""conditions d'éclairage") ytitle("Effectif") graphregion(margin(r=20))

twoway (scatter injuries_total num_units, jitter(2) msize(tiny)) (lfit injuries_total num_units, lcolor(red)), xtitle("Unités impliquées") ytitle("Blessures totales")title("Blessures vs unités impliquées")

graph hbox injuries_total, over(first_crash_type, sort(1) descending) nooutsides title("Injuries by Crash Type") ytitle("Total injuries")

tab crash_hour injuries_total, row


*----------------------------*
*ENCODAGE ET TRI DES DONNEES*
*----------------------------*

*ENCODAGE MOIS*

* Q1 : janvier ? mars
gen crash_q1 = inrange(crash_month, 1, 3)
label variable crash_q1 "1 si Janvier/Fevrier/Mars"

* Q2 : avril ? juin
gen crash_q2 = inrange(crash_month, 4, 6)
label variable crash_q2 "1 si Avril/Mai/Juin"

* Q3 : juillet ? septembre
gen crash_q3 = inrange(crash_month, 7, 9)
label variable crash_q3 "1 si Juillet/Aout/Septembre"

* Q4 : octobre ? d?cembre
gen crash_q4 = inrange(crash_month, 10, 12)
label variable crash_q4 "1 si Octobre/Novembre/Decembre"

* Christmas period: 
gen crash_christmas = inlist(crash_month, 12, 1)
label variable crash_christmas "1 si Decembre/Janvier"

*ENCODAGE HEURE*

* Nuit : 0-5h
gen crash_night = inrange(crash_hour, 0, 5)
label variable crash_night "1 Si entre 0 et 5h"

* Matin : 6-11h
gen crash_morning = inrange(crash_hour, 6, 11)
label variable crash_morning "1 si entre 6 et 11h"

* Apr?s-midi : 12-17h
gen crash_afternoon = inrange(crash_hour, 12, 17)
label variable crash_afternoon "1 si entre 12 et 17h"

* Soir : 18-23h
gen crash_evening = inrange(crash_hour, 18, 23)
label variable crash_evening "1 si entre 18 et 23h"

*ENCODAGE LOCALSIATION*

gen district = floor(beat_of_occurrence/100)

* Central
gen location_central = inlist(district,1,2,3,8,9,10,12,13,18)
label variable location_central "1 si le district appartient au centre de Chicago"

* South
gen location_south   = inlist(district,4,5,6,7,22)
label variable location_south "1 si le district appartient au sud de Chicago"

* North
gen location_north   = inlist(district,11,14,15,16,17,19,20,24,25)
label variable location_north "1 si le district appartient au nord de Chicago"

drop district beat_of_occurrence crash_hour crash_month

*Supression des lignes avec "unknown" sur plusieurs variables*

gen all_unknown = ///
    (traffic_control_device  == "UNKNOWN" & ///
     weather_condition       == "UNKNOWN" & ///
     lighting_condition      == "UNKNOWN" & ///
     roadway_surface_cond    == "UNKNOWN")

drop if all_unknown == 1

drop all_unknown

*Suppression des lignes avec une limite de vitesse non logique*

drop if posted_speed_limit == 0 
drop if posted_speed_limit > 55
drop if mod(posted_speed_limit,5) != 0

*ENCODAGE LIMITE DE VITESSE*

gen speed_eq30    = (posted_speed_limit == 30)
label variable speed_eq30 "1 si la limitation de vitesse = 30 MPH"
gen speed_below30 = (posted_speed_limit < 30)
label variable speed_below30 "1 si la limitation de vitesse < 30 MPH"
gen speed_above30 = (posted_speed_limit > 30)
label variable speed_above30 "1 si la limitation de vitesse > 30 MPH"

drop posted_speed_limit

summarize

misstable summarize

drop if missing(injuries_total)


//Afin de simplifier l?analyse et d??viter la perte d?informations, 

//nous avons regroup? les modalit?s rares ainsi que la modalit? UNKNOWN de nos variables qualitatives dans une cat?gorie unique Other, 

//tout en conservant les modalit?s principales d?int?r?t


*ENCODAGE CONDITION METEOROLOGIQUE*
gen weather_condition_clear = (weather_condition == "CLEAR")
label variable weather_condition_clear "1 si temps clair"
drop weather_condition

*ENCODAGE PANNEAUX DE SIGNALSIATION*
gen traffic_control = (traffic_control_device != "NO CONTROLS")
label variable traffic_control "1 si presence de panneaux de signalisation"
drop traffic_control_device

*ENCODAGE LUMINOSITE*
gen daylight = (lighting_condition == "DAYLIGHT")
label variable daylight "1 si luminosité claire"
drop lighting_condition

*ENCODAGE ETAT DE LA ROUTE*
gen dry_road = (roadway_surface_cond == "DRY")
label variable dry_road "1 si route sèche"
drop roadway_surface_cond

*ENCODAGE COUT DES DEGATS*
gen damage_over_1500 = (damage == "OVER $1,500")
label variable damage_over_1500 "1 si degats > 1500$"
drop damage 

*ENCODAGE NOMBRE DE BLESSES*
gen injuries = (injuries_total != 0)
label variable injuries "1 si nombre de blesses > 0"

*ENCODAGE TYPE DE CRASH*
encode first_crash_type, gen(first_crash_type_num)

*------------*
*REGRESSION*
*------------*

set showbaselevels on
set showomitted on

reg injuries num_units crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num

*Vérification multicolinéarité*
estat vif

*Vérification hétéroscédasticité*
estat hettest

*Correction hétéroscédasticité*
reg injuries num_units crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num , robust

*Endogénéité*
*Ici on pense que la variable 'num_units' peut être endogène. Elle peut être correlée avec le terme d'erreur qui contiendrait par exemple le type de route (parking, route a une suele voie, route a 4 voies...).*
*'num_units', qui contient le nombre de véhicules impliqués dans un accident (ou cycliste dans le cas d'accident avec un cycliste etc...) serait logiquement corrélée avec le type de route.*
*'Mais ici, le type de route serait correlé avec 'injuries' via 'num_units' car le type de voies n'influence pas directement le nombre de blessés dans un accident."

encode trafficway_type, gen(trafficway_type_num)
ivregress 2sls injuries (num_units = i.trafficway_type_num) crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num , robust
estat firststage
estat endogenous


