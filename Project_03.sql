create database RetailSalesDB
use RetailSalesDB

create table products(ProductID int primary key,ProductName Varchar(100),
					  Category varchar(50),Price Decimal(10,2))

Create table Sales(SalesID int primary key, ProductID int, CustomerID int,
                   SalesDate datetime, Quantity int references products(productID))

create table customers(customerID int primary key , firstname char(10), lastname char(10),Email varchar(100))

insert into products(ProductID, ProductName, category, Price) values
(1,'Laptop','Elcetronics',1000.00),(2,'Smartphone','Electronics',500.00),
(3,'Headphones','Accessories',150.00),(4,'Mouse','Accessories',25.00)

insert into customers(customerID,firstname,lastname,Email) values
(1,'John','Doe','johndoe@email.com'),
(2,'Jane','Smith','janesmith@email.com'),
(3,'Bob','Johnson','bobjohnson@gmail.com')

insert into sales(salesID,ProductID,CustomerID,SalesDate,Quantity) values
(1,1,1,'2023-08-01',2),
(2,2,2,'2023-08-03',1),
(3,3,1,'2023-08-03',3),
(4,4,3,'2023-08-04',4),
(5,1,3,'2023-08-05',1)

select * from Sales

select s.salesID, p.ProductName, c.FirstName, c.LastName, s.Quantity
from sales as s inner join products as p on s.ProductID=p.ProductID
inner join customers as c on s.CustomerID=c.customerID
order by s.SalesDate

select p.productName, sum(s.Quantity) as totalsales from sales as s 
inner join products as p on s.ProductID=p.ProductID
group by p.ProductName
order by totalsales

select c.FirstName, c.LastName, COUNT(s.salesID) as NumberofPurchases
from sales as s inner join customers as c on s.CustomerID=c.customerID
group by c.firstname, c.lastname
order by NumberofPurchases desc

select ProductName from products
where ProductID in(select ProductID from Sales
group by ProductID 
having SUM(Quantity)>1)

select p.productname, count(s.salesID) as salescount
from sales as s inner join products as p on s.ProductID=p.ProductID
group by p.ProductName 
having count(s.salesID)>5
order by salescount desc

select s.salesID, p.productname, c.Firstname, c.Lastname, s.Quantity
from sales as s inner join products as p on s.ProductID=p.ProductID
inner join customers as c on s.CustomerID=c.customerID
order by s.SalesDate
offset 0 rows 
fetch next 10 rows only

select p.category, COUNT(distinct c.customerID) as totalcustomers,
sum(s.Quantity) as totalsales,
MAX(p.ProductName) as TopsellingProduct
from sales as s inner join products as p on s.ProductID=p.ProductID
inner join customers as c on s.CustomerID = c.customerID
group by p.Category
order by totalsales desc
