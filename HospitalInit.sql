DROP DATABASE hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE Ward (
	wardNo INT, 
    wardName VARCHAR(64), 
    location VARCHAR(128), 
    noBeds INT, 
    phoneExt VARCHAR(24),
    
    PRIMARY KEY (wardNo)
);

CREATE TABLE Staff (
	staffNo INT, 
    staffName VARCHAR(128), 
    address VARCHAR(128), 
    phone VARCHAR(24), 
    DOB DATE, 
    gender CHAR, 
    NIN VARCHAR(64), 
    position VARCHAR(64), 
    curSalary DECIMAL(10,2), 
    salaryScale SMALLINT, 
    ContractType VARCHAR(64), 
    HoursPerWeek SMALLINT, 
    qualifications VARCHAR(512), 
    wkExp VARCHAR(512), 
    empContract VARCHAR(64),
    
    PRIMARY KEY (staffNo)
);

CREATE TABLE WeeklyRota (
	weekStartDate DATE, 
    wardNo INT, 
    staffNo INT, 
    staffName VARCHAR(128), 
    staffAddress VARCHAR(128), 
    staffPhone  VARCHAR(24), 
    position VARCHAR(64), 
    shift VARCHAR(64),
    
    PRIMARY KEY (weekStartDate, wardNo, staffNo),
    FOREIGN KEY (wardNo) REFERENCES Ward(wardNo) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (staffNo) REFERENCES Staff(staffNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Patient (
	patNo INT NOT NULL, 
    patName VARCHAR(128) NOT NULL, 
    address VARCHAR(128), 
    phone VARCHAR(21), 
    DOB DATE, 
    gender CHAR, 
    marStatus BOOLEAN, 
    dateReg DATE, 
    nextOfKinInfo  VARCHAR(512),
    
    PRIMARY KEY (patNo)
);

CREATE TABLE LocalDoctor (
	docNo INT, 
    fullName VARCHAR(128), 
    clinicNo INT, 
    clinicAddress VARCHAR(128), 
    clinicPhone VARCHAR(21),
    
    PRIMARY KEY (docNo)
);

CREATE TABLE Appointment (
	apptNo INT,
    consultantName VARCHAR(128),
    consultantNo INT,
    apptDate DATE,
    apptTime DATE,
    room VARCHAR(6),
    patNo INT,
    
    PRIMARY KEY (apptNo),
    FOREIGN KEY (patNo) REFERENCES Patient(patNo)
);

CREATE TABLE InPatient (
	patNo INT,
    patName VARCHAR(128),
    dateOnWaitList DATE,
    wardReq VARCHAR(128),
    expectedStay SMALLINT,
    dateInWard DATE,
    expDateDepart DATE,
    actDateDepart DATE,
    bedNo INT,
    
    PRIMARY KEY (patNo, dateOnWaitList),
    FOREIGN KEY (patNo) REFERENCES Patient(patNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE OutPatient (
	patNo INT,
    patName VARCHAR(128),
    address VARCHAR(128),
    phone VARCHAR(21),
    DOB DATE,
    gender CHAR,
    aptDate DATE,
    aptTime DATE,
    
    PRIMARY KEY (patNo, aptDate),
    FOREIGN KEY (patNo) REFERENCES Patient(patNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Medication (
	patNo INT NOT NULL,
    patName VARCHAR(128) NOT NULL,
    wardNo INT NOT NULL,
    drugNo INT,
    drugName VARCHAR(128),
    unitsPerDay VARCHAR(40),
    adminMethod VARCHAR(512),
    startDate DATE,
    finishDate DATE,

	PRIMARY KEY (patNo, drugNo, startDate),
    FOREIGN KEY (patNo) REFERENCES Patient(patNo) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (wardNo) REFERENCES Ward(wardNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Supply (
	supplyNo INT,
    supplyName VARCHAR(128),
    description  VARCHAR(5121),
    quantity INT,
    reorderLev INT,
    costPerUnit DECIMAL(12,2),
    Pharmaceutical BOOLEAN,
    
    PRIMARY KEY (supplyNo)
);

CREATE TABLE Pharmaceutical (
	drugNo INT,
    dosage DECIMAL(10,4),
    adminMeth VARCHAR(128),
    
    PRIMARY KEY (drugNo)
);

CREATE TABLE WardRequisition (
	reqNo INT,
    staffName VARCHAR(128),
    wardNo INT,
    wardName VARCHAR(128),
    prodNo INT,
    prodName VARCHAR(128),
    description VARCHAR(512),
    dosage DECIMAL(10,4),
    adminMeth VARCHAR(128),
    costPerUnit DECIMAL(10,2),
    quantityReq INT,
    chargeNurse VARCHAR(128),
    reqDate DATE,
    
    PRIMARY KEY (reqNo),
    FOREIGN KEY (wardNo) REFERENCES Ward(wardNo) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Supplier (
	supNo INT,
	supName VARCHAR(128),
	address VARCHAR(128),
	hone VARCHAR(128),
	faxNo INT,

	PRIMARY KEY (supNo)
);