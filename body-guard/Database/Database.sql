-- Database creation
-- DROP DATABASE dbBODYGUARD;
CREATE DATABASE dbBODYGUARD;
GO
USE dbBODYGUARD;
GO

-- Role Table
CREATE TABLE Role (
    role_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    roleName VARCHAR(100),
    description VARCHAR(255)
);
GO

-- User Table (Sử dụng dấu ngoặc vuông để tránh xung đột từ khóa)
CREATE TABLE [User] (
    user_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    role_id INT,
    employee_id INT,
    userName VARCHAR(255),
    [password] VARCHAR(255),
    status VARCHAR(20),
    avata VARCHAR(100),
    email VARCHAR(255),
    gender VARCHAR(10),
    dateOfBirth DATE,
    address VARCHAR(255),
    phoneNumber VARCHAR(20),
    createdDate DATE,
    updatedDate DATE,
    deletedAt DATE,
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);
GO

-- Employee Table
CREATE TABLE Employee (
    employee_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    status VARCHAR(20),
    avata VARCHAR(100),
    name VARCHAR(255),
    email VARCHAR(255),
    phoneNumber VARCHAR(20),
    gender VARCHAR(10),
    dateOfBirth DATE,
    address VARCHAR(255),
    createdDate DATE,
    updatedDate DATE,
    deletedAt DATE,
    numbersOfDayOff INT,
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
GO

-- Service Table
CREATE TABLE Service (
    service_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    serviceName VARCHAR(100),
    description VARCHAR(255),
    price DECIMAL(10, 2),
    updatedDate DATE
);
GO

-- ServiceRequest Table
CREATE TABLE ServiceRequest (
    serviceRequest_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    service_id INT,
    status VARCHAR(20),
    numberOfGuards INT,
    budget DECIMAL(10, 2),
    address VARCHAR(255),
    startDate DATE,
    endDate DATE,
    note VARCHAR(255),
    createdDate DATE,
    updatedDate DATE,
    deletedAt DATE,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (service_id) REFERENCES Service(service_id)
);
GO

-- Contract Table
CREATE TABLE Contract (
    contract_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    serviceRequest_id INT,
    status VARCHAR(20),
    numberOfGuards INT,
    address VARCHAR(255),
    startDate DATE,
    endDate DATE,
    price DECIMAL(10, 2),
    tax DECIMAL(10, 2),
    paymethod VARCHAR(100),
    createdDate DATE,
    rating INT,
    feedBack VARCHAR(255),
    FOREIGN KEY (serviceRequest_id) REFERENCES ServiceRequest(serviceRequest_id)
);
GO

-- Profile Table
CREATE TABLE Profile (
    profile_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    link VARCHAR(100),
    createdDate DATE,
    updatedDate DATE,
    deletedAt DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
GO

-- Mission Table
CREATE TABLE Mission (
    mission_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    contract_id INT,
    employee_id INT,
    description VARCHAR(255),
    status VARCHAR(20),
    taskDescription VARCHAR(255),
    address VARCHAR(255),
    startDate DATE,
    endDate DATE,
    salary DECIMAL(10, 2),
    rating INT,
    feedBack VARCHAR(255),
    createdDate DATE,
    updatedDate DATE,
    deletedAt DATE,
    FOREIGN KEY (contract_id) REFERENCES Contract(contract_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);
GO

-- TrainingCatalog Table
CREATE TABLE TrainingCatalog (
    trainingCatalog_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    trainingCatalogName VARCHAR(255),
    description VARCHAR(255),
    duration VARCHAR(255),
    certificate BIT,
    createdDate DATE,
    updatedDate DATE
);
GO

-- ClassTraining Table
CREATE TABLE ClassTraining (
    classTraining_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    trainingCatalog_id INT,
    nameClassTraining VARCHAR(255),
    status VARCHAR(20),
    description VARCHAR(255),
    location VARCHAR(255),
    startDate DATE,
    endDate DATE,
    deletedAt DATE,
    FOREIGN KEY (trainingCatalog_id) REFERENCES TrainingCatalog(trainingCatalog_id)
);
GO

-- EmployeeTraining Table
CREATE TABLE EmployeeTraining (
    employeeTraining_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    classTraining_id INT,
    status VARCHAR(20),
    deletedAt DATE,
    assess VARCHAR(255),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (classTraining_id) REFERENCES ClassTraining(classTraining_id)
);
GO

-- Notification Table
CREATE TABLE Notification (
    notification_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    employee_id INT,
    user_id INT,
    title VARCHAR(100),
    message VARCHAR(255),
    createdDate DATE,
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id),
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
GO

-- Report Table
CREATE TABLE Report (
    report_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    contract_id INT,
    title VARCHAR(100),
    infomation VARCHAR(255),
    status VARCHAR(20),
    fileLinkReport VARCHAR(100),
    createdDate DATE,
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (contract_id) REFERENCES Contract(contract_id)
);
GO

-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    mission_id INT,
    status VARCHAR(20),
    checkInTime DATETIME,
    checkOutTime DATETIME,
    date DATE,
    FOREIGN KEY (mission_id) REFERENCES Mission(mission_id)
);
GO

-- File Table (Sử dụng dấu ngoặc vuông để tránh xung đột từ khóa)
CREATE TABLE [File] (
    file_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    contract_id INT,
    categoryFile VARCHAR(100),
    linkFile VARCHAR(100),
    FOREIGN KEY (contract_id) REFERENCES Contract(contract_id)
);
GO

-- Insert roles before inserting users
INSERT INTO Role (roleName, description) VALUES 
('Customer', 'Client who requests security services'),
('Admin', 'System administrator with full access'),
('Staff', 'General staff handling day-to-day operations'),
('Guard', 'Security personnel assigned to missions'),
('Guard Manager', 'Manager responsible for security personnel'),
('Customer Support', 'Support staff for customer inquiries'),
('Auditor', 'Responsible for auditing operations and contracts'),
('Trainer', 'Conducts training sessions for employees'),
('Contract Manager', 'Handles contracts and related processes');
GO

-- Insert users with valid role_id references
INSERT INTO [User] (role_id, employee_id, userName, [password], status, avata, email, gender, dateOfBirth, address, phoneNumber, createdDate, updatedDate, deletedAt) VALUES 
(1, 1, 'johndoe', 'password123', 'Active', 'avatar1.png', 'johndoe@gmail.com', 'Male', '1985-07-10', '123 Main St, New York, NY', '1234567890', '2024-01-01', '2024-01-01', NULL),
(2, 2, 'janedoe', 'password456', 'Suspended', 'avatar2.png', 'janedoe@gmail.com', 'Female', '1990-05-15', '456 Oak St, Los Angeles, CA', '2345678901', '2024-02-01', '2024-02-01', NULL),
(3, 3, 'alicew', 'password789', 'Active', 'avatar3.png', 'alicew@gmail.com', 'Female', '1987-08-23', '789 Pine St, Chicago, IL', '3456789012', '2024-03-01', '2024-03-01', NULL),
(4, 4, 'bobm', 'password321', 'Deleted', 'avatar4.png', 'bobm@gmail.com', 'Male', '1983-11-12', '321 Maple St, Houston, TX', '4567890123', '2024-04-01', '2024-04-01', NULL),
(5, 5, 'charlesd', 'password654', 'Active', 'avatar5.png', 'charlesd@gmail.com', 'Male', '1995-12-31', '654 Cedar St, Phoenix, AZ', '5678901234', '2024-05-01', '2024-05-01', NULL),
(6, 6, 'emilyr', 'password987', 'Active', 'avatar6.png', 'emilyr@gmail.com', 'Female', '1992-03-21', '987 Birch St, San Antonio, TX', '6789012345', '2024-06-01', '2024-06-01', NULL),
(7, 7, 'franks', 'password123', 'Active', 'avatar7.png', 'franks@gmail.com', 'Male', '1989-07-09', '123 Spruce St, San Diego, CA', '7890123456', '2024-07-01', '2024-07-01', NULL),
(8, 8, 'gracep', 'password456', 'Active', 'avatar8.png', 'gracep@gmail.com', 'Female', '1991-05-13', '456 Elm St, Dallas, TX', '8901234567', '2024-08-01', '2024-08-01', NULL),
(9, 9, 'henryc', 'password789', 'Suspended', 'avatar9.png', 'henryc@gmail.com', 'Male', '1986-09-25', '789 Fir St, San Jose, CA', '9012345678', '2024-09-01', '2024-09-01', NULL),
(1, 10, 'isabellam', 'password321', 'Deleted', 'avatar10.png', 'isabellam@gmail.com', 'Female', '1988-11-18', '321 Chestnut St, Austin, TX', '0123456789', '2024-10-01', '2024-10-01', NULL),
(1, 11, 'jacksonb', 'password654', 'Active', 'avatar11.png', 'jacksonb@gmail.com', 'Male', '1993-02-11', '654 Redwood St, Jacksonville, FL', '2345678901', '2024-11-01', '2024-11-01', NULL),
(2, 12, 'kellyd', 'password987', 'Active', 'avatar12.png', 'kellyd@gmail.com', 'Female', '1984-06-14', '987 Alder St, Columbus, OH', '3456789012', '2024-12-01', '2024-12-01', NULL),
(3, 13, 'lindaj', 'password123', 'Active', 'avatar13.png', 'lindaj@gmail.com', 'Female', '1990-03-28', '123 Dogwood St, Charlotte, NC', '4567890123', '2024-01-02', '2024-01-02', NULL),
(4, 14, 'michaelt', 'password456', 'Suspended', 'avatar14.png', 'michaelt@gmail.com', 'Male', '1987-08-03', '456 Willow St, Fort Worth, TX', '5678901234', '2024-02-02', '2024-02-02', NULL),
(5, 15, 'natalieh', 'password789', 'Active', 'avatar15.png', 'natalieh@gmail.com', 'Female', '1985-11-26', '789 Palm St, Detroit, MI', '6789012345', '2024-03-02', '2024-03-02', NULL),
(6, 16, 'oliverp', 'password321', 'Deleted', 'avatar16.png', 'oliverp@gmail.com', 'Male', '1994-12-19', '321 Cypress St, Memphis, TN', '7890123456', '2024-04-02', '2024-04-02', NULL),
(7, 17, 'paulinev', 'password654', 'Active', 'avatar17.png', 'paulinev@gmail.com', 'Female', '1989-04-09', '654 Magnolia St, Baltimore, MD', '8901234567', '2024-05-02', '2024-05-02', NULL),
(8, 18, 'quincyw', 'password987', 'Active', 'avatar18.png', 'quincyw@gmail.com', 'Male', '1983-10-05', '987 Aspen St, Boston, MA', '9012345678', '2024-06-02', '2024-06-02', NULL),
(9, 19, 'rachelj', 'password123', 'Suspended', 'avatar19.png', 'rachelj@gmail.com', 'Female', '1992-09-21', '123 Poplar St, El Paso, TX', '0123456789', '2024-07-02', '2024-07-02', NULL),
(1, 20, 'stephent', 'password456', 'Deleted', 'avatar20.png', 'stephent@gmail.com', 'Male', '1988-01-15', '456 Aspen St, Nashville, TN', '1234567890', '2024-08-02', '2024-08-02', NULL);
GO

-- Insert corresponding employees after users are inserted
INSERT INTO Employee (user_id, status, avata, name, email, phoneNumber, gender, dateOfBirth, address, createdDate, updatedDate, deletedAt, numbersOfDayOff) VALUES 
(1, 'On Duty', 'avatar1.png', 'John Doe', 'johndoe@gmail.com', '1234567890', 'Male', '1985-07-10', '123 Main St, New York, NY', '2024-01-01', '2024-01-01', NULL, 5),
(2, 'On Leave', 'avatar2.png', 'Jane Doe', 'janedoe@gmail.com', '2345678901', 'Female', '1990-05-15', '456 Oak St, Los Angeles, CA', '2024-02-01', '2024-02-01', NULL, 10),
(3, 'Suspended', 'avatar3.png', 'Alice White', 'alicew@gmail.com', '3456789012', 'Female', '1987-08-23', '789 Pine St, Chicago, IL', '2024-03-01', '2024-03-01', NULL, 8),
(4, 'Resigned', 'avatar4.png', 'Bob Miller', 'bobm@gmail.com', '4567890123', 'Male', '1983-11-12', '321 Maple St, Houston, TX', '2024-04-01', '2024-04-01', NULL, 12),
(5, 'On Duty', 'avatar5.png', 'Charles Davis', 'charlesd@gmail.com', '5678901234', 'Male', '1995-12-31', '654 Cedar St, Phoenix, AZ', '2024-05-01', '2024-05-01', NULL, 7),
(6, 'On Duty', 'avatar6.png', 'Emily Roberts', 'emilyr@gmail.com', '6789012345', 'Female', '1992-03-21', '987 Birch St, San Antonio, TX', '2024-06-01', '2024-06-01', NULL, 5),
(7, 'On Duty', 'avatar7.png', 'Frank Smith', 'franks@gmail.com', '7890123456', 'Male', '1989-07-09', '123 Spruce St, San Diego, CA', '2024-07-01', '2024-07-01', NULL, 3),
(8, 'On Duty', 'avatar8.png', 'Grace Parker', 'gracep@gmail.com', '8901234567', 'Female', '1991-05-13', '456 Elm St, Dallas, TX', '2024-08-01', '2024-08-01', NULL, 4),
(9, 'Suspended', 'avatar9.png', 'Henry Clark', 'henryc@gmail.com', '9012345678', 'Male', '1986-09-25', '789 Fir St, San Jose, CA', '2024-09-01', '2024-09-01', NULL, 6),
(10, 'Resigned', 'avatar10.png', 'Isabella Martinez', 'isabellam@gmail.com', '0123456789', 'Female', '1988-11-18', '321 Chestnut St, Austin, TX', '2024-10-01', '2024-10-01', NULL, 9),
(11, 'On Duty', 'avatar11.png', 'Jackson Brown', 'jacksonb@gmail.com', '2345678901', 'Male', '1993-02-11', '654 Redwood St, Jacksonville, FL', '2024-11-01', '2024-11-01', NULL, 5),
(12, 'On Duty', 'avatar12.png', 'Kelly Davis', 'kellyd@gmail.com', '3456789012', 'Female', '1984-06-14', '987 Alder St, Columbus, OH', '2024-12-01', '2024-12-01', NULL, 8),
(13, 'On Duty', 'avatar13.png', 'Linda Jackson', 'lindaj@gmail.com', '4567890123', 'Female', '1990-03-28', '123 Dogwood St, Charlotte, NC', '2024-01-02', '2024-01-02', NULL, 10),
(14, 'Suspended', 'avatar14.png', 'Michael Taylor', 'michaelt@gmail.com', '5678901234', 'Male', '1987-08-03', '456 Willow St, Fort Worth, TX', '2024-02-02', '2024-02-02', NULL, 7),
(15, 'On Duty', 'avatar15.png', 'Natalie Harris', 'natalieh@gmail.com', '6789012345', 'Female', '1985-11-26', '789 Palm St, Detroit, MI', '2024-03-02', '2024-03-02', NULL, 5),
(16, 'Resigned', 'avatar16.png', 'Oliver Patterson', 'oliverp@gmail.com', '7890123456', 'Male', '1994-12-19', '321 Cypress St, Memphis, TN', '2024-04-02', '2024-04-02', NULL, 6),
(17, 'On Duty', 'avatar17.png', 'Pauline Vincent', 'paulinev@gmail.com', '8901234567', 'Female', '1989-04-09', '654 Magnolia St, Baltimore, MD', '2024-05-02', '2024-05-02', NULL, 4),
(18, 'On Duty', 'avatar18.png', 'Quincy Wilson', 'quincyw@gmail.com', '9012345678', 'Male', '1983-10-05', '987 Aspen St, Boston, MA', '2024-06-02', '2024-06-02', NULL, 5),
(19, 'Suspended', 'avatar19.png', 'Rachel Johnson', 'rachelj@gmail.com', '0123456789', 'Female', '1992-09-21', '123 Poplar St, El Paso, TX', '2024-07-02', '2024-07-02', NULL, 7),
(20, 'Resigned', 'avatar20.png', 'Stephen Thompson', 'stephent@gmail.com', '1234567890', 'Male', '1988-01-15', '456 Aspen St, Nashville, TN', '2024-08-02', '2024-08-02', NULL, 6);
GO

-- Insert services
INSERT INTO Service (serviceName, description, price, updatedDate) VALUES 
('Commercial Security', 'Security services for commercial properties', 500.00, '2024-01-01'),
('Event Security', 'Security services for events and gatherings', 1000.00, '2024-01-01'),
('Aviation Security', 'Security services for airports and airlines', 2000.00, '2024-01-01'),
('Transportation Security', 'Security services for transportation and logistics', 1500.00, '2024-01-01');
GO

-- Insert service requests after services and users are inserted
INSERT INTO ServiceRequest (user_id, service_id, status, numberOfGuards, budget, address, startDate, endDate, note, createdDate, updatedDate, deletedAt) VALUES 
(1, 1, 'Pending', 2, 1000.00, '123 Main St, New York, NY', '2024-01-05', '2024-01-10', 'Urgent', '2024-01-01', '2024-01-01', NULL),
(2, 2, 'Approved', 5, 5000.00, '456 Oak St, Los Angeles, CA', '2024-02-10', '2024-02-15', 'High profile event', '2024-01-10', '2024-01-10', NULL),
(3, 3, 'In Progress', 10, 20000.00, '789 Pine St, Chicago, IL', '2024-03-01', '2024-03-10', 'Airport security', '2024-02-01', '2024-02-01', NULL),
(4, 4, 'Completed', 8, 12000.00, '321 Maple St, Houston, TX', '2024-04-15', '2024-04-20', 'Transportation of valuable goods', '2024-03-10', '2024-03-10', NULL),
(5, 1, 'Cancelled', 3, 1500.00, '654 Cedar St, Phoenix, AZ', '2024-05-05', '2024-05-10', 'Client cancelled', '2024-04-01', '2024-04-01', NULL),
(6, 2, 'Rejected', 6, 6000.00, '987 Birch St, San Antonio, TX', '2024-06-10', '2024-06-15', 'Budget constraints', '2024-05-01', '2024-05-01', NULL),
(7, 3, 'On Hold', 7, 14000.00, '123 Spruce St, San Diego, CA', '2024-07-05', '2024-07-10', 'Client request for hold', '2024-06-01', '2024-06-01', NULL),
(8, 4, 'Pending', 4, 6000.00, '456 Elm St, Dallas, TX', '2024-08-10', '2024-08-15', 'VIP transport', '2024-07-01', '2024-07-01', NULL),
(9, 1, 'Approved', 2, 2000.00, '789 Fir St, San Jose, CA', '2024-09-01', '2024-09-05', 'Mall security', '2024-08-01', '2024-08-01', NULL),
(10, 2, 'In Progress', 5, 5000.00, '321 Chestnut St, Austin, TX', '2024-10-05', '2024-10-10', 'Concert security', '2024-09-01', '2024-09-01', NULL),
(11, 3, 'Completed', 10, 25000.00, '654 Redwood St, Jacksonville, FL', '2024-11-15', '2024-11-20', 'Airport security', '2024-10-01', '2024-10-01', NULL),
(12, 4, 'Cancelled', 6, 9000.00, '987 Alder St, Columbus, OH', '2024-12-10', '2024-12-15', 'Client cancelled', '2024-11-01', '2024-11-01', NULL),
(13, 1, 'Pending', 2, 1000.00, '123 Dogwood St, Charlotte, NC', '2024-01-05', '2024-01-10', 'Urgent request', '2024-12-01', '2024-12-01', NULL),
(14, 2, 'Approved', 5, 5000.00, '456 Willow St, Fort Worth, TX', '2024-02-10', '2024-02-15', 'Large event', '2024-01-10', '2024-01-10', NULL),
(15, 3, 'In Progress', 10, 20000.00, '789 Palm St, Detroit, MI', '2024-03-01', '2024-03-10', 'Critical operation', '2024-02-01', '2024-02-01', NULL),
(16, 4, 'Completed', 8, 12000.00, '321 Cypress St, Memphis, TN', '2024-04-15', '2024-04-20', 'Transport security', '2024-03-10', '2024-03-10', NULL),
(17, 1, 'Cancelled', 3, 1500.00, '654 Magnolia St, Baltimore, MD', '2024-05-05', '2024-05-10', 'Client changed mind', '2024-04-01', '2024-04-01', NULL),
(18, 2, 'Rejected', 6, 6000.00, '987 Aspen St, Boston, MA', '2024-06-10', '2024-06-15', 'Not enough funds', '2024-05-01', '2024-05-01', NULL),
(19, 3, 'On Hold', 7, 14000.00, '123 Poplar St, El Paso, TX', '2024-07-05', '2024-07-10', 'Delayed by client', '2024-06-01', '2024-06-01', NULL),
(20, 4, 'Pending', 4, 6000.00, '456 Aspen St, Nashville, TN', '2024-08-10', '2024-08-15', 'Critical VIP security', '2024-07-01', '2024-07-01', NULL);
GO

-- Insert contracts based on service requests after they are inserted
INSERT INTO Contract (serviceRequest_id, status, numberOfGuards, address, startDate, endDate, price, tax, paymethod, createdDate, rating, feedBack) VALUES 
(1, 'Draft', 2, '123 Main St, New York, NY', '2024-01-05', '2024-01-10', 1000.00, 50.00, 'Credit Card', '2024-01-01', 5, 'Excellent service'),
(2, 'Pending Approval', 5, '456 Oak St, Los Angeles, CA', '2024-02-10', '2024-02-15', 5000.00, 250.00, 'Bank Transfer', '2024-01-10', 4, 'Good service but could be better'),
(3, 'Active', 10, '789 Pine St, Chicago, IL', '2024-03-01', '2024-03-10', 20000.00, 1000.00, 'Credit Card', '2024-02-01', 5, 'Very satisfied'),
(4, 'Completed', 8, '321 Maple St, Houston, TX', '2024-04-15', '2024-04-20', 12000.00, 600.00, 'Cash', '2024-03-10', 3, 'Service was acceptable'),
(5, 'Cancelled', 3, '654 Cedar St, Phoenix, AZ', '2024-05-05', '2024-05-10', 1500.00, 75.00, 'Credit Card', '2024-04-01', NULL, 'Cancelled before service started'),
(6, 'Rejected', 6, '987 Birch St, San Antonio, TX', '2024-06-10', '2024-06-15', 6000.00, 300.00, 'Bank Transfer', '2024-05-01', NULL, 'Rejected due to budget'),
(7, 'On Hold', 7, '123 Spruce St, San Diego, CA', '2024-07-05', '2024-07-10', 14000.00, 700.00, 'Credit Card', '2024-06-01', NULL, 'On hold by client'),
(8, 'Draft', 4, '456 Elm St, Dallas, TX', '2024-08-10', '2024-08-15', 6000.00, 300.00, 'Cash', '2024-07-01', NULL, 'Draft stage'),
(9, 'Pending Approval', 2, '789 Fir St, San Jose, CA', '2024-09-01', '2024-09-05', 2000.00, 100.00, 'Credit Card', '2024-08-01', 4, 'Good service'),
(10, 'Active', 5, '321 Chestnut St, Austin, TX', '2024-10-05', '2024-10-10', 5000.00, 250.00, 'Bank Transfer', '2024-09-01', 5, 'Great experience'),
(11, 'Completed', 10, '654 Redwood St, Jacksonville, FL', '2024-11-15', '2024-11-20', 25000.00, 1250.00, 'Credit Card', '2024-10-01', 5, 'Highly satisfied'),
(12, 'Cancelled', 6, '987 Alder St, Columbus, OH', '2024-12-10', '2024-12-15', 9000.00, 450.00, 'Bank Transfer', '2024-11-01', NULL, 'Cancelled by client'),
(13, 'Draft', 2, '123 Dogwood St, Charlotte, NC', '2024-01-05', '2024-01-10', 1000.00, 50.00, 'Credit Card', '2024-12-01', NULL, 'Draft stage'),
(14, 'Pending Approval', 5, '456 Willow St, Fort Worth, TX', '2024-02-10', '2024-02-15', 5000.00, 250.00, 'Bank Transfer', '2024-01-10', 4, 'Good service'),
(15, 'Active', 10, '789 Palm St, Detroit, MI', '2024-03-01', '2024-03-10', 20000.00, 1000.00, 'Credit Card', '2024-02-01', 5, 'Very satisfied'),
(16, 'Completed', 8, '321 Cypress St, Memphis, TN', '2024-04-15', '2024-04-20', 12000.00, 600.00, 'Cash', '2024-03-10', 3, 'Service was acceptable'),
(17, 'Cancelled', 3, '654 Magnolia St, Baltimore, MD', '2024-05-05', '2024-05-10', 1500.00, 75.00, 'Credit Card', '2024-04-01', NULL, 'Cancelled before service started'),
(18, 'Rejected', 6, '987 Aspen St, Boston, MA', '2024-06-10', '2024-06-15', 6000.00, 300.00, 'Bank Transfer', '2024-05-01', NULL, 'Rejected due to budget'),
(19, 'On Hold', 7, '123 Poplar St, El Paso, TX', '2024-07-05', '2024-07-10', 14000.00, 700.00, 'Credit Card', '2024-06-01', NULL, 'On hold by client'),
(20, 'Draft', 4, '456 Aspen St, Nashville, TN', '2024-08-10', '2024-08-15', 6000.00, 300.00, 'Cash', '2024-07-01', NULL, 'Draft stage');
GO

-- Insert missions based on contracts after contracts are inserted
INSERT INTO Mission (contract_id, employee_id, description, status, taskDescription, address, startDate, endDate, salary, rating, feedBack, createdDate, updatedDate, deletedAt) VALUES 
(1, 1, 'Protect commercial property', 'Completed', 'Patrolling and monitoring', '123 Main St, New York, NY', '2024-01-05', '2024-01-10', 500.00, 5, 'Great job', '2024-01-01', '2024-01-01', NULL),
(2, 2, 'Event security for VIP', 'In Progress', 'Crowd control and security checks', '456 Oak St, Los Angeles, CA', '2024-02-10', '2024-02-15', 1200.00, 4, 'Good work', '2024-01-10', '2024-01-10', NULL),
(3, 3, 'Airport security', 'Active', 'Monitoring and patrolling airport premises', '789 Pine St, Chicago, IL', '2024-03-01', '2024-03-10', 2400.00, 5, 'Excellent', '2024-02-01', '2024-02-01', NULL),
(4, 4, 'Transport security', 'Completed', 'Escort valuable goods', '321 Maple St, Houston, TX', '2024-04-15', '2024-04-20', 1500.00, 3, 'Acceptable', '2024-03-10', '2024-03-10', NULL),
(5, 5, 'Mall security', 'Cancelled', 'Monitor mall premises', '654 Cedar St, Phoenix, AZ', '2024-05-05', '2024-05-10', 750.00, NULL, 'Cancelled before mission', '2024-04-01', '2024-04-01', NULL),
(6, 6, 'VIP transport', 'Rejected', 'Escort VIPs', '987 Birch St, San Antonio, TX', '2024-06-10', '2024-06-15', 1800.00, NULL, 'Rejected by client', '2024-05-01', '2024-05-01', NULL),
(7, 7, 'Critical operation', 'On Hold', 'Ensure critical infrastructure security', '123 Spruce St, San Diego, CA', '2024-07-05', '2024-07-10', 2100.00, NULL, 'On hold by client', '2024-06-01', '2024-06-01', NULL),
(8, 8, 'VIP security', 'Pending', 'Ensure safety of VIP', '456 Elm St, Dallas, TX', '2024-08-10', '2024-08-15', 1500.00, NULL, 'Pending approval', '2024-07-01', '2024-07-01', NULL),
(9, 9, 'Crowd control', 'Completed', 'Manage crowds at event', '789 Fir St, San Jose, CA', '2024-09-01', '2024-09-05', 1000.00, 4, 'Well done', '2024-08-01', '2024-08-01', NULL),
(10, 10, 'Concert security', 'In Progress', 'Ensure safety during concert', '321 Chestnut St, Austin, TX', '2024-10-05', '2024-10-10', 1250.00, 5, 'Great job', '2024-09-01', '2024-09-01', NULL),
(11, 11, 'Event security', 'Completed', 'Ensure safety during high profile event', '654 Redwood St, Jacksonville, FL', '2024-11-15', '2024-11-20', 3000.00, 5, 'Excellent work', '2024-10-01', '2024-10-01', NULL),
(12, 12, 'Security escort', 'Cancelled', 'Escort during transport', '987 Alder St, Columbus, OH', '2024-12-10', '2024-12-15', 2250.00, NULL, 'Cancelled by client', '2024-11-01', '2024-11-01', NULL),
(13, 13, 'VIP escort', 'Pending', 'Escort VIPs', '123 Dogwood St, Charlotte, NC', '2024-01-05', '2024-01-10', 500.00, NULL, 'Pending approval', '2024-12-01', '2024-12-01', NULL),
(14, 14, 'Event security', 'In Progress', 'Manage event security', '456 Willow St, Fort Worth, TX', '2024-02-10', '2024-02-15', 1200.00, 4, 'Good job', '2024-01-10', '2024-01-10', NULL),
(15, 15, 'Airport security', 'Active', 'Ensure safety at airport', '789 Palm St, Detroit, MI', '2024-03-01', '2024-03-10', 2400.00, 5, 'Excellent', '2024-02-01', '2024-02-01', NULL),
(16, 16, 'Critical transport', 'Completed', 'Escort valuable items', '321 Cypress St, Memphis, TN', '2024-04-15', '2024-04-20', 1500.00, 3, 'Satisfactory', '2024-03-10', '2024-03-10', NULL),
(17, 17, 'Mall security', 'Cancelled', 'Monitor mall premises', '654 Magnolia St, Baltimore, MD', '2024-05-05', '2024-05-10', 750.00, NULL, 'Cancelled before mission', '2024-04-01', '2024-04-01', NULL),
(18, 18, 'VIP security', 'Rejected', 'Ensure safety of VIP', '987 Aspen St, Boston, MA', '2024-06-10', '2024-06-15', 1800.00, NULL, 'Rejected by client', '2024-05-01', '2024-05-01', NULL),
(19, 19, 'Critical operation', 'On Hold', 'Ensure critical infrastructure security', '123 Poplar St, El Paso, TX', '2024-07-05', '2024-07-10', 2100.00, NULL, 'On hold by client', '2024-06-01', '2024-06-01', NULL),
(20, 20, 'VIP escort', 'Pending', 'Escort VIPs', '456 Aspen St, Nashville, TN', '2024-08-10', '2024-08-15', 1500.00, NULL, 'Pending approval', '2024-07-01', '2024-07-01', NULL);
GO

-- Insert training catalogs
INSERT INTO TrainingCatalog (trainingCatalogName, description, duration, certificate, createdDate, updatedDate) VALUES 
('Basic Security Training', 'Fundamental training for new guards', '1 month', 1, '2024-01-01', '2024-01-01'),
('Advanced Security Tactics', 'Advanced tactics and protocols', '3 months', 1, '2024-02-01', '2024-02-01'),
('Firearms Training', 'Training in the use of firearms', '2 months', 1, '2024-03-01', '2024-03-01'),
('Emergency Response', 'Emergency procedures and protocols', '1 month', 1, '2024-04-01', '2024-04-01');
GO

-- Insert class trainings after training catalogs are inserted
INSERT INTO ClassTraining (trainingCatalog_id, nameClassTraining, status, description, location, startDate, endDate, deletedAt) VALUES 
(1, 'Basic Security - Batch 1', 'Completed', 'Basic training for new recruits', 'New York, NY', '2024-01-01', '2024-01-31', NULL),
(2, 'Advanced Tactics - Batch 1', 'Ongoing', 'Advanced tactics for experienced guards', 'Los Angeles, CA', '2024-02-01', '2024-04-30', NULL),
(3, 'Firearms Training - Batch 1', 'Scheduled', 'Firearms training session', 'Chicago, IL', '2024-03-01', '2024-04-30', NULL),
(4, 'Emergency Response - Batch 1', 'Scheduled', 'Emergency response training', 'Houston, TX', '2024-04-01', '2024-04-30', NULL);
GO

-- Insert employee trainings after class trainings are inserted
INSERT INTO EmployeeTraining (employee_id, classTraining_id, status, deletedAt, assess) VALUES 
(1, 1, 'Completed', NULL, 'Passed with distinction'),
(2, 1, 'Completed', NULL, 'Passed with distinction'),
(3, 1, 'Completed', NULL, 'Passed with merit'),
(4, 2, 'Ongoing', NULL, NULL),
(5, 2, 'Ongoing', NULL, NULL),
(6, 2, 'Ongoing', NULL, NULL),
(7, 3, 'Scheduled', NULL, NULL),
(8, 3, 'Scheduled', NULL, NULL),
(9, 4, 'Scheduled', NULL, NULL),
(10, 4, 'Scheduled', NULL, NULL);
GO

-- Insert notifications after employees and users are inserted
INSERT INTO Notification (employee_id, user_id, title, message, createdDate) VALUES 
(1, 1, 'Training Completed', 'You have successfully completed the Basic Security Training.', '2024-01-31'),
(2, 2, 'Training Completed', 'You have successfully completed the Basic Security Training.', '2024-01-31'),
(3, 3, 'Training Completed', 'You have successfully completed the Basic Security Training.', '2024-01-31'),
(4, 4, 'Training Ongoing', 'Your Advanced Security Tactics training is ongoing.', '2024-02-15'),
(5, 5, 'Training Ongoing', 'Your Advanced Security Tactics training is ongoing.', '2024-02-15'),
(6, 6, 'Training Ongoing', 'Your Advanced Security Tactics training is ongoing.', '2024-02-15'),
(7, 7, 'Training Scheduled', 'Your Firearms Training has been scheduled.', '2024-03-01'),
(8, 8, 'Training Scheduled', 'Your Firearms Training has been scheduled.', '2024-03-01'),
(9, 9, 'Training Scheduled', 'Your Emergency Response Training has been scheduled.', '2024-04-01'),
(10, 10, 'Training Scheduled', 'Your Emergency Response Training has been scheduled.', '2024-04-01');
GO

-- Insert reports after users and contracts are inserted
INSERT INTO Report (user_id, contract_id, title, infomation, status, fileLinkReport, createdDate) VALUES 
(1, 1, 'Security Report', 'Security operations were successful.', 'Completed', 'report1.pdf', '2024-01-11'),
(2, 2, 'Event Report', 'Event security was handled efficiently.', 'Completed', 'report2.pdf', '2024-02-16'),
(3, 3, 'Airport Security Report', 'Airport security measures were effective.', 'Completed', 'report3.pdf', '2024-03-11'),
(4, 4, 'Transport Security Report', 'Transport security was managed successfully.', 'Completed', 'report4.pdf', '2024-04-21'),
(5, 5, 'Mall Security Report', 'Mall security was performed as per protocols.', 'Completed', 'report5.pdf', '2024-05-11'),
(6, 6, 'VIP Security Report', 'VIP security operations were successful.', 'Completed', 'report6.pdf', '2024-06-16'),
(7, 7, 'Critical Operation Report', 'Critical operations were executed with precision.', 'Completed', 'report7.pdf', '2024-07-11'),
(8, 8, 'Event Security Report', 'Event security was satisfactory.', 'Completed', 'report8.pdf', '2024-08-16'),
(9, 9, 'Crowd Control Report', 'Crowd control was maintained effectively.', 'Completed', 'report9.pdf', '2024-09-06'),
(10, 10, 'Concert Security Report', 'Concert security was successfully managed.', 'Completed', 'report10.pdf', '2024-10-11');
GO

-- Insert attendance records after missions are inserted
INSERT INTO Attendance (mission_id, status, checkInTime, checkOutTime, date) VALUES 
(1, 'Present', '2024-01-05 08:00:00', '2024-01-05 17:00:00', '2024-01-05'),
(2, 'Present', '2024-02-10 08:00:00', '2024-02-10 17:00:00', '2024-02-10'),
(3, 'Present', '2024-03-01 08:00:00', '2024-03-01 17:00:00', '2024-03-01'),
(4, 'Present', '2024-04-15 08:00:00', '2024-04-15 17:00:00', '2024-04-15'),
(5, 'Absent', NULL, NULL, '2024-05-05'),
(6, 'Present', '2024-06-10 08:00:00', '2024-06-10 17:00:00', '2024-06-10'),
(7, 'Present', '2024-07-05 08:00:00', '2024-07-05 17:00:00', '2024-07-05'),
(8, 'Present', '2024-08-10 08:00:00', '2024-08-10 17:00:00', '2024-08-10'),
(9, 'Present', '2024-09-01 08:00:00', '2024-09-01 17:00:00', '2024-09-01'),
(10, 'Present', '2024-10-05 08:00:00', '2024-10-05 17:00:00', '2024-10-05');
GO

-- Insert file records after contracts are inserted
INSERT INTO [File] (contract_id, categoryFile, linkFile) VALUES 
(1, 'Contract', 'contract1.pdf'),
(2, 'Contract', 'contract2.pdf'),
(3, 'Contract', 'contract3.pdf'),
(4, 'Contract', 'contract4.pdf'),
(5, 'Contract', 'contract5.pdf'),
(6, 'Contract', 'contract6.pdf'),
(7, 'Contract', 'contract7.pdf'),
(8, 'Contract', 'contract8.pdf'),
(9, 'Contract', 'contract9.pdf'),
(10, 'Contract', 'contract10.pdf');

