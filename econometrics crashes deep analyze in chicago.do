insheet using "U:\Mes documents\Traffic_Crashes_-_Crashes_20251030.csv"

keep posted_speed_limit traffic_control_device weather_condition lighting_condition first_crash_type roadway_surface_cond damage beat_of_occurrence num_units injuries_total crash_hour crash_month

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

* Q1 : janvier ? mars

gen crash_q1 = inrange(crash_month, 1, 3)

* Q2 : avril ? juin

gen crash_q2 = inrange(crash_month, 4, 6)

* Q3 : juillet ? septembre

gen crash_q3 = inrange(crash_month, 7, 9)

* Q4 : octobre ? d?cembre

gen crash_q4 = inrange(crash_month, 10, 12)

* Christmas period: 

gen crash_christmas = inlist(crash_month, 12, 1)

* Nuit : 0-5h

gen crash_night = inrange(crash_hour, 0, 5)

* Matin : 6-11h

gen crash_morning = inrange(crash_hour, 6, 11)

* Apr?s-midi : 12-17h

gen crash_afternoon = inrange(crash_hour, 12, 17)

* Soir : 18-23h

gen crash_evening = inrange(crash_hour, 18, 23)

gen district = floor(beat_of_occurrence/100)

* Central

gen location_central = inlist(district,1,2,3,8,9,10,12,13,18)

* South

gen location_south   = inlist(district,4,5,6,7,22)

* North

gen location_north   = inlist(district,11,14,15,16,17,19,20,24,25)

drop district beat_of_occurrence crash_hour crash_month

gen all_unknown = ///
    (traffic_control_device  == "UNKNOWN" & ///
     weather_condition       == "UNKNOWN" & ///
     lighting_condition      == "UNKNOWN" & ///
     roadway_surface_cond    == "UNKNOWN")

drop if all_unknown == 1

drop all_unknown

drop if posted_speed_limit == 0 

drop if posted_speed_limit > 55

drop if mod(posted_speed_limit,5) != 0

gen speed_eq30    = (posted_speed_limit == 30)

gen speed_below30 = (posted_speed_limit < 30)

gen speed_above30 = (posted_speed_limit > 30)

drop posted_speed_limit

summarize

misstable summarize

drop if missing(injuries_total)

//Afin de simplifier l?analyse et d??viter la perte d?informations, 

//nous avons regroup? les modalit?s rares ainsi que la modalit? UNKNOWN de nos variables qualitatives dans une cat?gorie unique Other, 

//tout en conservant les modalit?s principales d?int?r?t

gen weather_condition_clear = (weather_condition == "CLEAR")

drop weather_condition


gen traffic_control = (traffic_control_device != "NO CONTROLS")

drop traffic_control_device

gen daylight = (lighting_condition == "DAYLIGHT")

drop lighting_condition

gen dry_road = (roadway_surface_cond == "DRY")

drop roadway_surface_cond

gen damage_over_1500 = (damage == "OVER $1,500")

drop damage 

gen injuries = (injuries_total != 0)

encode first_crash_type, gen(first_crash_type_num)

set showbaselevels on

set showomitted on

reg injuries num_units crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num

estat vif

estat hettest

reg injuries num_units crash_christmas crash_night crash_afternoon crash_evening location_south location_north speed_below30 speed_above30 weather_condition traffic_control daylight dry_road damage_over_1500 ib8.first_crash_type_num , robust
