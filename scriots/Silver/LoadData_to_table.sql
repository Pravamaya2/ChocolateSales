-- Insert data into Silver Customer Dimension table

INSERT INTO silver.customer_dimension (
Customer_ID,
Customer_Name,
DOB,
Gender,
Location,
Loyalty_Status
)
SELECT 
Customer_ID,
TRIM(Customer_name) as Customer_Name,
DOB,
CASE WHEN UPPER(TRIM(Gender)) ='M' THEN 'Male'
     WHEN UPPER(TRIM(Gender)) = 'F' THEN 'Female'
	 ELSE 'Unknown'
	 END AS Gender,          -- Normalize Gender values to readable format
TRIM(Location) as Location,
TRIM(Loyalty_Status) as Loyalty_Status
FROM 
(SELECT *,
ROW_NUMBER () OVER(Partition by customer_id order by Customer_name Desc) as flag_last
FROM bronze.customer_dimension) X
WHERE flag_last =1      -- Select most recent record per customer


--Insert data Into Location Dimension table

INSERT INTO silver.location_dimension(
Location_ID,
City,
Country)
SELECT 
  DISTINCT Location_ID,
  TRIM(City) AS City,
  UPPER(TRIM(Country)) AS Country
FROM bronze.Location_dimension
WHERE Location_ID IS NOT NULL;

-- Insert Load data into Silver Product Dimension Table
INSERT INTO silver.product_dimension(
Product_ID,
Product_Name,
Chocolate_Type,
Cocoa_Content,
Brand,
Origin_Region,
Cost
)
SELECT 
DISTINCT Product_ID,
REPLACE(Product_Name, '-Chocolate', '') AS Product_Name,
TRIM(Chocolate_Type) As Chocolate_Type,
Cocoa_Content,
TRIM(Brand) AS Brand,
TRIM(Origin_Region) AS Origin_Region,
Cost
from bronze.product_dimension
where Product_ID IS NOT NULL

  --Insert Load data into Silver_Sales_Fact_Table

INSERT INTO silver.sales_fact_table(
Date,
Location_ID,
Product_ID,
Customer_ID,
Quantity_Sold
)
SELECT * 
FROM bronze.sales_fact_table
WHERE Location_ID IS NOT NULL
AND Product_ID IS NOT NULL
AND Customer_ID IS NOT NULL
