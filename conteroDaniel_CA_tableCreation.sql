CREATE FUNCTION uniqueUserGen ( @Prefix VARCHAR(10),
								@Id INT,
								@Length INT,
								@PaddingChar CHAR(1) = '0'
)
RETURNS VARCHAR(20)
WITH SCHEMABINDING
AS
BEGIN

	RETURN (
	 SELECT @Prefix + RIGHT(REPLICATE(@PaddingChar, @Length) + CAST(@Id AS VARCHAR(10)), @Length)
	)

END
GO

CREATE FUNCTION internalEmailGen (@ppsn VARCHAR(15),
								  @domainName NVARCHAR(20) = '@domainCars.com')

RETURNS NVARCHAR(60)
AS
BEGIN
	DECLARE @empName NVARCHAR(20)
	DECLARE @empLastName NVARCHAR(20)
	SELECT @empName = firstName FROM dbo.users WHERE ppsn = @ppsn
	SELECT @empLastName = lastName FROM dbo.users WHERE ppsn = @ppsn
	RETURN(@empName + @empLastName + @domainName)
END
GO

CREATE TABLE [department] (
  [deptID] VARCHAR(15) UNIQUE NOT NULL,
  [deptName] VARCHAR(15) NOT NULL,
  PRIMARY KEY ([deptID])
);

CREATE TABLE [users] (
  [ppsn] VARCHAR(15) NOT NULL,
  [firstName] NVARCHAR(20) NOT NULL,
  [middleName] NVARCHAR(20),
  [lastName] NVARCHAR(20) NOT NULL,
  [lastName02] NVARCHAR(20),
  [phone] VARCHAR(30) NOT NULL,
  [email] NVARCHAR(50) NOT NULL,
  [addressLn01] VARCHAR(100) NOT NULL,
  [addressLn02] VARCHAR(100),
  [country] VARCHAR(50) NOT NULL,
  [zipCode] VARCHAR(10) NOT NULL,
  [nationality] VARCHAR(15) NOT NULL,
  [birthDate] DATE NOT NULL,
  [gender] VARCHAR(10),
  PRIMARY KEY ([ppsn])
);

CREATE TABLE [bankDetails] (
  [bankID] INT IDENTITY (1,1),
  [ppsn] VARCHAR(15) DEFAULT('GDPR') NOT NULL,
  [iban] VARCHAR(34) NOT NULL,
  [swiftCode] VARCHAR(10) NOT NULL,
  PRIMARY KEY ([bankID]),
  FOREIGN KEY ([ppsn]) REFERENCES users([ppsn]) ON DELETE SET DEFAULT
);

CREATE TABLE [cardPayment] (
  [cardID] INT IDENTITY(1,1),
  [ppsn] VARCHAR(15) DEFAULT('GDPR') NOT NULL,
  [cardNumber] BIGINT NOT NULL,
  [valDate] DATE NOT NULL,
  [ccv] SMALLINT NOT NULL,
  PRIMARY KEY ([cardID]),
  FOREIGN KEY ([ppsn]) REFERENCES users([ppsn]) ON DELETE SET DEFAULT
);

CREATE TABLE [employee] (
  [ID] INT IDENTITY(1,1) NOT NULL,
  [empID] AS dbo.uniqueUserGen('EMP-', CAST(ID AS VARCHAR(10)), 6, '0') PERSISTED NOT NULL,
  [ppsn] VARCHAR(15) DEFAULT('GDPR') NOT NULL,
  [deptID] VARCHAR(15) NOT NULL,
  [internalEmail] AS dbo.internalEmailGen (ppsn, DEFAULT),
  [salary] SMALLMONEY NOT NULL,
  [status] VARCHAR(15) DEFAULT('Active') NOT NULL,
  [startDate] DATE NOT NULL,
  [siniority] VARCHAR(20) NOT NULL,
  PRIMARY KEY ([empID]),
  FOREIGN KEY ([ppsn]) REFERENCES users([ppsn]) ON DELETE SET DEFAULT,
  FOREIGN KEY ([deptID]) REFERENCES department([deptID])
);

CREATE TABLE [client] (
  [ID] INT IDENTITY(1,1) NOT NULL,
  [clientID] AS dbo.uniqueUserGen('CLI-', CAST(ID AS VARCHAR(10)), 6, '0') PERSISTED NOT NULL,
  [ppsn] VARCHAR(15) DEFAULT('GDPR') NOT NULL,
  [status] VARCHAR(15) DEFAULT ('Active') NOT NULL,
  [regDate] DATE DEFAULT (GETDATE()) NOT NULL,
  PRIMARY KEY ([clientID]),
  FOREIGN KEY ([ppsn]) REFERENCES users([ppsn]) ON DELETE SET DEFAULT
);

CREATE TABLE [car] (
  [serialNumber] VARCHAR(17) NOT NULL,
  [brand] VARCHAR(15) NOT NULL,
  [model] VARCHAR(15) NOT NULL,
  [fuelType] VARCHAR(10) NOT NULL,
  [year] SMALLINT NOT NULL,
  PRIMARY KEY ([serialNumber])

);

CREATE TABLE [carDetail] (
  [carDetailID] INT IDENTITY(1,1), 
  [serialNumber] VARCHAR(17) NOT NULL,
  [addDate] DATETIME DEFAULT (GETDATE()) NOT NULL,
  [version] VARCHAR(60) NOT NULL,
  [condition] VARCHAR(6) DEFAULT('New') NOT NULL,
  [kms] INT DEFAULT(0) NOT NULL,
  [prevOwners] TINYINT DEFAULT(0) NOT NULL,
  [extras] VARCHAR(300),
  [stock] BIT DEFAULT(0) NOT NULL,
  [price] MONEY,
  PRIMARY KEY ([CarDetailID]),
  FOREIGN KEY ([serialNumber]) REFERENCES car([serialNumber])
);

CREATE TABLE [saleTotal] (
  [ID] INT IDENTITY(1,1) NOT NULL,
  [saleID] AS dbo.uniqueUserGen('SLS-', CAST(ID AS VARCHAR(10)), 6, '0') PERSISTED NOT NULL,
  [empID] VARCHAR(20) NOT NULL,
  [clientID] VARCHAR(20) NOT NULL,
  [serialNumber] VARCHAR(17) NOT NULL,
  [finance] BIT NOT NULL
  PRIMARY KEY ([saleID]),
  FOREIGN KEY ([serialNumber]) REFERENCES car([serialNumber]),
  FOREIGN KEY ([clientID]) REFERENCES client([clientID]),
  FOREIGN KEY ([empID]) REFERENCES employee([empID])
);

CREATE TABLE [ticket] (
  [ID] INT IDENTITY(1,1) NOT NULL,
  [ticketID] AS dbo.uniqueUserGen('SRV-', CAST(ID AS VARCHAR(10)), 6, '0') PERSISTED NOT NULL,
  [serialNumber] VARCHAR(17) NOT NULL,
  [clientID] VARCHAR(20) NOT NULL,
  [empID] VARCHAR(20) NOT NULL,
  [dateStart] DATETIME DEFAULT (GETDATE()) NOT NULL,
  [dateFinish] DATETIME,
  [serviceDesc] VARCHAR(200) NOT NULL,
  [status] VARCHAR(15) DEFAULT ('Active') NOT NULL
  PRIMARY KEY ([ticketID]),
  FOREIGN KEY ([serialNumber]) REFERENCES car([serialNumber]),
  FOREIGN KEY ([clientID]) REFERENCES client([clientID]),
  FOREIGN KEY ([empID]) REFERENCES employee([empID])
);

CREATE TABLE [invoice] (
  [ID] INT IDENTITY(1,1) NOT NULL,
  [invoiceCode] AS dbo.uniqueUserGen('INV-', CAST(ID AS VARCHAR(10)), 6, '0') PERSISTED NOT NULL,
  [bankID] INT,
  [cardID] INT,
  [saleID] VARCHAR(20),
  [ticketID] VARCHAR(20),
  [date] DATETIME DEFAULT (GETDATE()) NOT NULL,
  [finalAmount] MONEY NOT NULL,
  PRIMARY KEY ([invoiceCode]),
  FOREIGN KEY ([bankID]) REFERENCES bankDetails([bankID]),
  FOREIGN KEY ([cardID]) REFERENCES cardPayment([cardID]),
  FOREIGN KEY ([saleID]) REFERENCES saleTotal([saleID]),
  FOREIGN KEY ([ticketID]) REFERENCES ticket([ticketID])
);