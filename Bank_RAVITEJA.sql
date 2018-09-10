CREATE DATABASE BANK_RAVITEJA;

GO

USE BANK_RAVITEJA;

GO

CREATE TABLE UserLogins
 (UserLoginID   smallint  IDENTITY(1,1)  Not Null PRIMARY KEY,
  UserLogin     char(15)    Not Null,
  UserPassword  varchar(20) Not Null);

GO

INSERT INTO UserLogins
 (UserLogin, UserPassword)
VALUES
 ('User1', 'User1'),
 ('User2', 'User2'),
 ('User3', 'User3'),
 ('User4', 'User4'),
 ('User5', 'User5');

 GO
 
CREATE TABLE UserSecurityQuestions
 (UserSecurityQuestionID	tinyint		IDENTITY (1,1) Not Null	PRIMARY KEY,
  UserSecurityQuestion		varchar(50)	Null);
GO

INSERT INTO UserSecurityQuestions
(UserSecurityQuestion)
 VALUES
 ('What is your pet’s name?'),
 ('In what year was your father born?'),
 ('Where did you meet your spouse?'),
 ('What is the name of your favorite actor?'),
 ('What was the make of your first car?');
 GO
 
CREATE TABLE UserSecurityAnswers
 (UserLoginID	smallint Not Null PRIMARY KEY
       REFERENCES UserLogins(UserLoginID),
  UserSecurityAnswer	varchar(25)	Not Null,
  UserSecurityQuestionID	tinyint	Not Null FOREIGN KEY
  REFERENCES UserSecurityQuestions(UserSecurityQuestionID));
GO

INSERT INTO UserSecurityAnswers
(UserLoginID, UserSecurityAnswer, UserSecurityQuestionID)
VALUES
(1, 'Fluffy', 1), (2, '1955', 2), (3, 'Paris', 3), (4, 'Chris', 4), (5, 'Bently', 5);
GO

CREATE TABLE FailedTransactionErrorType
  (FailedTransactionErrorTypeID tinyint	IDENTITY(1,1) Not Null PRIMARY KEY,
   FailedTransactionDescription varchar(50) Not Null);
GO

INSERT INTO FailedTransactionErrorType
(FailedTransactionDescription)
VALUES
('Withdraw Limit Reached'), 
('Incorrect amount entered'), 
('Daily limit exceeded'), 
('Wrong account selected'), 
('Incorrect OTP');
GO

CREATE TABLE FailedTransactionLog
  (FailedTransactionID	int		IDENTITY(1,1) Not Null PRIMARY KEY,
   FailedTransactionErrorTypeID tinyint	Not Null FOREIGN KEY
    REFERENCES FailedTransactionErrorType(FailedTransactionErrorTypeID),
   FailedTransactionErrorTime	datetime	Not Null,
   FailedTransactionXML			xml			Not Null);
GO

INSERT INTO FailedTransactionLog
(FailedTransactionErrorTypeID, FailedTransactionErrorTime, FailedTransactionXML)
VALUES
(1, '01/01/2002', 'abc'),
(2, '01/01/2003', 'def'),
(3, '01/01/2004', 'ghi'),
(4, '01/01/2005', 'jkl'),
(5, '01/01/2006', 'mno');
GO

CREATE TABLE LoginErrorLog
  (ErrorLogID	int		IDENTITY(1,1)  Not Null PRIMARY KEY,
   ErrorTime	datetime			   Not Null,
   FailedTransactionXML	xml			   Not Null);
GO

INSERT INTO LoginErrorLog
(ErrorTime, FailedTransactionXML)
VALUES
('01/01/2002', 'abc'),
('01/01/2003', 'def'),
('01/01/2004', 'ghi'),
('01/01/2005', 'jkl'),
('01/01/2006', 'mno');
GO

CREATE TABLE SavingsInterestRates
  (InterestSavingsRateID	tinyint	IDENTITY(1,1) Not Null	PRIMARY KEY,
   InterestRateValue		numeric(9,9)	Not Null,
   InterestRateDescription	varchar(20)		Null);
GO

INSERT INTO SavingsInterestRates
(InterestRateValue, InterestRateDescription)
VALUES
(0.05, 'Too Low'), (0.10, 'Low'), (0.15, 'Median'), (0.20, 'High'), (0.25, 'Too High');
GO

CREATE TABLE AccountStatusType
  (AccountStatusTypeID		tinyint	IDENTITY(1,1) Not Null	PRIMARY KEY,
   AccountStatusDescription	varchar(30)			  Not Null);
GO

INSERT INTO AccountStatusType
(AccountStatusDescription)
VALUES
('Closed'), ('Open'), ('Active'), ('Inactive'), ('Verification Pending');
GO

CREATE TABLE AccountType
  (AccountTypeID		  tinyint		IDENTITY(1,1) Not Null	PRIMARY KEY,
   AccountTypeDescription varchar(30)	Not Null);
GO

INSERT INTO AccountType
(AccountTypeDescription)
VALUES
('Savings'), ('Chequeing'), ('Trading'), ('Credit'), ('Debit');
GO

CREATE TABLE TransactionType
  (TransactionTypeID	tinyint		IDENTITY(1,1) Not Null  PRIMARY KEY,
   TransactionTypeName	char(10)		Not Null,
   TransactionTypeDescription	varchar(50)	Not Null,
   TransactionFeeAmount			smallmoney	Not Null);
GO

INSERT INTO TransactionType
(TransactionTypeName, TransactionTypeDescription, TransactionFeeAmount)
VALUES
('Balance', 'See Money', 0),
('Transfer', 'Send Money', 0),
('Add', 'Add Money', 0),
('Pay Bills', 'Pay Bills', 0),
('Add Acc', 'Add Account', 0);
GO

CREATE TABLE Employee
  (EmployeeID	int		IDENTITY(1,1) Not Null	PRIMARY KEY,
   EmployeeFirstName	varchar(25)	Not Null,
   EmployeeMiddleInitial	char(1)		Null,
   EmployeeLastName			varchar(25)	Not Null,
   EmployeeManager		bit		Not Null);
GO

INSERT INTO Employee
(EmployeeFirstName, EmployeeMiddleInitial, EmployeeLastName, EmployeeManager)
VALUES
('Tom', '', 'Hardy', 0),
('Steven', 'C', 'Holding', 0),
('Ben', '', 'Affleck', 0),
('Ravi', '', 'Teja', 0),
('Katy', 'D', 'Dillon', 0);
GO

Create TABLE TransactionLog
  (TransactionID int	IDENTITY(1,1) Not Null	PRIMARY KEY,
   TransactionDate	datetime	Not Null,
   TransactionTypeID tinyint	Not Null FOREIGN KEY
     REFERENCES	TransactionType(TransactionTypeID),
   TransactionAmount money		Not Null,
   NewBalance		 money		Not Null,
   AccountID		 int		Not Null,
   CustomerID		 int		Not Null,
   EmployeeID		 int		Not Null FOREIGN KEY
     REFERENCES	Employee(EmployeeID),
   UserLoginID		 smallint	Not Null FOREIGN KEY
     REFERENCES UserLogins(UserLoginID));
GO

INSERT INTO TransactionLog
(TransactionDate, TransactionTypeID, TransactionAmount, NewBalance, AccountID, CustomerID, EmployeeID, UserLoginID)
VALUES
('02/02/2002',1, 100, 900, 1, 1, 1, 1),
('02/02/2003',2, 200, 800, 2, 2, 2, 2),
('02/02/2004',3, 300, 700, 3, 3, 3, 3),
('02/02/2005',4, 400, 600, 4, 4, 4, 4),
('02/02/2006',5, 500, 500, 5, 5, 5, 5);
GO 

CREATE TABLE Account
  (AccountID	int	  IDENTITY(1,1) Not Null PRIMARY KEY,
   CurrentBalance int	Not Null,
   AccountTypeID  tinyint	Not Null FOREIGN KEY
     REFERENCES AccountType(AccountTypeID),
   AccountStatusTypeID tinyint Not Null FOREIGN KEY
     REFERENCES AccountStatusType(AccountStatusTypeID),
   InterestSavingsRateID tinyint Not Null FOREIGN KEY
     REFERENCES SavingsInterestRates(InterestSavingsRateID));
GO

INSERT INTO Account
(CurrentBalance,AccountTypeID,AccountStatusTypeID, InterestSavingsRateID)
VALUES
(1000, 1, 1, 1), (1560, 1, 2, 2), (2234, 2, 3, 4), (5623, 3, 1, 1), (1000, 5, 1, 1);
GO

CREATE TABLE Customer
  (CustomerID	int		IDENTITY(1,1) Not Null	PRIMARY KEY,
   AccountID int Not Null FOREIGN KEY REFERENCES Account(AccountID),
   CustomerAddress1	varchar(30) Not Null,
   CustomerAddress2	varchar(30) Not Null,
   CustomerFirstName varchar(30) Not Null,
   CustomerMiddleInitial char(1) Null,
   CustomerLastName	varchar(30) Not Null,
   City  varchar(20) Not Null,
   State char(2)  Not Null,
   ZipCode	char(10) Not Null,
   EmailAddress	char(40) Null,
   HomePhone	char(10)  Null,
   CellPhone	char(10)  Null,
   WorkPhone	char(10)  Null,
   SSN			char(9)	  Null,
   UserLoginID  smallint Not Null FOREIGN KEY
     REFERENCES UserLogins(UserLoginID));
GO

INSERT INTO Customer
(AccountID, CustomerAddress1,CustomerAddress2, CustomerFirstName, CustomerMiddleInitial, CustomerLastName,
 City, State, ZipCode, EmailAddress, CellPhone, SSN, UserLoginID)
VALUES
(1, '123 Way', 'A Road', 'John', '', 'Kennady', 'Toronto', 'ON', 'M2J0A4', '123@gmail.com', '6486752020', '123456781', 1),
(2, '456 Way', 'B Road', 'Ravi', '', 'Teja', 'Ottawa', 'ON', 'M2J0A5', '456@gmail.com', '6486752021', '123456782', 2),
(3, '789 Way', 'C Road', 'Pam', 'D', 'Henderson', 'Waterloo', 'ON', 'M2J0A6', '789@gmail.com', '6486752022', '123456783', 3),
(4, '101 Way', 'D Road', 'Steven', 'F', 'Kennady', 'Ajax', 'ON', 'M2J0A7', '101@gmail.com', '6486752023', '123456784', 4),
(5, '112 Way', 'E Road', 'Prasanna', '', 'Mankal', 'Markam', 'ON', 'M2J0A8', '112@gmail.com', '6486752024', '123456785', 5);
GO


CREATE TABLE OverDraftLog
  (AccountID int Not Null PRIMARY KEY
     REFERENCES Account(AccountID),
   OverDraftDate datetime	Not Null,
   OverDraftAmount	money	Not Null,
   OverDraftTransactionXML xml);
   GO

INSERT INTO OverDraftLog
(AccountID, OverDraftDate, OverDraftAmount, OverDraftTransactionXML)
VALUES
(1, '01/01/2002', 200, 'abc'),
(2, '01/01/2016', 300, 'abc'),
(3, '01/01/2015', 400, 'abc'),
(4, '01/01/2008', 500, 'abc'),
(5, '01/01/2007', 600, 'abc');
GO

CREATE TABLE CustomerAccount
  (AccountID int Not Null FOREIGN KEY
    REFERENCES Account(AccountID),
   CustomerID int Not Null FOREIGN KEY
    REFERENCES Customer(CustomerID));
GO

INSERT INTO CustomerAccount
(AccountID, CustomerID)
VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
GO

CREATE TABLE LoginAccount
  (UserLoginID smallint Not Null FOREIGN KEY
    REFERENCES UserLogins(UserLoginID),
   AccountID int Not Null FOREIGN KEY
    REFERENCES Account(AccountID));
GO

INSERT INTO LoginAccount
(UserLoginID, AccountID)
VALUES
(1,1), (2,2), (3,3), (4,4), (5,5);
GO

Alter Table TransactionLog
 ADD CONSTRAINT FK_Account FOREIGN KEY(AccountID) REFERENCES Account(AccountID);
GO

Alter Table TransactionLog
 ADD CONSTRAINT FK_Customer FOREIGN KEY(CustomerID) REFERENCES Customer(CustomerID);
GO

--View to get all customers with checking account from ON province.
CREATE VIEW Chequing_ON AS
SELECT C.CustomerID, C.CustomerFirstName+''+C.CustomerMiddleInitial+' '+C.CustomerLastName AS CustomerName, C.EmailAddress, AT.AccountTypeDescription
FROM Customer C JOIN Account A ON C.AccountID = A.AccountID
                JOIN AccountType AT ON A.AccountTypeID = AT.AccountTypeID
WHERE C.State = 'ON' AND
      A.AccountTypeID = 2;
GO

SELECT * FROM Chequing_ON
GO

--veiw to get all customers with total account balance (including interest rate)
--greater than 5000.
CREATE VIEW BalAbove5000 AS
SELECT A.AccountID, S.InterestRateValue
FROM Account A JOIN SavingsInterestRates S
           ON A.InterestSavingsRateID = S.InterestSavingsRateID
WHERE A.CurrentBalance > 5000;
GO

SELECT * FROM BalAbove5000;
GO

--View to get counts of checking and savings accounts by customer.
CREATE VIEW CountOfAccounts AS
SELECT C.CustomerID, COUNT (AT.AccountTypeID) AS AccountTypeNumber, AT.AccountTypeDescription
FROM Customer C JOIN Account A ON C.AccountID = A.AccountID
                JOIN AccountType AT ON A.AccountTypeID = AT.AccountTypeID
WHERE AT.AccountTypeDescription IN ('Savings', 'Chequeing')
GROUP BY C.CustomerID, AT.AccountTypeDescription;

GO

SELECT * FROM CountOfAccounts

GO

--view to get any particular user’s login and password using AccountId.
CREATE VIEW LoginPasswordWithAccID AS
SELECT C.AccountID, U.UserLogin, U.UserPassword
FROM UserLogins U JOIN Customer C ON U.UserLoginID = C.UserLoginID;

GO

SELECT * FROM LoginPasswordWithAccID;

GO

--view to get all customers’ overdraft amount.
CREATE VIEW OverDraftAmount AS
SELECT C.CustomerID, CONCAT(C.CustomerFirstName,' ',C.CustomerMiddleInitial,' ',C.CustomerLastName) CustomerName, O.OverDraftAmount
FROM Customer C JOIN OverDraftLog O ON C.AccountID = O.AccountID;

GO

SELECT * FROM OverDraftAmount;

GO

--stored procedure to add “User_” as a prefix to everyone’s login (username).
CREATE PROC UserPrefix
  @UserLogin Char(20)
AS
UPDATE UserLogins
 SET UserLogin = 'USER_'+UserLogin
  WHERE UserLogin = @UserLogin;
  GO

 --Create a stored procedure that accepts AccountId 
 --as a parameter and returns customer’s full name.
 CREATE PROC spNameWithAccountID
  @AccountID int
 AS
 SELECT AccountID, CustomerFirstName+''+CustomerMiddleInitial+''+CustomerLastName
 FROM Customer
 WHERE AccountID = @AccountID;
 GO

 --stored procedure that returns error logs inserted in the last 24 hours. 
 CREATE PROC spErrorLogLast24Hours
 AS
 SELECT * FROM LoginErrorLog
 WHERE ErrorTime >= DATEADD(day, -1,GETDATE());
 GO

 --stored procedure that takes a deposit as a parameter and updates 
 --CurrentBalance value for that particular account.
 CREATE PROC spDeposit
  @AccountID int, @Deposit int
AS
 UPDATE Account
 SET CurrentBalance = CurrentBalance + @Deposit
 WHERE AccountID = @AccountID;
 GO

--stored procedure that takes a withdrawal amount as a parameter and updates 
--CurrentBalance value for that particular account.
CREATE PROC spWithdrawal
  @AccountID int, @Withdrawal int
AS
 UPDATE Account
 SET CurrentBalance = CurrentBalance - @Withdrawal
 WHERE AccountID = @AccountID;
GO

--stored procedure to remove all security questions for a particular login.
CREATE PROC spDeleteSecurityQuestions
 @UserLoginID smallint
 AS
 UPDATE UserSecurityQuestions 
 SET UserSecurityQuestion = NULL
 WHERE UserSecurityQuestionID = (SELECT usq.UserSecurityQuestionID
                                 FROM UserSecurityAnswers usa JOIN UserSecurityQuestions usq
								 ON usa.UserSecurityQuestionID = usq.UserSecurityQuestionID
								 WHERE usa.UserLoginID = @UserLoginID);


--Delete all error logs created in the last hour.
DELETE FROM LoginErrorLog
WHERE ErrorTime >= DATEADD(HOUR,-1,GETDATE());

--query to remove SSN column from Customer table.
ALTER TABLE Customer
DROP COLUMN SSN;