capture log close
log using "output/1_hcup_wisconsin_analysis.log", text replace

cd "~/code/mhviz-tools/"

import excel "data/hcup/Wisconsin/HCUPnet_Community_DX1CCSR_County_WI_hyp_2020.xlsx", ///
    sheet("Table Data") firstrow clear

* Rename columns
rename County county
rename FIPScode fips_code
rename PatientCharacteristic patient_characteristic
rename NumberofDischarges number_of_discharges
rename AverageLengthofStayindays length_of_stay
rename RateofDischargesper100000P rate_of_discharges_per_100000p
rename AgeSexAdjustedRateofDischar age_sex_adj_rate_of_discharge
rename AggregateHospitalCostsin aggregate_hospital_costs
rename AverageHospitalCostsperStay average_hospital_costs_per_stay

* Drop rows where length_of_stay is "*"
drop if length_of_stay == "*"

keep county average_hospital_costs_per_stay

* convert to numeric
destring average_hospital_costs_per_stay, replace

* generate bar chart

graph hbar (asis) average_hospital_costs_per_stay, ///
    over(county, sort(1) descending label(angle(0))) ///
    bar(1, color(navy)) ///
    ysize(10) xsize(6) /// Make the graph taller
    scale(0.8) /// Reduce overall text size
    title("Average Cost (USD) of A Hospital Visit When Giving Birth:" ///
          "OB Patients with Births Complicated By Hypertension" ///
		  "(Wisconsin, 2020)", ///
    size(medium) color(black)) ///
	scheme(s1color)
		
graph export "output/1_hcup_wisconsin_costs.png", replace

log close
