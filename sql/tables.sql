CREATE TABLE User(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100),
    email VARCHAR(120) UNIQUE,
    pwd VARCHAR(255),
    user_role ENUM('Organizer', 'Customer'),
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Organizer(
    organizer_id INT PRIMARY KEY,
    FOREIGN KEY (organizer_id) REFERENCES (User.user_id),
    organization_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Event(
    event_id INT PRIMARY KEY,
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES (Organizer.organizer_id),
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES (Venue.venue_id),
    title VARCHAR(150),
    event_description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    standard_price DECIMAL(8,2),
    event_status ENUM('scheduled', 'ongoing', 'cancelled', 'completed')
);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);

CREATE TABLE (

);