
CREATE DATABASE  FINAL;
GO
USE FINAL
GO
-- Tạo bảng role
CREATE TABLE ROLE (
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    name NVARCHAR(20),
    PRIMARY KEY (id)
)
-- Thêm dữ liệu vào bảng quyền
INSERT INTO ROLE (name) VALUES
    (N'Admin'),
    (N'Guest')
GO
-- Tạo bảng User
CREATE TABLE [USER] (
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    email NVARCHAR(40),
    password NVARCHAR(MAX),
    address NVARCHAR(MAX),
    phone NVARCHAR(MAX),
    pathImg NVARCHAR(MAX),
    idRole UNIQUEIDENTIFIER,
    PRIMARY KEY (id),
    FOREIGN KEY (idRole) REFERENCES ROLE(id) ON DELETE CASCADE
)
GO
-- Tạo bảng loại sản phẩm
CREATE TABLE CATEGORY(
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    name NVARCHAR(255),
    PRIMARY KEY (id)
)
-- Tạo bảng sản phẩm
CREATE TABLE PRODUCT(
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    name VARCHAR(255) NOT NULL,
    detail VARCHAR(255),
    quantity INT NOT NULL,
    price DECIMAL NOT NULL,
    ingredient VARCHAR(255) NOT NULL,
    hsd DATE NOT NULL,
    createAt DATETIME DEFAULT GETDATE(),
    idUser UNIQUEIDENTIFIER NOT NULL,
    idCategory UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idUser) REFERENCES [USER] (id) ON DELETE CASCADE,
    FOREIGN KEY (idCategory) REFERENCES CATEGORY (id) ON DELETE CASCADE
);
GO
-- Tạo bảng order
CREATE TABLE [ORDER](
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    status bit DEFAULT 0,
    total DECIMAL(38,2) NOT NULL,
    createAt DATETIME DEFAULT GETDATE(),
    idUser UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idUser) REFERENCES [USER] (id) ON DELETE CASCADE
);
GO
-- Tạo bảng chi tiết order
CREATE TABLE DETAILORDERS(
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    quantity INT NOT NULL,
    price DECIMAL(38,2) NOT NULL,
    idOrder UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idOrder) REFERENCES [ORDER] (id) ON DELETE CASCADE
);
GO
-- Tạo bảng lưu ảnh của sản phẩm
CREATE TABLE IMAGEPRODUCT(
    id UNIQUEIDENTIFIER DEFAULT NEWID(),
    name VARCHAR(255) NOT NULL,
    idProduct UNIQUEIDENTIFIER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (idProduct) REFERENCES PRODUCT (id) ON DELETE CASCADE
);


-- DROP DATABASE FINAL