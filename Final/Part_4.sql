
--1 Use CHOOSE() and MONTH() to get the season in which each order was
--shipped from the Orders table. You should select the order ID,
--shipped date, and then the season aliased as ShippedSeason.
--You can copy and paste the below into your query.

--'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Autumn', 'Autumn', 'Autumn', 'Winter'
--Be careful to filter out any NULL shipped dates.


SELECT OrderID, ShippedDate, CHOOSE(MONTH(ShippedDate),'Winter', 'Winter', 'Spring', 'Spring', 'Spring', 'Summer', 'Summer', 'Summer', 'Autumn', 'Autumn', 'Autumn', 'Winter') AS ShippedSeason
FROM dbo.Orders
WHERE ShippedDate IS NOT NULL;

--2 Using the Suppliers table, select the company name and use a simple
--IIF expression to display 'outdated' if a company has a fax number, or
--'modern' if it doesn't. Alias the result of the IIF expression to Status.

SELECT CompanyName, IIF (FAX IS NULL, 'modern', 'outdated') AS Status
FROM dbo.Suppliers

--3 Select from the Customers, Orders, and Order Details tables.
-- Note that you need to use [Order Details] since the table name contains
-- whitespace.

--Use GROUP BY and ROLLUP() to get the total quantity ordered by all
-- countries, while maintaining the total per country in your result set.

--Your first column should be the country, and the second column the
--total quantity ordered by that country, aliased as TotalQuantity.

Select c.country, sum(od.quantity) as TotalQuantity from customers c join orders o on c.customerid=o.customerid join [order details] od on o.orderid=od.orderid
group by Rollup (Country);

--4(not sure)
--From the Customers table, use GROUP BY to select the country,
--contact title, and count of that contact title aliased as Count,
--grouped by country and contact title (in that order).

--Then use CASE WHEN, GROUPING_ID(), and ROLLUP() to add a column called
--Legend, which shows one of two things:

--When the GROUPING_ID is 0, show '' (i.e., nothing)
--When the GROUPING_ID is 1, show Subtotal for << Country >>'
--Do not use ORDER BY to order your results.

SELECT Country, ContactTitle, COUNT(ContactTitle) AS Count,  CASE WHEN GROUPING_ID(country, contacttitle) = 0 THEN '' WHEN GROUPING_ID( country, contacttitle) = 1 THEN count(ContactTitle) END AS Legend
FROM dbo.Customers
GROUP BY ROLLUP( Country, ContactTitle)

--5 Convert the following query to be pivoted, using PIVOT().

--SELECT CategoryID, AVG(UnitPrice)
--FROM Products
--GROUP BY CategoryID;

--Your result set should look like this:

--Per Category	1	2	3	4	5	6	7	8
--Average Unit Price	37.98	23.06	25.16	28.73	20.25	54.01	32.37	20.68
--QUERY.SQL


--??

--Try Code

--Submit Answer (1)
--UERY RESULT
--DBO.PRODUCTS

--pivot
SELECT 'Average Unit Price' AS 'Per Category',
[1], [2], [3], [4],[5],[6],[7],[8]
FROM
(SELECT CategoryID, UnitPrice
    FROM Products) AS SourceTable
PIVOT
(
AVG(UnitPrice)
FOR CategoryID IN ([1], [2], [3], [4],[5],[6],[7],[8])
) AS PivotTable;


--6. Insert into the Region table the region ID 5 and the description 'Space'.
--Then, in a second query, select the newly inserted data from the table
--using a WHERE clause.

INSERT INTO dbo.Region (RegionID, RegionDescription)
VALUES (5, 'Space');

SELECT * from dbo.Region where RegionID=5 and RegionDescription='Space'



--7 Update the region descriptions in the Region table to be all uppercase,
-- using SET and UPPER().
--Next, select all data from the table to view your updates.

SELECT RegionID,
  UPPER(RegionDescription) AS RegionDescription
FROM
  dbo.Region


--8 Declare a custom region @region called 'Space', of type NVARCHAR(25).

--Use IF NOT EXISTS, ELSE, and BEGIN..END to throw an error message 'Error!'
-- if @region is not in the Region table. Do this check using SELECT *.

--If the specified description does exist, you should select all columns
-- for that region from the Region table.

--Note: you need to specify the Region table as Region, not dbo.Region.

DECLARE @error  VARCHAR(25);
SET @error='Error!'

IF NOT EXISTS (Select 1 From dbo.Region WHERE RegionDescription='Space')
BEGIN
RAISERROR(@Error, 10, 1);
END

ELSE
BEGIN
SELECT RegionDescription from dbo.Region
END
