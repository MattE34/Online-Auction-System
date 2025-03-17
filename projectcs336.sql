-- Create the onlineauctionsystem database
CREATE DATABASE onlineauctionsystem;

-- Use the onlineauctionsystem database
USE onlineauctionsystem;

-- Create the users table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL
);

-- Create the representatives table
CREATE TABLE representatives (
    RepID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL
);

-- Create the questions table
CREATE TABLE questions (
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    QuestionText VARCHAR(255) NOT NULL,
    AnswerText VARCHAR(255)
);

CREATE TABLE items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    seller_id INT,
    title VARCHAR(255),
    description TEXT,
    type VARCHAR(255),
    reserve_price DECIMAL(10,2),
    closing_date DATETIME,
    FOREIGN KEY (seller_id) REFERENCES users(user_id)
        ON UPDATE RESTRICT
        ON DELETE CASCADE
);

CREATE TABLE bids (
    bid_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT NOT NULL,
    user_id INT NOT NULL,
    bid_amount DECIMAL(10, 2) NOT NULL,
    bid_time DATETIME NOT NULL,
    auto_bid_limit DECIMAL(10, 2),
    increment DECIMAL(10, 2),
    CONSTRAINT fk_item
        FOREIGN KEY (item_id)
        REFERENCES items(item_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT -- Or change this depending on how you want user deletions handled
);

CREATE TABLE alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    item_id INT NOT NULL,
    message VARCHAR(255) NOT NULL,
    is_new BOOLEAN NOT NULL DEFAULT TRUE,  -- Indicates whether the alert has been viewed by the user
    alert_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- Automatically captures the time when the alert was created
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
        ON DELETE CASCADE,  -- Deletes alert when the referenced user is deleted
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
        ON DELETE CASCADE   -- Deletes alert when the referenced item is deleted
);
