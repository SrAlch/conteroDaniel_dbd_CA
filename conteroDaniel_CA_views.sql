CREATE VIEW [Ticket Report]
AS
SELECT ticketID AS [Ticket Number], ticket.serialNumber AS [Serial Number], car.brand + ' ' + car.model AS [Vehicle],
ticket.clientID AS [Protected Client Identity], users.firstName + ' ' + users.lastName AS [Mechanic Name],
ticket.serviceDesc AS [Service Description], dateStart AS [Date Start], dateFinish AS [Date Finish], ticket.[status] AS [Service Status]
FROM ticket
INNER JOIN employee ON ticket.empID = employee.empID
INNER JOIN users ON employee.ppsn = users.ppsn
INNER JOIN car ON ticket.serialNumber = car.serialNumber
WHERE DATEDIFF(DAY,dateFinish, GETDATE())/30.42 < 3 OR DATEDIFF(DAY,dateStart, GETDATE())/30.42 < 3
GO

CREATE VIEW [Mechanic Report]
AS
SELECT DISTINCT employee.empID AS [Employee ID], users.firstName + ' ' + users.lastName AS [Mechanic Name],
COUNT(ticket.ticketID) AS [Number of Tickets], COUNT(DISTINCT ticket.serialNumber) AS [Unique Cars Serviced],
employee.internalEmail AS [Company Email], employee.siniority AS [Siniority],
CAST(GETDATE() AS VARCHAR(12)) + ' to ' + CAST(DATEADD(MONTH, -2, GETDATE())AS VARCHAR(12)) AS [Inspected Time Range]
FROM employee
INNER JOIN users ON employee.ppsn = users.ppsn
INNER JOIN ticket ON employee.empID = ticket.empID
WHERE DATEDIFF(DAY,ticket.dateFinish, GETDATE())/30.42 < 3 OR DATEDIFF(DAY,ticket.dateStart, GETDATE())/30.42 < 3
GROUP BY employee.empID, users.firstName, users.lastName, employee.internalEmail, employee.siniority
GO

CREATE VIEW [Car Report]
AS
SELECT DISTINCT ticket.serialNumber AS [Serial Number], car.brand + ' ' + car.model AS [Car],
car.[year] AS [Model Year], COUNT(ticket.ticketID) AS [Times Serviced In Period],
dbo.stockChecking(car.serialNumber) AS [Sold Here] 
FROM ticket
INNER JOIN car ON ticket.serialNumber = car.serialNumber
WHERE DATEDIFF(DAY,ticket.dateFinish, GETDATE())/30.42 < 3 OR DATEDIFF(DAY,ticket.dateStart, GETDATE())/30.42 < 3
GROUP BY ticket.serialNumber, car.brand, car.model, car.[year], car.serialNumber
GO


CREATE VIEW [Inactive Customers]
AS
SELECT users.firstName + ' ' + users.lastName AS [Client Name], users.email AS [Client Email],
users.phone AS [Client Phone], invoice.[date] AS [Last Interaction Date]
FROM client
INNER JOIN users ON client.ppsn = users.ppsn
INNER JOIN saleTotal ON client.clientID = saleTotal.clientID
INNER JOIN invoice ON saleTotal.saleID = invoice.saleID
WHERE DATEDIFF(DAY,invoice.[date], GETDATE())/30.42 > 13
GO

