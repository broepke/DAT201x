--Q1. Select the quantity per unit for all products in the Products table.
SELECT QuantityPerUnit FROM Products

--Q2.Select the unique category IDs from the Products table.
SELECT Distinct CategoryID FROM Products

--Q3. Select the names of products from the Products table which have more than 20 units left in stock.
SELECT ProductName FROM Products
WHERE UnitsInStock >20

--Q4. Select the product ID, product name, and unit price of the 10 most expensive products from the Products table.
SELECT TOP (10)
ProductID, ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

--Q5. Select the product ID, product name, and quantity per unit for all products in the Products table. Sort your results alphabetically by product name.
SELECT ProductID, ProductName, QuantityPerUnit
FROM Products
ORDER BY ProductName ASC

--Q6. Select the product ID, product name, and unit price of all products in the Products table. Sort your results by number of units in stock, from greatest to least.
--Skip the first 10 results and get the next 5 after that
SELECT ProductID, ProductName, UnitPrice FROM Products
ORDER BY UnitsInStock DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY

--Q7. Use STR and CONVERT where appropriate to display the first name, employee ID and birthdate (in ISO 8601 format) for each employee in the Employees table.
--Each result should be a single string in the following format, where each <<value>> is replaced by the appropriately converted value:
--<<FirstName>> has an EmployeeID of <<EmployeeID>> and was born <<BirthDate>>
SELECT FirstName +' has an EmployeeID of ' +
CAST(EmployeeID AS VarChar(5)) +' and was born ' +
CONVERT(NVARCHAR(30), BirthDate, 126) AS Employees
FROM Employees

--Q8. Select from the Orders table.
--The first column of your result should be a single string in exactly the following format:
--<<ShipName>> is from <<ShipCity or ShipRegion or ShipCountry>>
--If there is no ShipCity, then you should select ShipRegion, and if there is no ShipRegion you should select ShipCountry.
SELECT
ShipName + ' is from ' + COALESCE(ShipCity, ShipRegion,ShipCountry) AS destination
FROM Orders

--Q9. Select the ship name and ship postal code from the Orders table. If the postal code is missing, display 'unknown'.
SELECT
 ShipName, ISNULL(ShipPostalCode, 'unknown')
FROM Orders

--Q10. Using the Suppliers table, select the company name, and use a simple CASE expression to display 'outdated' if the company has a fax number, or 'modern' if it doesn't. Alias the result of the CASE expression to Status.

SELECT CompanyName,
    CASE
       WHEN Fax IS NULL THEN 'modern'
     ELSE 'outdated'
   END AS Status
FROM Suppliers;
