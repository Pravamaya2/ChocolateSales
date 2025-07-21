	
--Percentage of Sales by each Loyalty Status	
	SELECT 
    loyalty_status,
    SUM(quantity_sold * cost) AS sales_amount,
    ROUND((SUM(quantity_sold * cost)*1.0 / total.total_sales)*100,2) AS percent_of_total_sales
FROM [ChocolateSales].[gold].[sales_chocolate],
     (SELECT SUM(quantity_sold * cost) AS total_sales 
      FROM [ChocolateSales].[gold].[sales_chocolate]) AS total
GROUP BY loyalty_status, total.total_sales;


--If you will select Silver as 100% then get the other sales percentage

 WITH loyalty_sales as
 (SELECT Loyalty_Status, SUM(Quantity_Sold*Cost) as sales_amount
   FROM [ChocolateSales].[gold].[sales_chocolate]
   Group by Loyalty_Status
   ),
    Platinum_Sales_cte as
	   (SELECT Loyalty_Status, sum(Quantity_Sold*Cost) as platinum_sales
	    FROM [ChocolateSales].[gold].[sales_chocolate]
	    where loyalty_status = 'platinum'
	    group by loyalty_status)
  select ls.loyalty_status, ls.sales_amount,Round(((ls.sales_amount*1.0/ps.platinum_sales)*100),2) as percent_sales
  from loyalty_sales ls,platinum_sales_cte ps
  order by sales_amount DESC

--  Purchase as per gender
 
WITH sales_gender as(	
	select Gender, SUM(quantity_sold*cost) as Sales_Amount
		from gold.sales_chocolate
		group by Gender),
	total_sales_cte as(
	select 
	SUM(quantity_sold*cost) as total_amount
	from gold.sales_chocolate)

	select 
	   sg.gender,
	   sg.Sales_Amount,
	   Round((sg.sales_amount * 1.0/ts.total_amount)*100,2) as percent_sales
	from sales_gender sg, total_sales_cte ts

-- Sales of Top 5 customer in festivl season
WITH ranked_customer as
	(SELECT Customer_Name, 
	    SUM(Quantity_sold*cost) as Sales,
		ROW_NUMBER() OVER (ORDER BY SUM(Quantity_sold*cost) DESC) AS rn
	    from gold.sales_chocolate
		Where Date between '2021-09-01' and '2021-12-31'
		Group by Customer_Name
		)
  SELECT Customer_Name, Sales
    from ranked_customer
	where rn <=5

-- Month-wise Sales ($) Trend for different brand

select month(Date) as Month,brand, sum(Quantity_sold*Cost) as Sales_Amount
from gold.sales_chocolate
group by month(Date),brand 
order by month(Date),sum(Quantity_sold*Cost)

-- Monthwise Sales ($) Trend for different loyalty Staus
select month(Date) as Month,Loyalty_Status, sum(Quantity_sold*Cost) as Sales_Amount
from gold.sales_chocolate
group by month(Date),Loyalty_Status 
order by month(Date),sum(Quantity_sold*Cost)
