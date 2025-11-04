CREATE TABLE Users(
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    pwd VARCHAR(255) NOT NULL,
    user_role ENUM('Organizer', 'Customer') NOT NULL,
    date_created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Organizer(
    organizer_id INT PRIMARY KEY,
    FOREIGN KEY (organizer_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    organization_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Venue(
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100),
    loc_address VARCHAR(200),
    city VARCHAR(50),
    holding_capacity INT CHECK (holding_capacity > 0)
);

CREATE TABLE Event_(
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    organizer_id INT NOT NULL,
    FOREIGN KEY (organizer_id) REFERENCES Organizer(organizer_id) ON DELETE CASCADE,
    venue_id INT NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id) ON DELETE RESTRICT,
    title VARCHAR(150) NOT NULL,
    event_description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    standard_price DECIMAL(8,2) CHECK (standard_price >= 0),
    event_status ENUM('Scheduled', 'Ongoing', 'Cancelled', 'Completed') DEFAULT 'Scheduled'
);

CREATE TABLE Section(
    section_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_id INT NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id) ON DELETE CASCADE,
    section_name VARCHAR(40),
    seating_capacity INT CHECK (seating_capacity >= 0)
);

CREATE TABLE Seat(
    seat_id INT PRIMARY KEY AUTO_INCREMENT,
    section_id INT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES Section(section_id) ON DELETE CASCADE,
    seat_number VARCHAR(10),
    row_number VARCHAR(10)
);

CREATE TABLE Ticket(
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    event_id INT NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Event_(event_id) ON DELETE CASCADE,
    seat_id INT NOT NULL,
    FOREIGN KEY (seat_id) REFERENCES Seat(seat_id) ON DELETE CASCADE,
    ticket_price DECIMAL(8,2) CHECK (ticket_price >= 0),
    ticket_status ENUM('Available', 'Reserved', 'Sold') DEFAULT 'Available',
    listed_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (event_id, seat_id)
);

CREATE TABLE Order(
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_amount DECIMAL(10,2) CHECK (order_amount >= 0),
    order_status ENUM('Pending', 'Paid', 'Refunded', 'Cancelled') DEFAULT 'Pending'
);

CREATE TABLE Payment(
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL UNIQUE,
    FOREIGN KEY (order_id) REFERENCES Order(order_id) ON DELETE CASCADE,
    payment_method ENUM('Credit', 'Debit', 'PayPal', 'Cash') NOT NULL,
    payment_amount DECIMAL(10,2) CHECK (payment_amount >= 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('Completed', 'Failed', 'Refunded') DEFAULT 'Completed'
);

CREATE TABLE Performer(
    performer_id INT PRIMARY KEY AUTO_INCREMENT,
    performer_name VARCHAR(70) NOT NULL,
    genre VARCHAR(80)
);

CREATE TABLE Category(
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    category_description TEXT
);

CREATE TABLE Notif(
    notification_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    event_id INT NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Event_(event_id) ON DELETE CASCADE,
    notification_message TEXT,
    date_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notification_status ENUM('Unread', 'Read') DEFAULT 'Unread'
);

CREATE TABLE Event_Performer(
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES Event_(event_id) ON DELETE CASCADE,
    performer_id INT,
    FOREIGN KEY (performer_id) REFERENCES Performer(performer_id) ON DELETE CASCADE,
    PRIMARY KEY(event_id, performer_id)
);

CREATE TABLE Event_Category(
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES Event_(event_id) ON DELETE CASCADE,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Category(category_id) ON DELETE CASCADE,
    PRIMARY KEY (event_id, category_id)
);