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
    FOREIGN KEY (organizer_id) REFERENCES (User.user_id) ON DELETE CASCADE,
    organization_name VARCHAR(100),
    phone VARCHAR(20)
);

CREATE TABLE Event_(
    event_id INT PRIMARY KEY,
    organizer_id INT,
    FOREIGN KEY (organizer_id) REFERENCES (Organizer.organizer_id) ON DELETE CASCADE,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES (Venue.venue_id) ON DELETE RESTRICT,
    title VARCHAR(150),
    event_description TEXT,
    start_time DATETIME,
    end_time DATETIME,
    standard_price DECIMAL(8,2),
    event_status ENUM('Scheduled', 'Ongoing', 'Cancelled', 'Completed')
);

CREATE TABLE Venue(
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100),
    loc_address VARCHAR(200),
    city VARCHAR(50),
    holding_capacity INT
);

CREATE TABLE Section(
    section_id INT PRIMARY KEY,
    venue_id INT,
    FOREIGN KEY (venue_id) REFERENCES (Venue.venue_id) ON DELETE CASCADE,
    section_name VARCHAR(40),
    seating_capacity INT
);

CREATE TABLE Seat(
    seat_id INT PRIMARY KEY,
    section_id INT,
    FOREIGN KEY (section_id) REFERENCES (Section.section_id) ON DELETE CASCADE,
    seat_number VARCHAR(10),
    row_number VARCHAR(10)
);

CREATE TABLE Ticket(
    ticket_id INT PRIMARY KEY,
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES (Event_.event_id) ON DELETE CASCADE,
    seat_id INT,
    FOREIGN KEY (seat_id) REFERENCES (Seat.seat_id) ON DELETE CASCADE,
    ticket_price DECIMAL(8,2),
    ticket_status ENUM('Available', 'Reserved', 'Sold'),
    listed_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Order(
    order_id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES (User.user_id) ON DELETE CASCADE,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_amount DECIMAL(10,2),
    order_status ENUM('Pending', 'Paid', 'Refunded', 'Cancelled')
);

CREATE TABLE Payment(
    payment_id INT PRIMARY KEY,
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES (Order.order_id) ON DELETE CASCADE,
    payment_method ENUM('Credit', 'Debit', 'PayPal', 'Cash'),
    payment_amount DECIMAL(10,2),
    payment_date TIMESTAMP,
    payment_status ENUM('Completed', 'Failed', 'Refunded')
);

CREATE TABLE Performer(
    performer_id INT PRIMARY KEY,
    performer_name VARCHAR(70),
    genre VARCHAR(80)
);

CREATE TABLE Category(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50),
    category_description TEXT
);

CREATE TABLE Notif(
    notification_id INT PRIMARY KEY,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES (User.user_id) ON DELETE CASCADE,
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES (Event_.event_id) ON DELETE CASCADE,
    notification_message TEXT,
    date_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notification_status ENUM('unread', 'read')
);

CREATE TABLE Event_Performer(
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES (Event_.event_id),
    performer_id INT,
    FOREIGN KEY (performer_id) REFERENCES (Performer.performer_id)
);

CREATE TABLE Event_Category(
    event_id INT,
    FOREIGN KEY (event_id) REFERENCES (Event_.event_id),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES (Category.category_id)
);