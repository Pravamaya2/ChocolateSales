
	PRINT('-------------------------------------------------');
	PRINT(' CREATE Customer Dimension table');
	PRINT('-------------------------------------------------');

	IF OBJECT_ID ('bronze.customer_dimension', 'U') IS NOT NULL
		DROP TABLE bronze.customer_dimension
	CREATE TABLE bronze.customer_dimension(
		Customer_ID INT,
		Customer_Name nvarchar(50),
		DOB DATE,
		Gender nvarchar(50),
		Location nVARCHAR(50),
		Loyalty_Status nvarchar(50)
	);

	PRINT('-------------------------------------------------');
	PRINT(' CREATE Location Dimension table');
	PRINT('-------------------------------------------------');

	IF OBJECT_ID ('bronze.location_dimension', 'U') IS NOT NULL
		DROP TABLE bronze.location_dimension
	CREATE TABLE bronze.location_dimension(
		Location_ID nvarchar(50),
		City nvarchar(50),
		Country nvarchar(50)
	);


	PRINT('-------------------------------------------------');
	PRINT(' CREATE Product Dimension table');
	PRINT('-------------------------------------------------');
	IF OBJECT_ID ('bronze.product_dimension', 'U') IS NOT NULL
		DROP TABLE bronze.product_dimension
	CREATE TABLE bronze.product_dimension(
		Product_ID int,
		Product_Name nvarchar(50),
		Chocolate_Type nvarchar(50),
		Cocoa_Content int,
		Brand nvarchar(50),
		Origin_Region nvarchar(50),
		Cost int
		);


	PRINT('-------------------------------------------------');
	PRINT(' CREATE Sales Fact Table table');
	PRINT('-------------------------------------------------');
	IF OBJECT_ID ('bronze.sales_fact_table', 'U') IS NOT NULL
		DROP TABLE bronze.sales_fact_table
		CREATE TABLE bronze.sales_fact_table(
		Date DATE,
		Location_ID INT,
		Product_ID INT,
		Customer_ID INT,
		Quantity_Sold INT
		);
