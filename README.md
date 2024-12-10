# Data Exploration and Modeling: Housing, Broadband, and Council Tax in Oxfordshire

This project explores housing prices, broadband data, and council tax information in Oxfordshire. The data is preprocessed, cleaned, and modeled into a normalized relational database for efficient querying and analysis. The project employs R and SQL for database creation and data exploration.

## Overview

The project analyzes data from reliable government sources, such as:
- **Housing Prices**: House prices by ward.
- **Broadband Data**: Availability and speed metrics.
- **Council Tax**: Tax bands from Band A to Band H.

The project involves:
- Data cleaning and preprocessing in Excel.
- Database normalization to 3NF (Third Normal Form).
- SQL-based querying for data exploration.
- Integration of SQL databases into R for further analysis.

## Features

1. **Data Sources**:
   - Housing data: [ONS Median House Prices Dataset](https://www.ons.gov.uk/peoplepopulationandcommunity/housing/datasets/medianpricepaidbywardhpssadataset37)
   - Broadband data: [Parliament Broadband Data](https://commonslibrary.parliament.uk/constituency-data-broadband-coverage-and-speeds/)
   - Council Tax: [Oxford City Council](https://www.oxford.gov.uk/info/20152/council_tax_bands_and_charges/120/council_tax)

2. **Database Design**:
   - Four normalized tables for ward, housing, broadband, and council tax data.
   - Use of primary and foreign keys for relational mapping.
   - One-to-one and one-to-many relationships between tables.

3. **Tools and Technologies**:
   - SQL: For creating the database and running queries.
   - R: Integration with the SQLite database using `RSQLite` and `DBI` packages.


## Implementation Steps

1. **Data Preprocessing**:
   - Filtering and organizing data using Excel.
   - Adding district and ward codes for relational mapping.

2. **Database Creation**:
   - Using SQL to structure data into normalized tables (1NF to 3NF).

3. **Data Integration in R**:
   - Connecting R to SQLite.
   - Importing data using `read.csv` and exporting using `dbWriteTable`.
   - Running SQL queries in R using `dbGetQuery`.

