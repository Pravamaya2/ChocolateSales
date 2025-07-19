PRINT('*************Silver Layer****************')
	PRINT('-------------------------------------------------');
	PRINT(' CREATE Customer Dimension table');
	PRINT('-------------------------------------------------');

	IF OBJECT_ID ('silver.customer_dimension', 'U') IS NOT NULL
		DROP TABLE silver.customer_dimension
	CREATE TABLE silver.customer_dimension(
		Customer_ID INT,
		Customer_Name nvarchar(50),
		DOB DATE,
		Gender nvarchar(50),
		Location NVARCHAR(50),
		Loyalty_Status nvarchar(50),
		dwh_create_date DATETIME2 DEFAULT GETDATE()
	);

	PRINT('-------------------------------------------------');
	PRINT(' CREATE Location Dimension table');
	PRINT('-------------------------------------------------');

	IF OBJECT_ID ('silver.location_dimension', 'U') IS NOT NULL
		DROP TABLE silver.location_dimension
	CREATE TABLE silver.location_dimension(
		Location_ID nvarchar(50),
		City nvarchar(50),
		Country nvarchar(50),
		dwh_create_date DATETIME2 DEFAULT GETDATE()
	);


	PRINT('-------------------------------------------------');
	PRINT(' CREATE Product Dimension table');
	PRINT('-------------------------------------------------');
	IF OBJECT_ID ('silver.product_dimension', 'U') IS NOT NULL
		DROP TABLE silver.product_dimension
	CREATE TABLE silver.product_dimension(
		Product_ID int,
		Product_Name nvarchar(50),
		Chocolate_Type nvarchar(50),
		Cocoa_Content int,
		Brand nvarchar(50),
		Origin_Region nvarchar(50),
		Cost int,
		dwh_create_date DATETIME2 DEFAULT GETDATE()
		);


	PRINT('-------------------------------------------------');
	PRINT(' CREATE Sales Fact Table table');
	PRINT('-------------------------------------------------');
	IF OBJECT_ID ('silver.sales_fact_table', 'U') IS NOT NULL
		DROP TABLE silver.sales_fact_table
		CREATE TABLE silver.sales_fact_table(
		Date DATE,
		Location_ID INT,
		Product_ID INT,
		Customer_ID INT,
		Quantity_Sold INT,
		dwh_create_date DATETIME2 DEFAULT GETDATE()
		);
