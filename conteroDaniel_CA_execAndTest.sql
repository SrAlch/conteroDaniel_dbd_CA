
--@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@        PROC TEST       @
--@@@@@@@@@@@@@@@@@@@@@@@@@@@

--Testing the Proc newCustomer--
EXEC newCustomer @ppsn = '0213123DB',
				@firstName = 'Gustavo',
				@middleName = NULL,
				@lastName = 'Cerezo',
				@lastName02 = 'Gila',
				@phone = '+353445345656',
				@email = 'gustavo69@hotmail.com',
				@addressLn01 = '45, somewhere somewhere, somewhere',
				@addressLn02 = NULL,
				@country = 'Ireland',
				@zipCode = 'D08F998',
				@nationality = 'Italian',
				@birthDate = '1984-05-12',
				@gender = 'Male',
				@status = 'Active'
GO

--Testing the Proc NewEmployee--
EXEC newEmployee @ppsn = '564345345FG',
				@firstName = 'Sara',
				@middleName = NULL,
				@lastName = 'Galindo',
				@lastName02 = NULL,
				@phone = '+353657058545',
				@email = 'theSara33@gmail.com',
				@addressLn01 = '67, somewhere around here, somewhere',
				@addressLn02 = NULL,
				@country = 'Ireland',
				@zipCode = 'D08F998',
				@nationality = 'Venezuelan',
				@birthDate = '1994-05-12',
				@gender = 'Female',
				@status = 'Active',
				@deptID = 'SLS002',
				@salary = '20000',
				@startDate = '2005-02-12',
				@siniority = 'Mid'
GO


--Testing the Proc addCar--
EXEC addCar @serialNumber = '1HGCR2F3XEA153973',
			@brand = 'Ford',
			@model = 'Edge',
			@fuelType = 'Gasoline',
			@year = '2008',
			@version = '250cv supercharged',
			@condition = 'Used',
			@kms = '200000',
			@preOwners = '2',
			@extras = 'Air con, Alloy wheels 21", Tinted windows',
			@stock = '1',
			@price = '30000'
GO

--Testing the Proc findClient--
DECLARE @clientPrint VARCHAR(20)

EXEC findClient @ppsn = '0213123DB', @clientID = @clientPrint OUTPUT
PRINT @clientPrint
GO

--Testing the Proc newTicket--
DECLARE @empID VARCHAR(20)
SELECT @empID = empID FROM employee WHERE ppsn = '564345345FG'
EXEC newTicket @serialNumber = '1HGCR2F3XEA153973',
				@ppsn = '0213123DB',
				@empID = @empID,
				@serviceDesc = 'TEST 01 Description'
GO

--Testing the Proc closeTicket--
DECLARE @ticketID VARCHAR(20)
SELECT @ticketID = ticketID FROM ticket WHERE serviceDesc='TEST 01 Description'

EXEC closeTicket @ticketID
GO

--Testing the Proc newSale--
DECLARE @empID VARCHAR(20)
SELECT @empID = empID FROM employee WHERE ppsn = '564345345FG'
EXEC newSale @serialNumber = '1HGCR2F3XEA153973',
			 @ppsn = '0213123DB',
			 @empID = @empID,
			 @finance = '0'
GO

--Testing the Function stockChecking--
DECLARE @result VARCHAR(20)

SELECT @result = dbo.stockChecking ('1HGCR2F3XEA153973')
PRINT @result
GO

--Testing the Proc create department--
EXEC createDepartment 'DPM001', 'Department Test'
GO

--Testing the Proc addpayment--
--CARD Version--
DECLARE @cardID INT

EXEC addPaymentMethod @ppsn = '0213123DB', 
					  @paymentMethod = 'Card',
					  @cardNumber = '6546546546546465465',
					  @valDate = '2025-04-01',
					  @ccv = '986',
					  @result = @cardID OUTPUT
PRINT @cardID
GO

--Testing the Proc addpayment--
--BANK Version--
DECLARE @bankID INT

EXEC addPaymentMethod @ppsn = '0213123DB', 
					  @paymentMethod = 'Bank',
					  @iban = 'IE42VZTC14709399610053',
					  @swiftCode = 'AIBKIE2DXXX',
					  @result = @bankID OUTPUT
PRINT @bankID
GO

--Testing the Proc get payment Method--
EXEC getClientPaymentMethod '0213123DB', 'Bank', '1'
GO

--Testing the Proc newInvoice--
--Creating new CARD version--

DECLARE @empID VARCHAR(20)
SELECT @empID = empID FROM employee WHERE ppsn = '564345345FG'

EXEC newInvoice @clientPPSN = '0213123DB', @empID = @empID, @goodType = 'Sale', @paymentMethod = 'Card',
@newMethod = 1, @cardNumber= '5867864434354312', @valDate = '2026-04-01', @ccv = '563', @finalAmount = '200000'
GO

--Testing the Proc customerDelete--
EXEC customerDeleteGDPR @ppsn = '0213123DB'
GO


--@@@@@@@@@@@@@@@@@@@@@@@@@@@
--@        VIEWS TEST       @
--@@@@@@@@@@@@@@@@@@@@@@@@@@@

SELECT * FROM [Ticket Report]

SELECT * FROM [Mechanic Report]

SELECT * FROM [Car Report]

SELECT * FROM [Inactive Customers]
