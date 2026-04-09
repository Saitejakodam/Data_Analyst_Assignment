
CREATE TABLE users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

INSERT INTO users VALUES 
('U001', 'John Doe', '9711111111', 'john.doe@example.com', '123 Street A, NYC'),
('U002', 'Jane Smith', '9722222222', 'jane.s@example.com', '456 Avenue B, LA'),
('U003', 'Mike Ross', '9733333333', 'mike.r@example.com', '789 Blvd C, CHI'),
('U004', 'Harvey S', '9744444444', 'harvey.s@example.com', '101 Park Ave, NYC'),
('U005', 'Donna P', '9755555555', 'donna.p@example.com', '202 Bay St, SF');



CREATE TABLE bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME,
    room_no VARCHAR(20),
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO bookings VALUES 
('BK001', '2021-09-23 07:36:48', 'RM101', 'U001'),
('BK002', '2021-10-15 10:00:00', 'RM202', 'U002'),
('BK003', '2021-11-05 14:20:10', 'RM303', 'U003'),
('BK004', '2021-11-20 09:15:00', 'RM101', 'U001'),
('BK005', '2021-12-01 18:45:30', 'RM404', 'U004');


CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100),
    item_rate DECIMAL(10, 2)
);

INSERT INTO items VALUES 
('ITM001', 'Tawa Paratha', 18.00),
('ITM002', 'Mix Veg', 89.00),
('ITM003', 'Paneer Butter Masala', 250.00),
('ITM004', 'Dal Makhani', 180.00),
('ITM005', 'Gulab Jamun', 50.00);


CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50),
    bill_date DATETIME,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO booking_commercials VALUES 
('C001', 'BK001', 'BL001', '2021-09-23 12:03:22', 'ITM001', 3),
('C002', 'BK002', 'BL002', '2021-10-15 13:00:00', 'ITM003', 5),
('C003', 'BK003', 'BL003', '2021-11-05 15:30:00', 'ITM002', 2),
('C004', 'BK004', 'BL004', '2021-11-20 11:00:00', 'ITM004', 1),
('C005', 'BK005', 'BL005', '2021-12-01 20:00:00', 'ITM005', 10);
