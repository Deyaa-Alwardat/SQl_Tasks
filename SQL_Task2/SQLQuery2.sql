create table AccessCards(
CardID INT PRIMARY KEY,
CardNumber VARCHAR(50) NOT NULL  UNIQUE,
EmployeeID INT UNIQUE FOREIGN KEY References Employees(EmployeeID)
)
create table Projects(
ProjectID INT PRIMARY KEY,
ProjectName VARCHAR(100) NOT NULL
)
create  table EmployeeProjects(
EmpID int FOREIGN KEY  References Employees(EmployeeID) ,
proID int FOREIGN KEY  References Projects(ProjectID),
AssignedDate DATE,
PRIMARY KEY(EmpID,proID)

)
INSERT INTO AccessCards (CardID, CardNumber, EmployeeID)
VALUES
(101, 'CARD-101', 1),
(102, 'CARD-102', 2),
(103, 'CARD-103', 3);

select FullName,Salary,DepartmentName
FROM Employees
inner join Departments
on Employees.DepartmentID= Departments.DepartmentID;

SELECT
    Departments.DepartmentName,
    Employees.FullName
FROM Departments
LEFT JOIN Employees
    ON Departments.DepartmentID = Employees.DepartmentID;

select  Employees.FullName,AccessCards.CardNumber
from  Employees
inner join AccessCards
ON   Employees.EmployeeID=AccessCards.EmployeeID;

select  Employees.FullName,
Projects.ProjectName,EmployeeProjects.AssignedDate
from  Employees
inner join EmployeeProjects
on  Employees.EmployeeID = EmployeeProjects.EmpID
inner join Projects
on EmployeeProjects.proID = Projects.ProjectID;

select DepartmentID,
sum(Salary) As  TotalSalary,
 COUNT(*) AS EmployeeCount
 from Employees
 group by DepartmentID;

 select DepartmentID,
 avg(Salary) AvgSalary
 from Employees
 GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;

select * FROM Employees
where Salary>(  select avg(Salary)FROM Employees);

create view vw_EmployeeDetails As 
select 
 Employees.EmployeeID,
    Employees.FullName,
    Employees.Email,
    Departments.DepartmentName
FROM Employees
INNER JOIN Departments
    ON Employees.DepartmentID = Departments.DepartmentID;

    create procedure  sp_GetEmployeesByDepartment
    @DeptID int 
    As begin 
    select * from Employees
    where DepartmentID = @DeptID;
END;

CREATE TABLE EmployeeAudit (
    AuditID INT PRIMARY KEY IDENTITY,
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);
CREATE TRIGGER trg_AfterDelete_Employees
ON Employees
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit (EmployeeID, Action, ActionDate)
    SELECT
        EmployeeID,
        'DELETE',
        GETDATE()
    FROM deleted;
END;
