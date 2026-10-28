create table TemporaryStaff (
	StaffID int primary Key,
    StaffName VARCHAR(50),
    HireDate DATE
)
create table Departments (
	DepartmentID int primary Key,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE,
    HireDate DATE
)

create table Employees (
	EmployeeID int primary Key,
    FullName VARCHAR(100) NOT NULL,
    Email  VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT
)

alter table Employees add phoneNumber VARCHAR(20);

--DROP TABLE TemporaryStaff;
insert into Departments (DepartmentID, DepartmentName)
values
    (1, 'IT'),
    (2, 'HR'),
    (3, 'Finance');
SELECT * FROM Departments;

INSERT INTO Employees
    (EmployeeID, FullName, Email, Salary, DepartmentID,phoneNumber)
VALUES
    (1, 'Ahmad Ali', 'ahmad@techworld.com', 1200.00, 1, '0791111111'),
    (2, 'Sara Hassan', 'sara@techworld.com', 950.00, 2, '0792222222'),
    (3, 'Zaid Omar', 'zaid@techworld.com', 1500.00, 1, '0793333333'),
    (4, 'Mona Khaled', 'mona@techworld.com', 800.00, 3, '0794444444');
   

   update Employees 
   set Salary=1350
   where (EmployeeID = 1) ;

DELETE FROM Employees
WHERE EmployeeID = 4;

SELECT *FROM Employees;
SELECT FullName, Salary FROM Employees;
SELECT SUM(Salary) AS TotalSalaries FROM Employees;
SELECT AVG(Salary) AS AverageSalary FROM Employees;
SELECT
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employees;

SELECT COUNT(*) AS TotalEmployees FROM Employees;