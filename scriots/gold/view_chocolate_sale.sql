IF OBJECT_ID ('gold.sales_chocolate', 'V') IS NOT NULL
	DROP VIEW gold.sales_chocolate;
GO

	CREATE VIEW gold.sales_chocolate
	AS

		SELECT 
			s.Date as Date,
			s.Location_ID as location_ID,
			s.Product_ID as Product_ID,
			s.Customer_ID as Customer_ID,
			S.Quantity_sold as Quantity_Sold,
			c.Customer_name as Customer_name,
			c.DOB as DOB,
			c.Gender as Gender,
			c.location as Location,
			c.Loyalty_Status as Loyalty_Status,
			l.City as city,
			l.Country as Country,
			p.Product_Name as Product_Name,
			p.Chocolate_Type as Chocolate_Type,
			p.Cocoa_Content as Cocoa_Content,
			p.Brand as Brand,
			p.Origin_Region as Origin_Region,
			p.Cost as Cost
		  FROM [ChocolateSales].[silver].[sales_fact_table] s
		  JOIN [ChocolateSales].[silver].[customer_dimension] c
		  ON s.Customer_ID=c.Customer_ID
		  JOIN [ChocolateSales].[silver].[location_dimension] l
		  on s.Location_ID = l.Location_ID
		  JOIN [ChocolateSales].[silver].[product_dimension] p
		  on s.Product_ID = p.Product_ID
		  Where s.Date IS NOT NULL
