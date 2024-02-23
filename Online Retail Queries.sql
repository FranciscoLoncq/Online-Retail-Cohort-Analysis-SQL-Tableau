--Cleaning Data

--Total Records = 541909
SELECT count(*)
  FROM [PortfolioDB].[dbo].[Online Retail]

 --Looking for Null Values
 --135080 Records have no customerID
 SELECT count(*)
  FROM [PortfolioDB].[dbo].[Online Retail]
  where customerID IS NULL

--406829 Records Have CustomerID
SELECT count(*)
  FROM [PortfolioDB].[dbo].[Online Retail]
  where customerID != 0

--Creating CTE to keep useful rows in the dataset
--Removing records where Quantity and Unit Price are greater than 0
;WITH online_retail AS
(
	SELECT [InvoiceNo]
      ,[StockCode]
      ,[Description]
      ,[Quantity]
      ,[InvoiceDate]
      ,[UnitPrice]
      ,[CustomerID]
      ,[Country]
  FROM [PortfolioDB].[dbo].[Online Retail]
  WHERE customerID != 0
  )
  , quantity_unit_price AS 
  (
--397884 Records kept with Qty and UnitPrice
  SELECT *
  FROM online_retail
  WHERE Quantity > 0 
  AND UnitPrice > 0
  )
, duplicate_check AS 
(
 ---duplicate check
SELECT *, ROW_NUMBER() OVER(PARTITION BY InvoiceNo, StockCode, Quantity ORDER BY InvoiceDate) dup_flag
FROM quantity_unit_price
)
--392669 records in clean data
--5215 Duplicated Records
--Passing clean data into a temp table for better simplicity
SELECT *
INTO #online_retail_clean
FROM duplicate_check
WHERE dup_flag = 1

--Clean Dataset
--We can start our Cohort analysis
SELECT *
FROM #online_retail_clean

--Required information for creating cohort group
--Unique ID for variable we will perform the analysis needed (CustomerID)
--Initial Start Date (First Invoice Date)
--Revenue Data

SELECT
	CustomerID,
	CAST(MIN(InvoiceDate)AS date) AS first_invoice_date,
	DATEFROMPARTS(year(min(InvoiceDate)),month(min(InvoiceDate)), 1) AS Cohort_Date
--Putting Cohort Result into another temp table
	into #cohort
	FROM #online_retail_clean
	GROUP BY CustomerID

SELECT * 
FROM #cohort

--Retention Analysis

--Create Cohort Index (Number of months passed since customer first purchase)
--Creating subqueries
SELECT 
	rrr.*,
	cohort_index = year_diff * 12 + month_diff + 1
	into #cohort_retention
FROM
	(
		SELECT 
		rr.*,
		year_diff = invoice_year - cohort_year,
		month_diff = invoice_month - cohort_month
	FROM 
		(
			SELECT 
			o.* ,
			c.cohort_date,
			year(o.InvoiceDate) AS invoice_year,
			month(o.InvoiceDate) AS invoice_month, 
			year(c.Cohort_Date) AS cohort_year,
			month(c.Cohort_Date) AS cohort_month
		FROM #online_retail_clean o
		LEFT JOIN #cohort c
		ON o.customerID = c.customerID) rr
		) rrr
--where CustomerID = 14733

select * from #cohort_retention

--creating cohort table
--pivoting data
SELECT *
into #cohort_pivot
FROM (
SELECT DISTINCT CustomerID,
				Cohort_date,
				cohort_index
FROM #cohort_retention
)cohort_table
pivot(
	Count(CustomerID)
	for cohort_index IN
	(
	[1],
	[2],
	[3],
	[4],
	[5],
	[6],
	[7],
	[8],
	[9],
	[10],
	[11],
	[12],
	[13])

)as pivot_table
ORDER BY Cohort_Date
--we need to know how many cohort indexes we have
SELECT DISTINCT cohort_index
FROM #cohort_retention
ORDER BY 1

--creating table with cohort rate

SELECT 
1.0 * [1]/[1] * 100 AS [1], 
1.0 * [2]/[1] * 100 AS [2], 
1.0 * [3]/[1] * 100 AS [3], 
1.0 * [4]/[1] * 100 AS [4],  
1.0 * [5]/[1] * 100 AS [5], 
1.0 * [6]/[1] * 100 AS [6],
1.0 * [7]/[1] * 100 AS [7], 
1.0 * [8]/[1] * 100 AS [8], 
1.0 * [9]/[1] * 100 AS [9], 
1.0 * [10]/[1] * 100 AS [10], 
1.0 * [11]/[1] * 100 AS [11], 
1.0 * [12]/[1] * 100 AS [12], 
1.0 * [13]/[1] * 100 AS [13]
FROM #cohort_pivot
ORDER BY Cohort_Date