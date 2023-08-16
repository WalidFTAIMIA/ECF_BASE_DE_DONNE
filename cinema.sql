-- Création de la base de données
CREATE DATABASE cinema_ecf;

-- Utilisation de la base de données
USE cinema_ecf;

-- Création de la table Complex
CREATE TABLE Complex (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- Création de la table Cinema
CREATE TABLE Cinema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complex_id INT,
    FOREIGN KEY (complex_id) REFERENCES Complex(id)
);

-- Création de la table Role
CREATE TABLE Role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
UPDATE Role SET name = 'admin' WHERE id = 1;
UPDATE Role SET name = 'user' WHERE id = 2;

-- Création de la table Users
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usersname VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    complex_id INT,
    FOREIGN KEY (role_id) REFERENCES Role(id),
    FOREIGN KEY (complex_id) REFERENCES Complex(id)
);

-- Création de la table Movie
CREATE TABLE Movie (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    genre VARCHAR(255) NOT NULL
);

-- Création de la table Screening
CREATE TABLE Screening (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cinema_id INT,
    movie_id INT,
    start_time DATETIME NOT NULL,
    available_seats INT NOT NULL,
    added_by INT,
    FOREIGN KEY (cinema_id) REFERENCES Cinema(id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (added_by) REFERENCES Users(id)
);

-- Création de la table Reservation
CREATE TABLE Reservation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    screening_id INT NOT NULL,
    seat_number INT NOT NULL,
    customer_name VARCHAR(255) NOT NULL,
    ticket_price DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (screening_id) REFERENCES Screening(id)
);

-- Insertion des données factices dans la table Role
INSERT INTO Role (name) VALUES ('admin'), ('user');

-- Insertion des données fictives dans la table Complex
INSERT INTO Complex (name, address)
VALUES
    ('Cinéplex Central', '123 Main Street'),
    ('Mega Movies', '456 Broadway'),
    ('Cinema Paradise', '789 Park Avenue');

-- Insertion des données fictives dans la table Cinema
INSERT INTO Cinema (complex_id)
VALUES
    (1),
    (1),
    (2),
    (3);

-- Insertion des données fictives dans la table Movie
INSERT INTO Movie (title, duration, genre)
VALUES
    ('Action Frenzy', 120, 'Action'),
    ('Romantic Escape', 110, 'Romance'),
    ('Sci-Fi Adventure', 135, 'Science Fiction');

-- Insertion des données fictives dans la table Users
INSERT INTO Users (usersname, password, role_id, complex_id)
VALUES
    ('admin', 'password', (SELECT id FROM Role WHERE name = 'admin'), NULL),
    ('user1', '123456', (SELECT id FROM Role WHERE name = 'user'), 1),
    ('user2', 'abcdef', (SELECT id FROM Role WHERE name = 'user'), 2),
    ('user3', 'qwerty', (SELECT id FROM Role WHERE name = 'user'), 3);

-- Insertion des données fictives dans la table Screening
INSERT INTO Screening (cinema_id, movie_id, start_time, available_seats, added_by)
VALUES
    (1, 1, '2023-08-01 18:00:00', 100, 1), 
    (1, 2, '2023-08-01 20:00:00', 150, 1), 
    (2, 1, '2023-08-01 19:30:00', 120, 1),
    (3, 2, '2023-08-01 21:00:00', 80, 1);  

-- Insertion des données fictives dans la table Reservation
INSERT INTO Reservation (screening_id, seat_number, customer_name, ticket_price)
VALUES
    (1, 15, 'John Doe', 9.20),
    (1, 16, 'Jane Smith', 7.60),
    (2, 5, 'Alice Johnson', 5.90),
    (3, 8, 'Bob Williams', 9.20);
