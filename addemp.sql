create proc spflist
as
begin
select * from [User];
end

CREATE PROCEDURE spInsertUser
(
    @FirstName        NVARCHAR(MAX),
    @LastName         NVARCHAR(MAX),
    @Email            NVARCHAR(MAX),
    @PasswordHash     NVARCHAR(MAX),
    @PhoneNumber      NVARCHAR(MAX),
    @RoleId           INT,
    @DepartmentId     INT,
    @DesignationId    INT,
    @DateOfJoining    DATETIME2,
    @DateOfBirth      DATETIME2,
    @Gender           NVARCHAR(MAX),
    @Address          NVARCHAR(MAX),
    @AboutEmployee    NVARCHAR(MAX),
    @ProfilePicture   NVARCHAR(MAX)
)
AS
BEGIN
    INSERT INTO [dbo].[User]
    (
        FirstName,
        LastName,
        Email,
        PasswordHash,
        PhoneNumber,
        RoleId,
        DepartmentId,
        DesignationtId,
        DateOfJoining,
        DateOfBirth,
        Gender,
        Address,
        AboutEmployee,
        ProfilePicture,
        CreatedAt,
        Status
    )
    VALUES
    (
        @FirstName,
        @LastName,
        @Email,
        @PasswordHash,
        @PhoneNumber,
        @RoleId,
        NULLIF(@DepartmentId, 0),
        NULLIF(@DesignationId, 0),
        @DateOfJoining,
        @DateOfBirth,
        @Gender,
        @Address,
        @AboutEmployee,
        @ProfilePicture,
        GETDATE(),
        'Active'
    )
END




