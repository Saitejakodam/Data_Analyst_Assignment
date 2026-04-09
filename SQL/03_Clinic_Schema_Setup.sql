CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

INSERT INTO clinics VALUES 
('CNC-001', 'City Health Clinic', 'Mumbai', 'Maharashtra', 'India'),
('CNC-002', 'Wellness Center', 'Pune', 'Maharashtra', 'India'),
('CNC-003', 'Apex Care', 'Bangalore', 'Karnataka', 'India'),
('CNC-004', 'Metro Clinic', 'Delhi', 'Delhi', 'India'),
('CNC-005', 'Safe Hands', 'Mumbai', 'Maharashtra', 'India');


CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    mobile VARCHAR(15)
);

INSERT INTO customer VALUES 
('U101', 'Alice Green', '9811100001'),
('U102', 'Bob Knight', '9811100002'),
('U103', 'Charlie Day', '9811100003'),
('U104', 'Diana Prince', '9811100004'),
('U105', 'Ethan Hunt', '9811100005');

CREATE TABLE clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(10, 2),
    datetime DATETIME,
    sales_channel VARCHAR(50),
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinic_sales VALUES 
('ORD-001', 'U101', 'CNC-001', 5000.00, '2021-03-10 10:30:00', 'Direct'),
('ORD-002', 'U102', 'CNC-001', 12000.00, '2021-03-15 14:00:00', 'Online'),
('ORD-003', 'U103', 'CNC-002', 8500.00, '2021-04-05 11:20:00', 'Direct'),
('ORD-004', 'U101', 'CNC-003', 15000.00, '2021-04-20 16:45:00', 'Affiliate'),
('ORD-005', 'U104', 'CNC-001', 2500.00, '2021-05-12 09:15:00', 'Online');


CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description TEXT,
    amount DECIMAL(10, 2),
    datetime DATETIME,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO expenses VALUES 
('EXP-001', 'CNC-001', 'Medical Supplies', 2000.00, '2021-03-01 09:00:00'),
('EXP-002', 'CNC-001', 'Rent', 3000.00, '2021-03-05 10:00:00'),
('EXP-003', 'CNC-002', 'Electricity', 1500.00, '2021-04-02 11:00:00'),
('EXP-004', 'CNC-003', 'Cleaning Services', 800.00, '2021-04-10 08:30:00'),
('EXP-005', 'CNC-004', 'Staff Salaries', 10000.00, '2021-05-01 12:00:00');

