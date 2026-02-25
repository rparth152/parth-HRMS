

--For Admin Projects Section --
CREATE TABLE [dbo].[AddProjects](
    [ProjectId] INT IDENTITY(1,1) NOT NULL,
    [ProjectName] NVARCHAR(255) NOT NULL,
    [ClientName] NVARCHAR(255) NOT NULL,
    [Description] NVARCHAR(1000) NOT NULL,
    [StartDate] DATETIME2(7) NOT NULL,
    [EndDate] DATETIME2(7) NOT NULL,
    [Priority] NVARCHAR(50) NOT NULL,
    [ProjectValue] FLOAT NOT NULL,
    [PriceType] NVARCHAR(50) NOT NULL,
    [FilePath] NVARCHAR(255) NOT NULL,
    [LogoPath] NVARCHAR(255) NOT NULL,
    [Status] NVARCHAR(50) NOT NULL,
    [ManagerName] NVARCHAR(MAX) NOT NULL,

    CONSTRAINT OK_AddProjects PRIMARY KEY CLUSTERED 
    (
        [ProjectId] ASC
    )
);
ALTER TABLE AddProjects
ADD ProjectMembers NVARCHAR(MAX);

create PROCEDURE sp_AddProjects
(
    @ProjectName NVARCHAR(255),
    @ClientName NVARCHAR(255),
    @Description NVARCHAR(1000),
    @StartDate DATETIME2(7),
    @EndDate DATETIME2(7),
    @Priority NVARCHAR(50),
    @ProjectValue FLOAT,
    @PriceType NVARCHAR(50),
    @FilePath NVARCHAR(255),
    @LogoPath NVARCHAR(255),
    @Status NVARCHAR(50),
    @ManagerName NVARCHAR(MAX),
    @ProjectMembers NVARCHAR(MAX)  
)
AS
BEGIN
    INSERT INTO AddProjects
    (
        ProjectName,ClientName,Description,StartDate,EndDate,
        Priority,ProjectValue,PriceType,FilePath,LogoPath,
        Status,ManagerName,ProjectMembers
    )
    VALUES
    (
        @ProjectName,@ClientName,@Description,@StartDate,@EndDate,
        @Priority,@ProjectValue,@PriceType,@FilePath,@LogoPath,
        @Status,@ManagerName,@ProjectMembers
    )
END

select * from [dbo].[AddProjects];


---for project dummy members --

create table emp ( Name varchar (100));

insert into emp (Name) values ('Omkar');
insert into emp (Name) values ('Keka');
insert into emp (Name) values ('Mayur');
insert into emp (Name) values ('Raju');

CREATE TABLE [dbo].[Task2](
    [TaskId] INT IDENTITY(1,1) NOT NULL,
    [Title] NVARCHAR(255) NOT NULL,
    [Deadline] DATETIME2(7) NOT NULL,
    [Project] NVARCHAR(255) NOT NULL,
    [TeamMem] NVARCHAR(50) NOT NULL,
    [Status] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(1000) NOT NULL,
    [FilePath] NVARCHAR(255) NULL,
    CONSTRAINT Ok_Task PRIMARY KEY CLUSTERED (TaskId)
);



CREATE PROC sp_AddTask              ---use---
@Title NVARCHAR(255),
@Deadline DATETIME2(7),
@Project NVARCHAR(255),
@TeamMem NVARCHAR(50),
@Status NVARCHAR(50),
@Description NVARCHAR(1000),
@FilePath NVARCHAR(255)
AS
BEGIN
INSERT INTO Task2 (Title, Deadline, Project, TeamMem, Status, Description, FilePath)
VALUES (@Title, @Deadline, @Project, @TeamMem, @Status, @Description, @FilePath)
END

select * from [dbo].[Task2];

Create TABLE [dbo].[TaskBoards2](
    [TaskBoardId] INT IDENTITY(1,1) NOT NULL,
    [ProjectName] Nvarchar (100) NOT NULL,
    [TaskName] NVARCHAR (100) NOT NULL,
    [Percentage] INT NOT NULL,
    [DueDate] DATETIME2(7) NOT NULL,

    CONSTRAINT Ok_TaskBoards PRIMARY KEY CLUSTERED (TaskBoardId)
);


create proc sp_addTaksBoard
@ProjectName varchar (100),
@TaskName varchar (100),
@Percentage int,
@DueDate Datetime2(7)
as
begin 
insert into TaskBoards2 (ProjectName,TaskName,Percentage,DueDate) values (@ProjectName,@TaskName,@Percentage,@DueDate);
end


select * from [dbo].[TaskBoards2];

CREATE TABLE [dbo].[Taskmember2](
    [AssignedId] INT IDENTITY(1,1) NOT NULL,
    [TaskId] INT NOT NULL,
    [UserId] INT NOT NULL,

    CONSTRAINT Ok_Taskmember PRIMARY KEY CLUSTERED (AssignedId)
);

select * from [dbo].[Taskmember2];

CREATE TABLE Currency (   --use--
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CurrencyInfo NVARCHAR(150)
);

INSERT INTO Currency (CurrencyInfo) VALUES
('US Dollar - USD - $'),
('Euro - EUR - €'),
('Indian Rupee - INR - ₹'),
('British Pound - GBP - £'),
('Japanese Yen - JPY - ¥'),
('Chinese Yuan - CNY - ¥'),
('Australian Dollar - AUD - $'),
('Canadian Dollar - CAD - $'),
('Swiss Franc - CHF - CHF'),
('Singapore Dollar - SGD - $'),
('UAE Dirham - AED - د.إ'),
('Saudi Riyal - SAR - ﷼'),
('South African Rand - ZAR - R'),
('Malaysian Ringgit - MYR - RM'),
('Thai Baht - THB - ฿'),
('Indonesian Rupiah - IDR - Rp'),
('Philippine Peso - PHP - ₱'),
('Pakistani Rupee - PKR - ₨'),
('Bangladeshi Taka - BDT - ৳'),
('Sri Lankan Rupee - LKR - ₨');

-----End Project Section ------

------For Master Documents section Admin ------

CREATE TABLE [dbo].[addAdminDocNames2](
    [Id] INT IDENTITY(1,1) NOT NULL,                ---use--
    [DocName] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT Ok_addAdminDocNames PRIMARY KEY CLUSTERED (Id)
);

select * from [dbo].[addAdminDocNames2];

--Employee--

CREATE TABLE [dbo].[addEmpDocNames](
    [Id] INT IDENTITY(1,1) NOT NULL,                ---use on admin side--
    [DocName] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT Ok_addEmpDocNames PRIMARY KEY CLUSTERED (Id)
);
select * from [addEmpDocNames];


Create TABLE [dbo].[addEmployeeDocNames2](    ---use on emp side---
    [Id] INT IDENTITY(1,1) NOT NULL,
    [DocName] NVARCHAR(MAX) NOT NULL,
    [FilePath] NVARCHAR (MAX) NOT NULL
    CONSTRAINT Ok_addEmployeeDocNames PRIMARY KEY CLUSTERED (Id)
);


CREATE PROCEDURE sp_AddEmp
    @DocName NVARCHAR(MAX),
    @FilePath NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO [dbo].[addEmployeeDocNames] (DocName, FilePath)
    VALUES (@DocName, @FilePath)
END

select * from [dbo].[addEmployeeDocNames];


CREATE TABLE [dbo].[addAdminDoc2]   -- use on admin side
(
    [id] INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [user] NVARCHAR(MAX) NOT NULL,
    [DocName] NVARCHAR(MAX) NOT NULL,
    [FilePath] NVARCHAR(MAX) NOT NULL
);

CREATE PROCEDURE sp_AddAdminDoc
    @user NVARCHAR(MAX),
    @DocName NVARCHAR(MAX),
    @FilePath NVARCHAR(MAX)
AS
BEGIN
    INSERT INTO [dbo].[addAdminDoc] ([user], DocName, FilePath)
    VALUES (@user, @DocName, @FilePath);
END

select * from [addAdminDoc];