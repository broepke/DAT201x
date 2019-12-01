--Use a subquery to get the product name and unit price of products from the
--Products table which have a unit price greater than the average unit price
--from the Order Details table.

--Note that you need to use [Order Details] since the table name contains whitespace.

SELECT ProductName, AVG(UnitPrice) as aup FROM dbo.Products   GROUP BY ProductName
HAVING  AVG(UnitPrice)   >
   (SELECT AVG(UnitPrice) aup
   FROM dbo.[Order Details]
   )  ;


--Select from the Employees and Orders tables. Use a subquery to get the
--first name and employee ID for employees who were associated with
--orders which shipped from the USA.

SELECT FirstName, EmployeeID FROM dbo.Employees as e
WHERE EmployeeID in
	(SELECT EmployeeID FROM dbo.Orders as o
WHERE ShipCountry = 'USA'
);


--Create a new temporary table called ProductNames which has one field called
--ProductName (a VARCHAR of max length 40). Insert into this table the names of
--every product from the Products table. Select all columns from the
--ProductNames table you created.

--Note: you need to specify the Products table as Products, not dbo.Products.

declare @ProductNames table (ProductName varchar(40))
insert into @ProductNames SELECT ProductName FROM dbo.Products
SELECT * FROM @ProductNames ;
