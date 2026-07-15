SELECT CURRENT_USER(), USER();
CREATE DATABASE rbac;
USE rbac;
CREATE TABLE Users (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50)
);
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName VARCHAR(50)
);
CREATE TABLE UserRoles (
    UserID INT,
    RoleID INT,
    PRIMARY KEY (UserID, RoleID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);
CREATE TABLE Permissions (
    PermissionID INT PRIMARY KEY,
    PermissionName VARCHAR(100)
);
CREATE TABLE RolePermissions (
    RoleID INT,
    PermissionID INT,
    PRIMARY KEY (RoleID, PermissionID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID),
    FOREIGN KEY (PermissionID) REFERENCES Permissions(PermissionID)
);
INSERT INTO Roles VALUES
(1, 'Admin'),
(2, 'Manager'),
(3, 'Employee');
INSERT INTO Users VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie');
INSERT INTO UserRoles VALUES
(1,1),   -- Alice = Admin
(2,2),   -- Bob = Manager
(3,3);  -- Charlie = Employee
INSERT INTO Permissions VALUES
(1,'SELECT_EMPLOYEE'),
(2,'INSERT_EMPLOYEE'),
(3,'UPDATE_EMPLOYEE'),
(4,'DELETE_EMPLOYEE');
INSERT INTO RolePermissions VALUES
(1,1),(1,2),(1,3),(1,4),  -- Admin: all
(2,1),(2,3),              -- Manager: read, update
(3,1);                   -- Employee: read only
SELECT * FROM Users;
SELECT * FROM Roles;
SELECT *
FROM Users
JOIN UserRoles
ON Users.UserID = UserRoles.UserID
JOIN Roles
ON UserRoles.RoleID = Roles.RoleID;       --Show which role each user has
SELECT * FROM Permissions;
SELECT RoleName, PermissionName
FROM Roles
JOIN RolePermissions
ON Roles.RoleID = RolePermissions.RoleID
JOIN Permissions
ON RolePermissions.PermissionID = Permissions.PermissionID;     --Show which permissions each role has
SELECT Username, RoleName
FROM Users
JOIN UserRoles
ON Users.UserID = UserRoles.UserID
JOIN Roles
ON UserRoles.RoleID = Roles.RoleID
WHERE Username = 'Bob';  --Show Bob's role only