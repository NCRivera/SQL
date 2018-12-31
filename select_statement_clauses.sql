USE TSQLV4;

SELECT empid, YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate)
		HAVING COUNT(*) > 1
		ORDER BY empid, orderyear;
-- Logical order of queries is FROM, WHERE, GROUP BY, HAVING, SELECT, ORDER BY.

SELECT orderid, custid, empid, orderdate, freight
FROM Sales.Orders; 
-- Be explicit the SCHEMA.TABLE

SELECT orderid, custid, empid, orderdate, freight
FROM Sales.Orders
	WHERE custid = 71; -- If predicate (custid = 71) evaluates TRUE, return row.
-- Since T-SQL is based on three-valued predicate logic: TRUE, FALSE, and UNKNOWN.

SELECT empid, YEAR(orderdate) AS 'orderyear'
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate);
-- GROUP BY creates a unique combination of its elements.
-- HAVING, SELECT, ORDER BY phases operate on the grouped values

SELECT 
	empid, 
	YEAR(orderdate) AS 'orderyear', 
	SUM(freight) AS totalfreight,
	COUNT(*) AS numorders
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate);
-- Any aggragating functions need not be in the GROUP BY CLAUSE.

SELECT 
	empid, 
	YEAR(orderdate) AS 'orderyear', 
	COUNT(DISTINCT custid) AS numcusts
FROM Sales.Orders
	GROUP BY empid, YEAR(orderdate); -- 27 ROWS
-- DISTINCT keyword can be used within aggregate functions.

SELECT 
	empid, 
	YEAR(orderdate) AS 'orderyear' 
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate)
		HAVING COUNT(*) > 1;
-- HAVING clause works on aggregate functions.

SELECT empid, YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate)
		HAVING COUNT(*) > 1;
-- Logically Aliases do not exist yet when the SELECT clause is processed.

SELECT 
	orderid, YEAR(orderdate) AS orderyear 
FROM Sales.Orders 
	WHERE orderyear > 2015; -- Processed before SELECT.
-- ERROR: Invalid column name 'orderyear'. 
-- FIX: Specify WHERE clause as it is in the SELECT clause.

SELECT empid, YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate)
		HAVING numorders > 1; -- Processed before SELECT.
-- ERROR: Invalid column name 'numorders'. 
-- FIX: Specify HAVING clause as it is in the SELECT clause.

SELECT empid, YEAR(orderdate) AS orderyear, COUNT(*) AS numorders
FROM Sales.Orders
	WHERE custid = 71
	GROUP BY empid, YEAR(orderdate)
		HAVING COUNT(*) > 1
		ORDER BY empid, orderyear; -- DESC order is default.
-- Presentation order is guaranteed by the ORDER BY clause.

SELECT TOP (5) orderid, orderdate, custid, empid
FROM Sales.Orders
	ORDER BY orderdate DESC, orderid DESC;
-- TOP keyword specifies  first 5 results.

SELECT TOP (5) WITH TIES orderid, orderdate, custid, empid
FROM Sales.Orders
	ORDER BY orderdate DESC;
-- Experimented with this query, very much is subjective. 
-- Can change depending on ORDER BY clause.

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
	ORDER BY orderdate, orderid
	OFFSET 50 ROWS FETCH NEXT 5 ROWS ONLY;
-- I wonder the use cases for this, I'm curious.
