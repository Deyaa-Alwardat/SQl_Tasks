CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    GPA DECIMAL(3,2),
    DepartmentID int  FOREIGN KEY REFERENCES Departments(DepartmentID)
);
CREATE TABLE StudentProfiles (
    ProfileID INT PRIMARY KEY,
    Address VARCHAR(200),
    EmergencyPhone VARCHAR(20),
   StudentID int  UNIQUE FOREIGN KEY REFERENCES Students(StudentID)
);
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT,
   DepartmentID int  FOREIGN KEY REFERENCES Departments(DepartmentID)
);
CREATE TABLE StudentCourses (
    EnrollmentDate DATE DEFAULT GETDATE(),
   StudentID int  FOREIGN KEY REFERENCES Students(StudentID),
  CourseID int   FOREIGN KEY REFERENCES Courses(CourseID),
  PRIMARY KEY (StudentID, CourseID)
);
Alter table  Students add Age int ;
SELECT * FROM Students;
DROP TABLE TempInstructors;

INSERT INTO Departments (DepartmentID, DepartmentName)
VALUES
(1, 'Computer Science'),
(2, 'Software Engineering'),
(3, 'Business Administration');

INSERT INTO Students
(StudentID, FullName, Email, GPA, DepartmentID, Age)
VALUES
(101, 'Ali Smadi', 'ali@coursehub.com', 3.80, 1, 22),
(102, 'Omar Ahmad', 'omar@coursehub.com', 2.90, 1, 21),
(103, 'Laila Hassan', 'laila@coursehub.com', 3.50, 2, 23),
(104, 'Tariq Zaid', 'tariq@coursehub.com', 2.10, 3, 20);

INSERT INTO StudentProfiles
(ProfileID, StudentID, Address, EmergencyPhone)
VALUES
(1, 101, 'Amman, Jordan', '0791111111'),
(2, 102, 'Irbid, Jordan', '0792222222'),
(3, 103, 'Zarqa, Jordan', '0793333333');

INSERT INTO Courses
(CourseID, CourseName, Credits, DepartmentID)
VALUES
(201, 'Database Systems', 3, 1),
(202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2);

INSERT INTO StudentCourses
(StudentID, CourseID)
VALUES
(101, 201),
(101, 202),
(102, 201),
(103, 203);

update Students
set GPA=2.50
where StudentID = 104;

delete  from Students
where StudentID = 104;

select FullName ,GPA, DepartmentName
from Students
inner join Departments
on  Students. DepartmentID=Departments. DepartmentID;

select DepartmentName,FullName
from Departments
left join Students
on Departments.DepartmentID=Students.DepartmentID;

SELECT
    FullName,Address,EmergencyPhone
FROM Students
INNER JOIN StudentProfiles
    ON Students.StudentID = StudentProfiles.StudentID;

SELECT FullName,CourseName,EnrollmentDate
FROM Students
INNER JOIN StudentCourses
    ON Students.StudentID = StudentCourses.StudentID
INNER JOIN Courses
    ON StudentCourses.CourseID = Courses.CourseID;

 select  count(*) As TotalStudents,
 AVG(GPA)AverageGPA,
 MAX(GPA) AS HighestGPA,
 MIN(GPA) AS LowestGPA
 from Students;

 select  DepartmentID,
 AVG(GPA) As AverageGPA,
 count(*) As TotalStudents
 from Students
 GROUP BY DepartmentID;

 select count(*)AS TotalStudents, DepartmentID  from Students
 where 
 GPA >=2.50
group by DepartmentID
having count(*)>1;

--Stage 6: Indexing 
--The StudentID column has a Clustered Index by default because
--it is defined as the Primary Key.

 create nonclustered index IX_Students_Email on Students( Email);

 select * from Students 
 where GPA >( select AVG(GPA) from Students);

 create view vw_StudentAcademicDetails As
 select StudentID,FullName,GPA,DepartmentName
 from Students
 inner join Departments
 on Students.DepartmentID=Departments.DepartmentID;

 create Procedure sp_GetStudentsByDepartment @DeptID INT 
 AS 
 begin 
 select * from Students
 where DepartmentID=@DeptID
 end;