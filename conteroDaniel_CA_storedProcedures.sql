CREATE PROCEDURE errorHandling
AS
    SELECT   
        ERROR_NUMBER() AS ErrorNumber  
        ,ERROR_SEVERITY() AS ErrorSeverity  
        ,ERROR_STATE() AS ErrorState  
        ,ERROR_LINE () AS ErrorLine  
        ,ERROR_PROCEDURE() AS ErrorProcedure  
        ,ERROR_MESSAGE() AS ErrorMessage;
GO



CREATE PROCEDURE newCustomer( @ppsn VARCHAR(15),
							 @firstName NVARCHAR(20),
							 @middleName NVARCHAR(20),
							 @lastName NVARCHAR(20),
							 @lastName02 NVARCHAR(20),
							 @phone VARCHAR(30),
							 @email NVARCHAR(50),
							 @addressLn01 VARCHAR(100),
							 @addressLn02 VARCHAR(100),
							 @country VARCHAR(50),
							 @zipCode VARCHAR(10),
							 @nationality VARCHAR(15),
							 @birthDate VARCHAR(10),
							 @gender VARCHAR(10),
							 @status VARCHAR(15))
AS
SET XACT_ABORT ON
BEGIN TRY
	SELECT @birthDate = CAST(@birthDate AS DATE) 
	BEGIN TRANSACTION
	IF EXISTS(SELECT ppsn FROM users WHERE ppsn = @ppsn) AND
		NOT EXISTS(SELECT ppsn FROM client WHERE ppsn = @ppsn)
		BEGIN
			INSERT INTO dbo.client ([status], ppsn)
			VALUES (@status, @ppsn)
			PRINT N'The User already exist, added as client'
		END
	ELSE IF NOT EXISTS(SELECT ppsn FROM users WHERE ppsn = @ppsn) AND
			NOT EXISTS(SELECT ppsn FROM client WHERE ppsn = @ppsn)
		BEGIN
			INSERT INTO dbo.users (ppsn, firstName,	middleName, lastName, lastName02, phone, email, addressLn01,
								   addressLn02, country, zipCode, nationality, birthDate, gender)
			VALUES (@ppsn, @firstName, @middleName, @lastName, @lastName02, @phone, @email, @addressLn01, @addressLn02,
					@country, @zipCode, @nationality, @birthDate, @gender)

			INSERT INTO dbo.client ([status], ppsn)
			VALUES (@status, @ppsn)
			PRINT N'New user and client created'
		END
	ELSE
		BEGIN
			PRINT N'The user already has a client profile'
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE addCar @serialNumber VARCHAR(17),
						@brand NVARCHAR(15),
						@model NVARCHAR(15),
						@fuelType VARCHAR(10),
						@year VARCHAR(5),
						@version NVARCHAR(60),
						@condition VARCHAR(6),
						@kms VARCHAR(10),
						@preOwners VARCHAR(2),
						@extras NVARCHAR(300),
						@stock VARCHAR(1),
						@price VARCHAR(10)
AS
SET XACT_ABORT ON
BEGIN TRY
	SELECT @year = CAST(@year AS SMALLINT)
	SELECT @kms = CAST(@kms AS INT)
	SELECT @preOwners = CAST(@preOwners AS TINYINT)
	SELECT @stock = CAST(@stock AS BIT)
	SELECT @price = CAST(@price AS MONEY)
	BEGIN TRANSACTION
	IF EXISTS (SELECT serialNumber FROM car WHERE serialNumber = @serialNumber) AND
		NOT EXISTS (SELECT serialNumber FROM carDetail WHERE serialNumber = @serialNumber)
		BEGIN
			INSERT INTO dbo.carDetail(serialNumber, [version], condition, kms, prevOwners, extras, stock, price)
			VALUES (@serialNumber, @version, @condition, @kms, @preOwners, @extras, @stock, @price)
			PRINT N'The car is already in the DataBase, added Car Details for Stock'
		END
	ELSE IF NOT EXISTS (SELECT serialNumber FROM car WHERE serialNumber = @serialNumber) AND
			NOT EXISTS (SELECT serialNumber FROM carDetail WHERE serialNumber = @serialNumber)
		BEGIN
			INSERT INTO dbo.car (serialNumber, brand, model, fuelType, [year])
			VALUES (@serialNumber, @brand, @model, @fuelType, @year)

			INSERT INTO dbo.carDetail(serialNumber, [version], condition, kms, prevOwners, extras, stock, price)
			VALUES (@serialNumber, @version, @condition, @kms, @preOwners, @extras, @stock, @price)
			PRINT N'The car and it''s details has been added'
		END
	ELSE
		BEGIN
			PRINT N'The car and the details are already recorded'
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE newEmployee( @ppsn VARCHAR(15),
							 @firstName NVARCHAR(20),
							 @middleName NVARCHAR(20),
							 @lastName NVARCHAR(20),
							 @lastName02 NVARCHAR(20),
							 @phone VARCHAR(30),
							 @email NVARCHAR(50),
							 @addressLn01 VARCHAR(100),
							 @addressLn02 VARCHAR(100),
							 @country VARCHAR(50),
							 @zipCode VARCHAR(10),
							 @nationality VARCHAR(15),
							 @birthDate VARCHAR(10),
							 @gender VARCHAR(10),
							 @deptID VARCHAR(15),
							 @salary VARCHAR(10),
							 @status VARCHAR(15),
							 @startDate VARCHAR(10),
							 @siniority VARCHAR(20))

AS
SET XACT_ABORT ON
BEGIN TRY
	SELECT @birthDate = CAST(@birthDate AS DATE)
	SELECT @salary = CAST(@salary AS SMALLMONEY)
	SELECT @startDate = CAST(@startDate AS DATE)
	BEGIN TRANSACTION
		IF EXISTS(SELECT ppsn FROM users WHERE ppsn = @ppsn) AND
			NOT EXISTS(SELECT ppsn FROM employee WHERE ppsn = @ppsn)
		BEGIN
			INSERT INTO dbo.employee (ppsn, deptID, salary, [status], startDate, siniority)
			VALUES (@ppsn, @deptID, @salary, @status, @startDate, @siniority)
			PRINT 'The User already exist, added as Employee'
		END
	ELSE IF NOT EXISTS(SELECT ppsn FROM users WHERE ppsn = @ppsn) AND
			NOT EXISTS(SELECT ppsn FROM employee WHERE ppsn = @ppsn)
		BEGIN
			INSERT INTO dbo.users (ppsn, firstName,	middleName, lastName, lastName02, phone, email, addressLn01,
								   addressLn02, country, zipCode, nationality, birthDate, gender)
			VALUES (@ppsn, @firstName, @middleName, @lastName, @lastName02, @phone, @email, @addressLn01, @addressLn02,
					@country, @zipCode, @nationality, @birthDate, @gender)

			INSERT INTO dbo.employee (ppsn, deptID, salary, [status], startDate, siniority)
			VALUES (@ppsn, @deptID, @salary, @status, @startDate, @siniority)
			PRINT N'The user is been created and added as employee'
		END
	ELSE
		BEGIN
			PRINT N'This user already exist as employee'
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE findClient (@ppsn VARCHAR(15),
							 @clientID VARCHAR(20) OUTPUT)
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	SELECT @clientID = clientID FROM dbo.client WHERE client.ppsn = @ppsn
	IF EXISTS(SELECT * FROM client WHERE clientID = @clientID)
		BEGIN
			PRINT N'Client Found'
		END
	ELSE
		BEGIN;
			THROW 510011,  N'Client Can''t be found',1
		END;
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE newTicket (@serialNumber VARCHAR(17),
							@ppsn VARCHAR(15),
							@empID VARCHAR(20),
							@serviceDesc NVARCHAR(200))
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	DECLARE @clientID VARCHAR(20)
	EXEC findClient @ppsn = @ppsn, @clientID = @clientID OUTPUT
	INSERT INTO dbo.ticket (serialNumber, clientID,	empID, serviceDesc)
	VALUES (@serialNumber, @clientID, @empID, @serviceDesc)
	PRINT N'The new ticket is been created'
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO

CREATE PROCEDURE closeTicket (@ticketID VARCHAR(20))
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	IF EXISTS(SELECT *  FROM ticket WHERE ticketID = @ticketID)
		BEGIN
			UPDATE ticket SET [status] = 'Closed' WHERE ticketID = @ticketID
			UPDATE ticket SET dateFinish = GETDATE() WHERE ticketID = @ticketID
		END
	ELSE
		BEGIN;
			THROW 51009,  N'The Ticket provided can''t be found',1
		END;
		
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO


CREATE PROCEDURE newSale (@serialNumber VARCHAR(17),
							@ppsn VARCHAR(15),
							@empID VARCHAR(20),
							@finance VARCHAR(1))
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	SELECT @finance = CAST(@finance AS BIT)
	DECLARE @clientID VARCHAR(20)
	EXEC findClient @ppsn = @ppsn, @clientID = @clientID OUTPUT
	IF EXISTS(SELECT*FROM carDetail WHERE serialNumber = @serialNumber AND stock = 1)
		BEGIN
			INSERT INTO dbo.saleTotal(serialNumber, clientID, empID, finance)
			VALUES (@serialNumber, @clientID, @empID, @finance)
			PRINT N'The new sale has been created'
		END
	ELSE
		BEGIN;
			THROW 51008,  N'There is no stock of the serial number provided',1
		END;
		
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE customerDeleteGDPR (@ppsn VARCHAR(15))
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	DECLARE @selCount TINYINT
	SELECT @selCount = COUNT(ppsn) FROM users WHERE ppsn=@ppsn
	IF (@selCount = 1)
		BEGIN
			UPDATE client SET [status] = 'Inactive' WHERE ppsn=@ppsn
			UPDATE bankDetails SET iban = 'NONE' WHERE ppsn=@ppsn
			UPDATE cardPayment SET cardNumber = 0, ccv = 0 WHERE ppsn=@ppsn
			DELETE FROM users WHERE ppsn=@ppsn
		END
	ELSE IF (@selCount = 0)
		BEGIN
			PRINT N'The user with PPSN N. ' + @ppsn + ' doesn''t exist'
		END
	ELSE
		BEGIN
			PRINT N'There is an error, more than one user shares this register'
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE FUNCTION stockChecking (@serialNumber VARCHAR(17)) RETURNS 
VARCHAR(5)
AS
BEGIN
	DECLARE @answer VARCHAR(15)
	IF EXISTS(SELECT serialNumber FROM carDetail WHERE serialNumber=@serialNumber)
		SET @answer = 'Yes'
	ELSE
		SET @answer = 'No'

	RETURN @answer
END
GO



CREATE PROCEDURE createDepartment (@departmentID VARCHAR(15),
									@departmentName  VARCHAR(15))
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	IF EXISTS(SELECT * FROM department WHERE deptName=@departmentName)
		BEGIN;
			THROW 51007,  N'The department already exists',1
		END;
	ELSE
		BEGIN
			INSERT INTO department
			VALUES(@departmentID, @departmentName)
		END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE addPaymentMethod (@ppsn VARCHAR(15),
									@paymentMethod VARCHAR(10),
									@iban VARCHAR(34) = NULL,
									@swiftCode VARCHAR(10) = NULL,
									@cardNumber VARCHAR(65) = NULL,
									@valDate VARCHAR(15) = NULL,
									@ccv VARCHAR(4) = NULL,
									@result INT OUTPUT)
AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	PRINT @valDate
	SELECT @cardNumber = CAST(@cardNumber AS BIGINT)
	SELECT @valDate = CAST(@valDate AS DATE)
	SELECT @ccv = CAST(@ccv AS SMALLINT)
	IF NOT EXISTS(SELECT * FROM client WHERE ppsn = @ppsn)
		BEGIN;
			THROW 51001, N'The user doesn''t exist',1
		END;

	IF @paymentMethod = 'Card'
		BEGIN
			IF EXISTS(SELECT * FROM cardPayment WHERE cardNumber = @cardNumber)
				BEGIN;
					THROW 51004, N'The payment method already exist',1
				END;
			INSERT INTO cardPayment (ppsn, cardNumber, valDate, ccv)
			VALUES (@ppsn, @cardNumber, @valDate, @ccv)
			SELECT @result = cardID FROM cardPayment WHERE cardNumber=@cardNumber
		END
	ELSE IF @paymentMethod = 'Bank'
		BEGIN
			IF EXISTS(SELECT * FROM bankDetails WHERE iban = @iban)
				BEGIN;
					THROW 51004, N'The payment method already exist',1
				END;
			INSERT INTO bankDetails
			VALUES (@ppsn, @iban, @swiftCode)
			SELECT @result = bankID FROM bankDetails WHERE iban=@iban
		END
	ELSE
		BEGIN;
			THROW 51002,  N'The payment method is not a valid option',1
		END;
	COMMIT TRANSACTION
	RETURN @result
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE getClientPaymentMethod(@clientPPSN VARCHAR(15),
										@paymentMethod VARCHAR(10),
										@paymentSelection VARCHAR(1))

AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION
	IF NOT EXISTS(SELECT * FROM client WHERE ppsn = @clientPPSN)
		BEGIN;
			THROW 51001, N'The user doesn''t exist',1
		END;
	SELECT @paymentSelection = CAST(@paymentSelection AS TINYINT)
	DECLARE @result INT
	DECLARE @selectCountCard TINYINT
	DECLARE @selectCountBank TINYINT
	SELECT @selectCountCard = COUNT(*) FROM cardPayment WHERE ppsn = @clientPPSN
	SELECT @selectCountBank = COUNT(*) FROM bankDetails WHERE ppsn = @clientPPSN
	IF (@paymentMethod = 'Card' AND @selectCountCard <= @paymentSelection)
		BEGIN
			DECLARE @cardMethodList TABLE ([order] INT IDENTITY (1,1),cardID INT)
			INSERT INTO @cardMethodList (cardID)
			SELECT cardID FROM cardPayment WHERE ppsn = @clientPPSN
			SELECT @result = cardID FROM @cardMethodList WHERE [order] = @paymentSelection
		END
	ELSE IF (@paymentMethod = 'Bank' AND @selectCountBank <= @paymentSelection)
		BEGIN
			DECLARE @bankMethodList TABLE ([order] INT IDENTITY (1,1),bankID INT)
			INSERT INTO @bankMethodList (bankID)
			SELECT bankID FROM bankDetails WHERE ppsn = @clientPPSN
			SELECT @result = bankID FROM @bankMethodList WHERE [order] = @paymentSelection
		END
	ELSE IF @paymentMethod <> 'Card' AND @paymentMethod <> 'Bank'
		BEGIN;
			THROW 51002,  N'The payment method is not a valid option',1
		END;
	ELSE
		BEGIN;
			THROW 51003, N'The user doesn''t own that payment method',1
		END;
	COMMIT TRANSACTION
	RETURN @result
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO



CREATE PROCEDURE newInvoice (@clientPPSN VARCHAR(15),
							 @empID VARCHAR(20),
							 @goodType VARCHAR(15),
							 @paymentMethod VARCHAR(10),
							 @newMethod VARCHAR(1) = 0,
							 @paymentSelection VARCHAR(2) = NULL,
							 @iban VARCHAR(34) = NULL,
							 @swiftCode VARCHAR(10) = NULL,
							 @cardNumber VARCHAR(65) = NULL,
							 @valDate VARCHAR(15) = NULL,
							 @ccv VARCHAR(4) = NULL,
							 @ticketID VARCHAR(20) = NULL,
							 @saleID VARCHAR(20)= NULL,
							 @finalAmount VARCHAR(10))


AS
SET XACT_ABORT ON
BEGIN TRY
	BEGIN TRANSACTION

	PRINT @valDate
	DECLARE @newMethodCAST BIT
	DECLARE @paymentSelectionCAST TINYINT
	DECLARE @cardNumberCAST BIGINT
	DECLARE @valDateCAST DATE
	DECLARE @ccvCAST SMALLINT
	DECLARE @finalAmountCAST MONEY

	SELECT @newMethodCAST = CAST(@newMethod AS BIT)
	SELECT @paymentSelectionCAST = CAST(@paymentSelection AS TINYINT)
	SELECT @cardNumberCAST = CAST(@cardNumber AS BIGINT)
	SELECT @valDateCAST = CAST(@valDate AS DATE)
	SELECT @ccvCAST = CAST(@ccv AS SMALLINT)
	SELECT @finalAmountCAST = CAST(@finalAmount AS MONEY)

	DECLARE @methodPaymentID INT
	IF @newMethod = 1
		BEGIN
			IF @paymentMethod = 'Card'
				BEGIN
					EXEC @methodPaymentID = addPaymentMethod @ppsn = @clientPPSN, @paymentMethod = @paymentMethod,
					@cardNumber=@cardNumber, @valDate = @valDate, @ccv = @ccv, @result = @methodPaymentID OUTPUT
				END
			ELSE IF @paymentMethod = 'Bank'
				BEGIN
					EXEC @methodPaymentID = addPaymentMethod @ppsn=@clientPPSN, @paymentMethod=@paymentMethod,
					@iban=@iban, @swiftCode=@swiftCode, @result = @methodPaymentID OUTPUT
				END
			ELSE
				BEGIN;
					THROW 51002,  N'The payment method is not a valid option',1
				END;
		END	 
	ELSE IF @newMethod = 0
		BEGIN
			EXEC @methodPaymentID = getClientPaymentMethod @clientPPSN=@clientPPSN,
			@paymentMethod=@paymentMethod, @paymentSelection=@paymentSelection
		END
	ELSE
		BEGIN;
			THROW 51005,  N'The payment Method is not being selected',1
		END;


	IF @goodType = 'Ticket'
		BEGIN
			IF @paymentMethod = 'Card'
				BEGIN
					INSERT INTO invoice (cardID, ticketID, finalAmount)
					VALUES (@methodPaymentID, @ticketID, @finalAmount)
				END
			ELSE IF @paymentMethod = 'Bank'
				BEGIN
					INSERT INTO invoice (bankID, ticketID, finalAmount)
					VALUES (@methodPaymentID, @ticketID, @finalAmount)
				END
			ELSE
				BEGIN;
					THROW 51002,  N'The payment method is not a valid option',1
				END;
		END
	ELSE IF @goodType = 'Sale'
		BEGIN
			IF @paymentMethod = 'Card'
				BEGIN
					INSERT INTO invoice (cardID, saleID, finalAmount)
					VALUES (@methodPaymentID, @saleID, @finalAmount)
				END
			ELSE IF @paymentMethod = 'Bank'
				BEGIN
					INSERT INTO invoice (bankID, saleID, finalAmount)
					VALUES (@methodPaymentID, @saleID, @finalAmount)
				END
			ELSE
				BEGIN;
					THROW 51002,  N'The payment method is not a valid option',1
				END;
		END
	ELSE
		BEGIN;
			THROW 51006,  N'There is no service provided with this caracteristics',1
		END;
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	EXEC errorHandling

	IF (XACT_STATE()) = -1
	BEGIN
		PRINT  N'The transaction is in an uncommittable state.' +  
                    'Rolling back transaction.'
		ROLLBACK TRANSACTION
	END
	IF (XACT_STATE()) = 1
	BEGIN
		PRINT N'The transaction is committable.' +  
                'Committing transaction.' 
		COMMIT TRANSACTION
	END
END CATCH
GO