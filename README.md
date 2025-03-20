# SALES-ANALYSIS | EXPLORATORY DATA ANALYSIS


### **Project Summary**

This project focuses on cleaning and preparing sales data using SQL Server to ensure accuracy and consistency. After data cleaning, an exploratory data analysis (EDA) is conducted in Power BI to uncover insights and trends. The aim is to demonstrate proficiency in SQL for data transformation and Power BI for visualization and storytelling.


### **Key Technologies**

- SQL Server
- Transact-SQL
- SQL Server Management Studio (SSMS)
- Power BI
- Power Query
- DAX

### **Skills Highlighted**

- Data Cleaning & Transformation
- SQL Querying & Optimization
- Power BI Data Visualization
- Outlier Detection & Handling
- ETL (Extract, Transform, Load) Processes

### Methodology

**Step 1: Data Ingestion**

- Created a new database (`portfolio`) and loaded sales data into a table (`SalesB`).
- The Initial Data consisted of 541,909 records of transaction from December 2010 to December 2011. The data columns include;  `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `UnitPrice`, `CustomerID`, and `Country`
- Used the `SELECT INTO` statement to create a working copy of the data for cleaning.

**Step 2: Handling Missing and Invalid Data**

- Identified non-numeric values in the `Quantity` column using `ISNUMERIC()` and converted it to an integer.
- Removed records with negative or zero quantity.
- Checked for missing or invalid values in `UnitPrice` and replaced zero values with the average price per `StockCode` using an `AVG()` function within a `JOIN`.
- Deleted rows where `UnitPrice` was missing or non-positive.

**Step 3: Cleaning Text Fields**

- Removed records with misleading or test descriptions such as 'Adjust', 'Sample', and 'Test'.
- Ensured `StockCode` values were properly formatted and not null.
- Verified that the `Country` column contained only valid country names using `ISNUMERIC()` to detect anomalies.

**Step 4: Outlier Detection and Handling**

- Used the **Z-score method** (`AVG()` and `STDEV()` functions with `OVER()`) to detect extreme values in `Quantity`.
- Removed transactions with excessively high quantities (`>500`).
- Flagged items with unusually high `UnitPrice` (`>1000`).
- Removed records related to administrative fees and postage charges to maintain focus on product sales.

**Step 5: Handling Duplicates**

- Identified duplicate records based on `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `UnitPrice`, `CustomerID`, and `Country`.
- Used the `ROW_NUMBER()` function to retain only the first occurrence of each unique transaction.
- Dropped the original table and renamed the cleaned version to `SalesB` using `EXEC sp_rename`.
- The final data had **522,316** records.

**Step 6: Data Exploration in Power BI**

- Imported the cleaned dataset into Power BI.
- Created summary visualizations such as:
    - Total sales and Quantity trends over time.
    - Best-selling, Least Selling products, and top revenue-generating items.
    - top revenue-generating customers
    - Geographical distribution of sales.
    - Average unit price and quantity distributions.
    - Product performance
- Filters and slicer functionalities were used for interactive exploration.
