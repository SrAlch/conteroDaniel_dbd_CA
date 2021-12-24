--Dummy user to replace 'Hard Delete' user's FK--
INSERT INTO users
VALUES ('GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', 'GDPR', '2018-05-25', 'GDPR')
GO

--Department creation--
INSERT INTO department
VALUES ('MCH001', 'Mechanic'),
	   ('SLS002', 'Sales')
GO

--Adding general car list--
INSERT INTO car
VALUES ('JHMGE8H65AC037793', 'Audi', 'A5', 'Diesel', 2021),
		('5NPEU46F46H111031', 'Audi', 'A5', 'Diesel', 2021),
		('3TMLU4EN9EM185098', 'Audi', 'A5', 'Diesel', 2021),
		('YS3ED45G483550053', 'Audi', 'Q3 Sportback', 'Gasoline', 2021),
		('3C6UD5FL7CG139232', 'Audi', 'Q3 Sportback', 'Diesel', 2021),

		('2B3CK4CV4AH871987', 'Ford', 'Model Fiesta', 'Diesel', 2010),
		('3N1AB7AP0FY669485', 'Chevrolet', 'Suburban', 'Diesel', 2010),
		('1C3BCBFG5EN768801', 'Ford', 'Mustang', 'Gasoline', 1982),
		('1GKS2GEJ1CR644706', 'Lexus', 'GX', 'Diesel', 2006),
		('1D4PU6GX8AW342970', 'Volkswagen', 'CC', 'Diesel', 2010),

		('2B3CJ5DTXBH674037', 'Ford', 'Focus', 'Gasoline', 2015),
		('1G8ZK54761Z322655', 'Ford', 'Focus', 'Gasoline', 2016),
		('4T4BF1FK7ER318737', 'Opel', 'Astra', 'Gasoline', 2016),
		('4T1BF1FK9DU214341', 'Peugeot', '206', 'Gasoline', 2006),
		('2G1WF55KXY9187452', 'Porsche', '911 (964)', 'Gasoline', 1994)
GO

--Adding extra information to the general car list for cars on stock and sold--
INSERT INTO carDetail (serialNumber, [version], condition, kms, prevOwners, extras, stock, price)
VALUES ('JHMGE8H65AC037793', 'S5 TDI Quattro', 'New', '0', '0', '3-spoke leather multi-function steering wheel, Driver''s Information System (DIS), Audi sound system speaker package, Light and rain sensor, 18” x 8J ‘5-spoke’ S line design alloy wheels with 245/40 R18 tyres, Sports suspension', '1', '70000'),
		('5NPEU46F46H111031', 'S5 TDI Quattro', 'New', '0', '0', '3-spoke leather multi-function steering wheel, Driver''s Information System (DIS), 18” x 8J ‘5-spoke’ S line design alloy wheels with 245/40 R18 tyres, Sports suspension', '1', '65000'),
		('3TMLU4EN9EM185098', 'S5 TDI Quattro',	'New', '0', '0', '3-spoke leather multi-function steering wheel, Driver''s Information System (DIS), Light and rain sensor, 18” x 8J ‘5-spoke’ S line design alloy wheels with 245/40 R18 tyres, Sports suspension', '0', '68000'),
		('YS3ED45G483550053', '35 TFSI 110kW (150CV) S Line', 'Used', '50000', '1', 'Driver''s Information System (DIS), 21” x 8J ‘5-spoke’ S line design alloy wheels with 245/50 R18 tyres, Sports suspension', '1', '52125'),
		('3C6UD5FL7CG139232', '35 TDI 180kW (240CV) S Line', 'Used', '12000', '1', 'Driver''s Information System (DIS), 21” x 8J ‘5-spoke’ S line design alloy wheels with 245/50 R18 tyres, Sports suspension, LED lighting, Ceramic BREMBO breaks ABS Sport', '1', '59300'),

		('2B3CK4CV4AH871987', '1.6 L 16v Duratorq TDCi', 'Used', '100677', '1', 'Adaptive cruise control, High-beam assist', '0', '72114.1'),
		('3N1AB7AP0FY669485', '5.3 L (325 cu in) Vortec 5300 LY5 V8', 'Used', '201039', '1', 'Tyre pressure warning, Memory seats', '0', '79061.2'),
		('1C3BCBFG5EN768801', '4.2 L V8 Turbo GT', 'Used', '103845', '3', 'ABS', '0', '61060.49'),
		('1GKS2GEJ1CR644706', '	4.7 L 2UZ-FE V8', 'Used', '192090', '2', 'Adaptive cruise control, High-beam assist', '0', '74602.07'),
		('1D4PU6GX8AW342970', '3.6 L VR6', 'Used', '153811', '3', 'Tyre pressure warning, Memory seats', '0', '79618.89')
GO

--Adding sensitive data for client/employee--
INSERT INTO users (ppsn, firstName, middleName, lastName, lastName02, phone, email, addressLn01, addressLn02, country, zipCode, nationality, birthDate, gender) 
VALUES ('9906477FD', 'Rourke', null, 'Sisley', null, '+353 466 453 4723', 'rvenditti0@altervista.org', '1366 2nd Park', null, 'Ireland', 'D04', 'Fijian', '1981-11-18', 'Female'),
		('4763799AS', 'Audra', null, 'Delhay', 'Watkiss', '+353 512 793 4136', 'awatkiss1@istockphoto.com', '99561 Hanson Way', null, 'Ireland', 'A85', 'Japanese', '1971-12-04', 'Male'),
		('2763647VD', 'Tamar', 'Almérinda', 'Roz', 'Hazleton', '+353 834 841 2831', 'thazleton2@merriam-webster.com', '855 Boyd Terrace', null, 'Ireland', 'P36', 'Guatemalan', '1995-12-09', 'Female'),
		('1807952WF', 'Verine', null, 'Reilingen', 'Dimanche', '+353 305 819 0532', 'vdimanche3@ted.com', '1 Rieder Place', null, 'Ireland', 'H12', 'Choctaw', '1975-11-17', 'Male'),
		('7626825GF', 'Stanleigh', null, 'Penni', 'Crippes', '+353 729 655 1576', 'scrippes4@ted.com', '09991 Upham Junction', null, 'Ireland', 'D24', 'American', '1972-12-14', 'Female'),
		
		('6771089BV', 'Jackquelin', null, 'Bennetts', 'Storkes', '+353 791 401 5579', 'jstorkes5@sciencedirect.com', '36 4th Drive', null, 'Ireland', 'V31', 'Cheyenne', '1995-11-22', 'Male'),
		('2793735GR', 'Lauryn', 'Bérengère', 'Mordie', 'Bhar', '+353 674 837 6247', 'lbhar6@google.com.br', '00 Quincy Way', null, 'Ireland', 'A96', 'Latin American', '1974-11-25', 'Male'),
		('8856157HG', 'Bryanty', null, 'O''Towey', null, '+353 575 161 8277', 'brevens7@nationalgeographic.com', '172 Carpenter Crossing', null, 'Ireland', 'V31', 'Delaware', '1993-08-21', 'Male'),
		('2080161DF', 'Cammie', null, 'Winthrop', null, '+353 896 723 6726', 'cdawks8@addthis.com', '70 Butterfield Road', null, 'Ireland', 'V94', 'White', '2000-09-13', 'Female'),
		('5067698AX', 'Abram', null, 'Valentinuzzi', null, '+353 366 957 0583', 'abanbridge9@hp.com', '9710 Crownhardt Alley', null, 'Ireland', 'K34', 'Cheyenne', '1981-05-17', 'Female'),

		('5082464YT', 'Bud', null, 'Ashley', 'Sandercock', '+353 191 194 0425', 'bsandercock0@a8.net', '62691 Mosinee Crossing', null, 'Ireland', 'F45', 'Honduran', '1985-02-14', 'Male'),
		('9989441UY', 'Hill', null, 'Liverock', 'Grovier', '+353 401 391 5400', 'hgrovier1@nba.com', '9 Jana Street', null, 'Ireland', 'Y34', 'Cherokee', '1976-02-11', 'Female'),
		('6044355GN', 'Kimberly', null, 'Beere', 'Stirgess', '+353 424 825 8943', 'kstirgess2@shareasale.com', '0157 Dovetail Park', null, 'Ireland', 'A91', 'Cree', '1980-03-16', 'Male'),
		('4394429XC', 'Amalia', null, 'Peverell', 'Hearst', '+353 403 827 6565', 'ahearst3@earthlink.net', '86205 Texas Point', null, 'Ireland', 'D07', 'Dominican', '1994-08-14', 'Female'),
		('5907028RT', 'Emelita', null, 'Yglesias', null, '+353 467 618 2510', 'eawty4@indiegogo.com', '5 Lerdahl Center', null, 'Ireland', 'H54', 'Choctaw', '1976-08-23', 'Male')

		
		--('6434678WE', 'Moreen', 'Táng', 'Bignal', null, '+353 467 412 8699', 'mtokley5@engadget.com', '5 Bashford Point', null, 'Ireland', 'P51', 'South American', '1997-10-03', 'Female'),
		--('3145296QA', 'Ker', null, 'Shellard', null, '+353 504 185 1828', 'kibel6@ox.ac.uk', '38460 Badeau Alley', null, 'Ireland', 'K78', 'Tongan', '1976-01-10', 'Male'),
		--('6199313XZ', 'Sharon', null, 'Birmingham', null, '+353 548 472 9809', 'somohun7@pcworld.com', '4 Tony Crossing', null, 'Ireland', 'W34', 'Micronesian', '1994-02-20', 'Male'),
		--('7653426VC', 'Claudius', null, 'Spencook', null, '+353 971 920 4339', 'cshakesby8@ustream.tv', '73 Veith Park', null, 'Ireland', 'F26', 'Yuman', '2000-12-21', 'Male'),
		--('4309549HJ', 'Arlyne', null, 'Creus', 'Safont', '+353 140 296 4168', 'asafont9@nytimes.com', '5 Kingsford Point', null, 'Ireland', 'A84', 'Chickasaw', '1985-03-16', 'Male')
GO

--Adding the users that are categorize as clients--
INSERT INTO client (ppsn)
VALUES ('9906477FD'),
		('4763799AS'),
		('2763647VD'),
		('1807952WF'),
		('7626825GF'),
		('5082464YT'),
		('9989441UY'),
		('6044355GN'),
		('4394429XC'),
		('5907028RT')
--('6434678WE',
--('3145296QA',
--('6199313XZ',
--('7653426VC',
--('4309549HJ',
GO

--Adding the users that are categorize as employees--
INSERT INTO employee (ppsn, deptID, salary, startDate,siniority)
VALUES ('6771089BV', 'SLS002', '40000', '2015-05-12', 'Senior'),
		('2793735GR', 'SLS002', '40000', '2016-08-22', 'Senior'),
		('8856157HG', 'MCH001', '30000', '2015-04-22', 'Senior'),
		('2080161DF', 'MCH001', '30000', '2017-08-15', 'Senior'),
		('5067698AX', 'MCH001', '25000', '2019-10-12', 'Junior')
GO

--Adding service tickets from the mechanic service--
INSERT INTO ticket (serialNumber, clientID, empID, dateFinish, serviceDesc)
VALUES ('1G8ZK54761Z322655', 'CLI-000001', 'EMP-000005', '2020-05-05','Plug spark'),
		('2B3CJ5DTXBH674037', 'CLI-000002', 'EMP-000004', '2020-03-22','Replacement of light bulbs and servo mirrors'),
		('4T4BF1FK7ER318737', 'CLI-000003', 'EMP-000004', '2019-02-01','New tyres fitting'),
		('4T1BF1FK9DU214341', 'CLI-000004', 'EMP-000003', NULL,'Plug sparks and oil service'),
		('2G1WF55KXY9187452', 'CLI-000005', 'EMP-000003', NULL,'Gearbox replacement')
GO

--Adding sales data--
INSERT INTO saleTotal(empID, clientID, serialNumber, finance)
VALUES ('EMP-000001', 'CLI-000006', '3TMLU4EN9EM185098', '0'),
		('EMP-000002', 'CLI-000007', '2B3CK4CV4AH871987', '0'),
		('EMP-000002', 'CLI-000008', '3N1AB7AP0FY669485', '0'),
		('EMP-000001', 'CLI-000009', '1C3BCBFG5EN768801', '0'),
		('EMP-000001', 'CLI-000010', '1GKS2GEJ1CR644706', '0'),
		('EMP-000001', 'CLI-000010', '1D4PU6GX8AW342970', '0')
GO

--Adding bank data--
INSERT INTO bankDetails (ppsn, iban, swiftCode)
VALUES ('5082464YT', 'FR05 4713 0156 56UJ AHZX', 'ANV3888E'),
		('9989441UY', 'CY17 9898 6053 CNLC ZEWO', 'SQK5592'),
		('6044355GN', 'PS52 NMQX GODS SUNQ 5NT1', 'WOR6998'),
		('4394429XC', 'MR25 2859 7036 7518 2408', 'DHO2563'),
		('5907028RT', 'MT87 XLXO 8345 6L7T DJ5X', 'QGK8170')


--Adding final invoices--
INSERT INTO invoice(bankID, saleID, [date], finalAmount)
VALUES ('1', 'SLS-000001', '2018-05-02', '20356854'),
		('2', 'SLS-000002', '2020-03-22', '56512.50'),
		('3', 'SLS-000003', '2019-05-23', '842156.30'),
		('4', 'SLS-000004', '2019-03-15', '89865.3'),
		('5', 'SLS-000005', GETDATE(), '8978485')
GO