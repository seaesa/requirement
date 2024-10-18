CREATE TABLE Role (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    roleName VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Provider (
    provider_id INT IDENTITY(1,1) PRIMARY KEY,
    nameProvider VARCHAR(255),
    contactPerson VARCHAR(255),
    phoneNumber VARCHAR(16),
    email VARCHAR(255),
    address VARCHAR(255),
    status VARCHAR(255)
);

CREATE TABLE CategoryDevice (
    categoryDevice_id INT IDENTITY(1,1) PRIMARY KEY,
    nameCategoryDevice VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Amenities (
    amenities_id INT IDENTITY(1,1) PRIMARY KEY,
    nameAmenities VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Apartment (
    apartment_id INT IDENTITY(1,1) PRIMARY KEY,
    apartmentName VARCHAR(255),
    location VARCHAR(255),
    buildYear INT,
    numberOfFloors INT,
    numberOfUnits INT,
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE Unit (
    unit_id INT IDENTITY(1,1) PRIMARY KEY,
    apartment_id INT FOREIGN KEY REFERENCES Apartment(apartment_id),
    roomNumber VARCHAR(255),
    floor INT,
    area INT,
    bedRooms INT,
    bathRooms INT,
    status VARCHAR(255),
    price DECIMAL(18, 2),
    description VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE UnitDevice (
    unitDevice_id INT IDENTITY(1,1) PRIMARY KEY,
    unit_id INT FOREIGN KEY REFERENCES Unit(unit_id),
    device_id INT FOREIGN KEY REFERENCES Device(device_id),
    installationDate DATE,
    location VARCHAR(255),
    maintenanceDate DATE,
    status DATETIME,
    deleteAt DATETIME
);

CREATE TABLE Device (
    device_id INT IDENTITY(1,1) PRIMARY KEY,
    provider_id INT FOREIGN KEY REFERENCES Provider(provider_id),
    categoryDevice_id INT FOREIGN KEY REFERENCES CategoryDevice(categoryDevice_id),
    nameDevice VARCHAR(255),
    description VARCHAR(255),
    price DECIMAL(18, 2),
    warrantyPeriod VARCHAR(10),
    status DATETIME,
    deleteAt DATETIME
);

CREATE TABLE Employee (
    employee_id INT IDENTITY(1,1) PRIMARY KEY,
    role_id INT FOREIGN KEY REFERENCES Role(role_id),
    apartment_id INT FOREIGN KEY REFERENCES Apartment(apartment_id),
    userName VARCHAR(255),
    password VARCHAR(255),
    avata VARCHAR(255),
    fullName VARCHAR(255),
    dateOfBirth DATE,
    gender CHAR(1),
    address VARCHAR(255),
    phoneNumber VARCHAR(16),
    socialSecurityNumber VARCHAR(255),
    email VARCHAR(255),
    startDate DATE,
    salary DECIMAL(18, 2),
    status VARCHAR(255),
    deletedAt DATETIME
);

CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    unit_id INT FOREIGN KEY REFERENCES Unit(unit_id),
    candidates_id INT FOREIGN KEY REFERENCES Candidates(candidates_id),
    userName VARCHAR(255),
    password VARCHAR(255),
    avata VARCHAR(255),
    fullName VARCHAR(255),
    role VARCHAR(255),
    dateOfBirth DATE,
    gender CHAR(1),
    address VARCHAR(255),
    phoneNumber VARCHAR(16),
    email VARCHAR(255),
    occupation VARCHAR(255),
    status VARCHAR(255),
    deletedAt DATETIME
);

CREATE TABLE Candidates (
    candidates_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    nameCandidates VARCHAR(255),
    phoneNumber VARCHAR(16),
    email VARCHAR(255),
    status VARCHAR(255),
    fullName VARCHAR(255),
    dateOfBirth DATE,
    gender CHAR(1),
    address VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE Contract (
    contract_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customer(customer_id),
    service_id INT FOREIGN KEY REFERENCES Service(service_id),
    startDate DATE,
    endDate DATE,
    contractTerms VARCHAR(255),
    specialTerms VARCHAR(255),
    amount DECIMAL(18, 2),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE Service (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    provider_id INT FOREIGN KEY REFERENCES Provider(provider_id),
    nameService VARCHAR(255),
    description VARCHAR(255),
    categoryService VARCHAR(255),
    price DECIMAL(18, 2),
    duration VARCHAR(255),
    contactInformation VARCHAR(255),
    scopeOfServices VARCHAR(255),
    qualityStandards VARCHAR(255),
    implementationschedule VARCHAR(255),
    deleteAt DATETIME,
    status VARCHAR(255)
);

CREATE TABLE Bill (
    bill_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customer(customer_id),
    service_id INT FOREIGN KEY REFERENCES Service(service_id),
    amount DECIMAL(18, 2),
    dueDateTime DATETIME,
    createdDateTime DATETIME,
    lateFee DECIMAL(18, 2),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE ServiceRequest (
    serviceRequest_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customer(customer_id),
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    service_id INT FOREIGN KEY REFERENCES Service(service_id),
    requestDateTime DATETIME,
    description VARCHAR(255),
    status VARCHAR(255),
    completionDateTime DATETIME,
    deleteAt DATETIME
);

CREATE TABLE FeedbackEmployee (
    feedbackEmployee_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT FOREIGN KEY REFERENCES Customer(customer_id),
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    rating INT,
    feedback VARCHAR(255),
    createdDateTime DATETIME,
    deleteAt DATETIME
);

CREATE TABLE Maintenance (
    maintenance_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    provider_id INT FOREIGN KEY REFERENCES Provider(provider_id),
    nameMaintenance VARCHAR(255),
    description VARCHAR(255),
    startDate DATE,
    endDate DATE,
    note VARCHAR(255),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE UnitMaintenance (
    unitMaintenance_id INT IDENTITY(1,1) PRIMARY KEY,
    unit_id INT FOREIGN KEY REFERENCES Unit(unit_id),
    maintenance_id INT FOREIGN KEY REFERENCES Maintenance(maintenance_id),
    startDate DATE,
    endDate DATE,
    description VARCHAR(255),
    cost DECIMAL(18, 2),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE Timekeeping (
    timekeeping_id INT IDENTITY(1,1) PRIMARY KEY,
    checkinTime DATETIME,
    workDate DATE
);

CREATE TABLE EmployeeTimekeeping (
    employeeTimekeeping_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    timekeeping_id INT FOREIGN KEY REFERENCES Timekeeping(timekeeping_id),
    checkinTime DATETIME,
    checkoutTime DATETIME,
    Image VARCHAR(255),
    overtimeHours INT,
    status VARCHAR(255)
);

CREATE TABLE Profile (
    profile_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    categoryProfile VARCHAR(255),
    nameFile VARCHAR(255),
    link VARCHAR(255),
    deletedAt DATETIME,
    issuedBy VARCHAR(255),
    issuedDate DATE,
    contractStartDate DATE,
    contractEndDate DATE
);

CREATE TABLE TrainingCatalog (
    trainingCatalog_id INT IDENTITY(1,1) PRIMARY KEY,
    trainingCatalogName VARCHAR(255),
    description VARCHAR(255),
    duration VARCHAR(255),
    certificate BIT
);

CREATE TABLE ClassTraining (
    classTraining_id INT IDENTITY(1,1) PRIMARY KEY,
    trainingCatalog_id INT FOREIGN KEY REFERENCES TrainingCatalog(trainingCatalog_id),
    nameClassTraining VARCHAR(255),
    status VARCHAR(255),
    description VARCHAR(255),
    location VARCHAR(255),
    startDate DATE,
    endDate DATE,
    deletedAt DATETIME
);

CREATE TABLE EmployeeTraining (
    employeeTraining_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    classTraining_id INT FOREIGN KEY REFERENCES ClassTraining(classTraining_id),
    assess INT,
    status VARCHAR(255),
    deletedAt DATETIME
);

CREATE TABLE Notification (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    user_id INT,
    userType VARCHAR(20),
    title VARCHAR(255),
    message VARCHAR(255),
    createdDate DATETIME
);

CREATE TABLE Report (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    title VARCHAR(255),
    information VARCHAR(255),
    fileLinkReport VARCHAR(255),
    createdDateTime DATETIME,
    respond VARCHAR(255),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE EmployeeApartment (
    employeeApartment_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    apartment_id INT FOREIGN KEY REFERENCES Apartment(apartment_id),
    role VARCHAR(255),
    startDate DATE,
    salary DECIMAL(18, 2),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE MaintenanceHistory (
    maintenanceHistory_id INT IDENTITY(1,1) PRIMARY KEY,
    unitDevice_id INT FOREIGN KEY REFERENCES UnitDevice(unitDevice_id),
    maintenance_id INT FOREIGN KEY REFERENCES Maintenance(maintenance_id),
    technician_name VARCHAR(255),
    description VARCHAR(255),
    note VARCHAR(255),
    cost DECIMAL(18, 2),
    status VARCHAR(255),
    nextMaintenanceDate DATE
);

CREATE TABLE PaymentHistory (
    paymentHistory_id INT IDENTITY(1,1) PRIMARY KEY,
    bill_id INT FOREIGN KEY REFERENCES Bill(bill_id),
    paymentDateTime DATETIME,
    amountPaid DECIMAL(18, 2),
    paymentMethod VARCHAR(255),
    lateFee DECIMAL(18, 2),
    note VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE IncomeType (
    incomeType_id INT IDENTITY(1,1) PRIMARY KEY,
    nameIncomeType VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE OutcomeType (
    outcomeType_id INT IDENTITY(1,1) PRIMARY KEY,
    nameOutcomeType VARCHAR(255),
    description VARCHAR(255)
);

CREATE TABLE Outcome (
    outcome_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    outcomeType_id INT FOREIGN KEY REFERENCES OutcomeType(outcomeType_id),
    amount DECIMAL(18, 2),
    description VARCHAR(255),
    spentDateTime DATETIME
);

CREATE TABLE Income (
    income_id INT IDENTITY(1,1) PRIMARY KEY,
    employee_id INT FOREIGN KEY REFERENCES Employee(employee_id),
    incomeType_id INT FOREIGN KEY REFERENCES IncomeType(incomeType_id),
    amount DECIMAL(18, 2),
    description VARCHAR(255),
    receivedDateTime DATETIME
);

CREATE TABLE ApartmentAmenities (
    apartmentAmenity_id INT IDENTITY(1,1) PRIMARY KEY,
    apartment_id INT FOREIGN KEY REFERENCES Apartment(apartment_id),
    amenity_id INT FOREIGN KEY REFERENCES Amenities(amenities_id),
    operatingHours INT,
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE UnitAmenities (
    unitAmenity_id INT IDENTITY(1,1) PRIMARY KEY,
    unit_id INT FOREIGN KEY REFERENCES Unit(unit_id),
    amenities_id INT FOREIGN KEY REFERENCES Amenities(amenities_id),
    status VARCHAR(255),
    deleteAt DATETIME
);

CREATE TABLE ActivityHistory (
    activity_id INT IDENTITY(1,1) PRIMARY KEY,
    tableName VARCHAR(255),
    record_id INT,
    activityType VARCHAR(20),
    activityDateTime DATETIME,
    description VARCHAR(255),
    performedByID INT,
    deleteAt DATETIME
);
