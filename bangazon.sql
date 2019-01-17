PRAGMA foreign_keys = ON;

-- DELETE FROM Computers;
-- DELETE FROM Departments;
-- DELETE FROM TrainingPrograms;
-- DELETE FROM EmployeeTrainingPrograms;
-- DELETE FROM Employees;

-- DELETE FROM Customers;
-- DELETE FROM ProductTypes;
-- DELETE FROM PaymentTypes;
-- DELETE FROM Products;
-- DELETE FROM OrderProducts;
-- DELETE FROM Orders;


DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS EmployeeTrainingPrograms;
DROP TABLE IF EXISTS TrainingPrograms;
DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Computers;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS OrderProducts;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS PaymentTypes;
DROP TABLE IF EXISTS ProductTypes;
DROP TABLE IF EXISTS Customers;

CREATE TABLE `Departments` (
    `DepartmentId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `Budget`    INTEGER NOT NULL
);

CREATE TABLE `Computers` (
    `ComputerId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `PurchaseDate`    INTEGER NOT NULL,
    `DecomissionDate`    INTEGER NOT NULL
);

CREATE TABLE `Employees` (
    `EmployeeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `FirstName`    TEXT NOT NULL,
    `LastName`    TEXT NOT NULL,
    `StartDate`    TEXT NOT NULL,
    `IsSupervisor` BOOLEAN NOT NULL,
    `DepartmentId` INTEGER NOT NULL,
    FOREIGN KEY(`DepartmentId`) 
    REFERENCES `Departments`(`DepartmentId`)
    ON DELETE cascade
);

CREATE TABLE `ComputerEmployees` (
    `ComputerEmployeeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `EmployeeId`    INTEGER NOT NULL,
    `ComputerId`    INTEGER NOT NULL,
    FOREIGN KEY(`EmployeeId`) 
    REFERENCES `Employees`(`EmployeeId`)
    ON DELETE cascade
    FOREIGN KEY(`ComputerId`) 
    REFERENCES `Computers`(`ComputerId`)
    ON DELETE cascade
);

CREATE TABLE `TrainingPrograms` (
    `TrainingProgramId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL,
    `StartDate`    TEXT NOT NULL,
    `EndDate`    TEXT NOT NULL,
    `MaxAttendees`    INTEGER NOT NULL
);

CREATE TABLE `EmployeeTrainingPrograms` (
    `EmployeeTrainingProgramsId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `EmployeeId`    INTEGER NOT NULL,
    `TrainingProgramId`    INTEGER NOT NULL,
    FOREIGN KEY(`EmployeeId`) 
    REFERENCES `Employees`(`EmployeeId`)
    ON DELETE cascade
    FOREIGN KEY(`TrainingProgramId`) 
    REFERENCES `TrainingPrograms`(`TrainingProgramId`)
    ON DELETE cascade
);



CREATE TABLE `ProductTypes` (
    `ProductTypeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name`    TEXT NOT NULL
);

CREATE TABLE `Customers` (
    `CustomerId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `FirstName`    TEXT NOT NULL,
    `LastName`    TEXT NOT NULL,
    `AccountCreatedDate` TEXT NOT NULL,
    `IsActive` BOOLEAN NOT NULL,
    `LastLogin` TEXT NOT NULL
);

CREATE TABLE `PaymentTypes` (
    `PaymentTypeId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Name` TEXT NOT NULL,
    `AccountNumber`    INTEGER NOT NULL,
    `CustomerId`    INTEGER NOT NULL,
    FOREIGN KEY(`CustomerId`) 
    REFERENCES `Customers`(`CustomerId`)
    ON DELETE cascade
);

CREATE TABLE `Orders` (
    `OrderId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `CustomerId`    INTEGER NOT NULL,
    `PaymentTypeId`    INTEGER,
    `IsCompleted`    BOOLEAN NOT NULL,
    FOREIGN KEY(`CustomerId`) 
    REFERENCES `Customers`(`CustomerId`)
    ON DELETE cascade
    FOREIGN KEY(`PaymentTypeId`) 
    REFERENCES `PaymentTypes`(`PaymentTypeId`)
    ON DELETE cascade
);

CREATE TABLE `Products` (
    `ProductId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `Title`    TEXT NOT NULL,
    `Price`    INTEGER NOT NULL,
    `Description`    TEXT NOT NULL,
    `Quantity`    INTEGER NOT NULL,
    `CustomerId`    INTEGER NOT NULL,
    `ProductTypeId`    INTEGER,
    FOREIGN KEY(`CustomerId`) 
    REFERENCES `Customers`(`CustomerId`)
    ON DELETE cascade
    FOREIGN KEY(`ProductTypeId`) 
    REFERENCES `ProductTypes`(`ProductTypeId`)
    ON DELETE cascade
);

CREATE TABLE `ProductOrders` (
    `ProductOrderId`    INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    `ProductId`    INTEGER NOT NULL,
    `OrderId`    INTEGER,
    FOREIGN KEY(`ProductId`) 
    REFERENCES `Products`(`ProductId`)
    ON DELETE cascade
    FOREIGN KEY(`OrderId`) 
    REFERENCES `Orders`(`OrderId`)
    ON DELETE cascade
);