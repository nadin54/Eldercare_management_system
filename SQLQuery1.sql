CREATE DATABASE ElderCare_management;

-- Table1: Room

CREATE TABLE Room(
id INT IDENTITY(1,1) PRIMARY KEY,
room_no INT UNIQUE NOT NULL,
capacity INT NOT NULL,
type VARCHAR(50) NOT NULL  --SINGLE OR DOUBLE
);

--Table2: Resident

CREATE TABLE Resident(
id_R INT IDENTITY(1,1) PRIMARY KEY,
Fname VARCHAR(100) NOT NULL,
Lname VARCHAR(100) NOT NULL,
DOB DATE NOT NULL,
gender VARCHAR(50) NOT NULL CHECK(gender IN ('Male', 'Female')),
admission_date DATE NOT NULL,
room_id INT,
contact VARCHAR(100) NOT NULL,
notes TEXT,
FOREIGN KEY (room_id) REFERENCES Room(id) ON DELETE SET NULL,
Full_name AS (Fname + ' ' + Lname)
);

--Table3: Staff

CREATE TABLE Staff(
id INT IDENTITY(1,1) PRIMARY KEY,
Fname VARCHAR(100) NOT NULL,
Lname VARCHAR(100) NOT NULL,
role VARCHAR(50) NOT NULL CHECK(role IN ('Doctor', 'Nurse', 'Admin')),
phone VARCHAR(50) NOT NULL,
hire_date DATE
);

--Table4: Medical_Record

CREATE TABLE Medical_Record(
id INT IDENTITY(1,1) PRIMARY KEY,
resident_id INT,
record_date DATETIME,
diagnosis TEXT,
treatment TEXT,
doctor_id INT,
FOREIGN KEY (resident_id) REFERENCES Resident(id_R) ON DELETE CASCADE,
FOREIGN KEY (doctor_id) REFERENCES Staff(id) ON DELETE SET NULL
);

--Table5: Medication

CREATE TABLE Medication(
id INT IDENTITY(1,1) PRIMARY KEY,
resident_id INT,
med_name VARCHAR(100) NOT NULL,
dose VARCHAR(50) NOT NULL,
frequency VARCHAR(100) NOT NULL,
start_date DATE NOT NULL,
end_date DATE ,
FOREIGN KEY (resident_id) REFERENCES Resident(id_R) ON DELETE CASCADE
);

--Table6: Visit

CREATE TABLE Visit(
id INT IDENTITY(1,1) PRIMARY KEY,
resident_id INT,
visitor_name VARCHAR(100) NOT NULL,
relation VARCHAR(100) NOT NULL,
visit_datetime DATETIME NOT NULL,
notes TEXT,
FOREIGN KEY (resident_id) REFERENCES Resident(id_R) ON DELETE CASCADE
);

--Table7: bill

CREATE TABLE Bill(
id INT IDENTITY(1,1) PRIMARY KEY,
resident_id INT,
bill_date DATE NOT NULL,
amount DECIMAL(10, 2) NOT NULL,
description TEXT,
paid BIT DEFAULT 0,
FOREIGN KEY (resident_id) REFERENCES Resident(id_R) ON DELETE CASCADE
);
