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

CREATE TABLE Event_(
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

CREATE TABLE Venue(
    venue_id INT PRIMARY KEY,
    name VARCHAR(100),
    loc_address VARCHAR(200),
    city VARCHAR(50),
    holding_capacity INT
);

CREATE TABLE Section(
    section_id INT PRIMARY KEY,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES (Venue.venue_id),
    name VARCHAR(40),
    seating_capacity INT
);

CREATE TABLE Seat(
    seat_id INT PRIMARY KEY,
    section_id INT
    FOREIGN KEY (section_id) REFERENCES (Section.section_id),
    seat_number VARCHAR(10),
    row_number VARCHAR(10)
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