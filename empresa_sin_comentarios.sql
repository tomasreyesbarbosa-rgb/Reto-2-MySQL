DROP DATABASE IF EXISTS empresa;
CREATE DATABASE empresa
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE empresa;

CREATE TABLE Departamento (
    DepID         INT          NOT NULL AUTO_INCREMENT,
    NombreDEPTO   VARCHAR(100) NOT NULL,
    Ubicacion     VARCHAR(150) NULL,
    CONSTRAINT pk_departamento PRIMARY KEY (DepID)
) ENGINE = InnoDB;

CREATE TABLE Empleado (
    EmpID           INT         NOT NULL AUTO_INCREMENT,
    Nombre          VARCHAR(70) NOT NULL,
    Apellido        VARCHAR(70) NOT NULL,
    Edad            INT         NOT NULL,
    Salario_Decimal DECIMAL(12) NOT NULL,
    DepID           INT         NOT NULL,
    CONSTRAINT pk_empleado PRIMARY KEY (EmpID),
    CONSTRAINT fk_empleado_departamento
        FOREIGN KEY (DepID) REFERENCES Departamento (DepID)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB;

CREATE INDEX idx_empleado_depid ON Empleado (DepID);

INSERT INTO Departamento (NombreDEPTO, Ubicacion) VALUES
    ('Recursos Humanos', 'Bogota - Piso 1'),
    ('Tecnologia',       'Bogota - Piso 3'),
    ('Ventas',           NULL);

INSERT INTO Empleado (Nombre, Apellido, Edad, Salario_Decimal, DepID) VALUES
    ('Laura',  'Gomez',     28, 3500000, 1),
    ('Carlos', 'Ramirez',   35, 5200000, 2),
    ('Andrea', 'Torres',    31, 4800000, 2),
    ('Julian', 'Perez',     42, 4100000, 3),
    ('Marta',  'Rodriguez', 26, 3900000, 3);

SELECT e.EmpID, e.Nombre, e.Apellido, e.Edad, e.Salario_Decimal,
       d.NombreDEPTO, d.Ubicacion
FROM Empleado e
JOIN Departamento d ON d.DepID = e.DepID
ORDER BY d.NombreDEPTO, e.Apellido;

SELECT d.NombreDEPTO, COUNT(e.EmpID) AS Total_Empleados
FROM Departamento d
LEFT JOIN Empleado e ON e.DepID = d.DepID
GROUP BY d.DepID, d.NombreDEPTO;
