CREATE TABLE User(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100),
    email VARCHAR(120) UNIQUE,
    pwd VARCHAR(255),
    user_role ENUM('Organizer', 'Customer'),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

insert INTO User VALUES(1, 'jim', 'jim@jim.com', 'jim123', 'Customer', '2025-11-03 13:55:30');
Select * from user;