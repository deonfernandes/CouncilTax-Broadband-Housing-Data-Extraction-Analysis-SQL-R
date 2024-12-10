library(RSQLite)
library(DBI)
library(haven)
library(dplyr)


#connect SQL database to R studio
con <- dbConnect(RSQLite::SQLite(), "C:/Desktop/DS foundations/database.db")

#Import the CSV files of broadband data and write the data from CSV in the database tables.
broadband_data <- read.csv("C:/Desktop/DS foundations/broadband_data.csv")
dbWriteTable(con, name = "broadband_data", value= broadband_data, append=TRUE)

#Import the CSV files of housing data and write the data from CSV in the database tables.
housing_data <- read.csv("C:/Desktop/DS foundations/housing_data.csv")
dbWriteTable(con, name = "housing_data", value= housing_data, append=TRUE)

#Import the CSV files of Council Tax data and write the data from CSV in the database tables.
council_tax <- read.csv("C:/Desktop/DS foundations/council_tax_23-24.csv")
dbWriteTable(con, name = "council_tax", value= council_tax, append=TRUE)

#Import the CSV files of Ward data and write the data from CSV in the database tables.
ward_data <- read.csv("C:/Desktop/DS foundations/ward_data.csv")
dbWriteTable(con, name = "ward_data", value= ward_data, append=TRUE)



#3 Average prices of houses in 2 years
Question_3 <- dbGetQuery(con, "Select ward_data.ward_code, ward_data.ward, ward_data.district, 
((`Mar_2020` + `Jun_2020` + `Sep_2020` + `Dec_2020`)/4) as `Average housing prices of 2020`,
((`Mar_2021` + `Jun_2021` + `Sep_2021` + `Dec_2021`)/4) AS `Average housing prices of 2021`
From housing_data
Join ward_data on housing_data.ward_code = ward_data.ward_code
where ward = 'Marston'")
print (Question_3)



#4 Average increase/decrease in prices in 2 years.
Question_4 <- dbGetQuery(con, "SELECT District, Ward,
(((`Average housing prices of 2021` - `Average housing prices of 2020`) / (`Average housing prices of 2020`)) * 100) AS `Average Price Change (%)`
FROM (
Select ward_data.ward_code, ward_data.ward, ward_data.district, ((`Mar_2020` + `Jun_2020` + `Sep_2020` + `Dec_2020`)/4) as `Average housing prices of 2020`,
((`Mar_2021` + `Jun_2021` + `Sep_2021` + `Dec_2021`)/4) AS `Average housing prices of 2021` from housing_data
Join ward_data on housing_data.ward_code = ward_data.ward_code
where ward = 'Marston')
as subquery; ")
print (Question_4)



#5 Ward with highest price in particular year
Question_5 <- dbGetQuery(con, "Select ward_data.District, ward_data.ward, ward_data.ward_code, MAX(Mar_2020) as Highest_house_price_in_Mar_2020 from housing_data
Join ward_data
on ward_data.ward_code = housing_data.ward_code
where District = 'Oxford'")
print (Question_5)



#6 Broadband speed of Stanford
Question_6 <- dbGetQuery(con, "select ward_data.district, ward_data.ward, 
Average_download_speed, Superfast_availability from broadband_data
join ward_data
on ward_data.ward_code = broadband_data.ward_code
where ward = 'Stanford'")
print (Question_6)



#7 Ward receiving max speed in every district
Question_7 <- dbGetQuery(con, "Select ward_data.district, ward_data.ward,  
Max(Speed_over_30_Mbps) as Customers_receiving_max_speed from broadband_data
join ward_data
on ward_data.ward_code = broadband_data.ward_code
Group by district")
print (Question_7)



#8 Average council tax of 3 bands in a particular wards
Question_8 <- dbGetQuery(con, "select ward_data.ward, ward_data.district,
((Band_A + Band_B + Band_C)/4) as Avg_of_three_bands from council_tax
join ward_data
on ward_data.ward_code = council_tax.ward_code
where  District = 'Oxford' and ward = 'Littlemore'")
print (Question_8)



#9 Difference between council tax charges of same band A but of two different wards.
Question_9 <- dbGetQuery(con, "select ward_data.district, (select council_tax.Band_A from council_tax
join ward_data on ward_data.ward_code = council_tax.ward_code
where ward = 'Blackbird Leys') -
(select council_tax.Band_A from council_tax
join ward_data on ward_data.ward_code = council_tax.ward_code
where ward = 'Littlemore') as difference_council_charges from ward_data
where District = 'Oxford'
group by 'District'
")
print (Question_9)




#10 Lowest council tax for Band B properties
Question_10 <- dbGetQuery(con, "select ward_data.district, ward_data.ward, min(Band_B) as Lowest_council_tax_Band_B from council_tax
join ward_data
on ward_data.ward_code = council_tax.ward_code")
print (Question_10)






