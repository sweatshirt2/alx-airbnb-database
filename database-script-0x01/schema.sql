USE air_bnb;
CREATE TABLE IF NOT EXISTS users (
  user_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(255) NOT NULL,
  role ENUM('guest', 'host', 'admin') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE IF NOT EXISTS properties (
  property_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  host_id VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  location VARCHAR(255) NOT NULL,
  pricepernight DECIMAL(10, 2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (host_id) REFERENCES users(user_id)
);
CREATE TABLE IF NOT EXISTS bookings (
  booking_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  property_id VARCHAR(255) NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id)
) PARTITION BY RANGE (YEAR(start_date)) (
  PARTITION p2022
  VALUES LESS THAN (2023),
    PARTITION p2023
  VALUES LESS THAN (2024),
    PARTITION p2024
  VALUES LESS THAN (2025),
    PARTITION pmax
  VALUES LESS THAN MAXVALUE
);
CREATE TABLE IF NOT EXISTS payments (
  payment_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  booking_id VARCHAR(255) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);
CREATE TABLE IF NOT EXISTS reviews (
  review_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  property_id VARCHAR(255) NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  rating INTEGER,
  comment TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (property_id) REFERENCES properties(property_id),
  FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT rating CHECK (
    rating BETWEEN 1 AND 5
  )
);
CREATE TABLE IF NOT EXISTS messages (
  message_id VARCHAR(255) PRIMARY KEY DEFAULT (UUID()),
  sender_id VARCHAR(255) NOT NULL,
  recipient_id VARCHAR(255) NOT NULL,
  message_body TEXT NOT NULL,
  sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sender_id) REFERENCES users(user_id),
  FOREIGN KEY (recipient_id) REFERENCES users(user_id)
);