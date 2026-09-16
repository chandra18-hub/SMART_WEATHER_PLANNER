-- Smart Weather Planner Database
-- MySQL 8.0+

CREATE DATABASE IF NOT EXISTS smart_weather_planner;
USE smart_weather_planner;

CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE saved_cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    country_code VARCHAR(10),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    is_favorite BOOLEAN DEFAULT FALSE,
    saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE weather_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    city_name VARCHAR(100) NOT NULL,
    temperature DECIMAL(5,2),
    humidity DECIMAL(5,2),
    wind_speed DECIMAL(6,2),
    weather_condition VARCHAR(100),
    searched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE tourist_places (
    place_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    place_name VARCHAR(150) NOT NULL,
    description TEXT,
    category VARCHAR(80),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7)
);

CREATE TABLE travel_plans (
    plan_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    plan_name VARCHAR(150) NOT NULL,
    city_name VARCHAR(100) NOT NULL,
    travel_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE plan_places (
    plan_id INT NOT NULL,
    place_id INT NOT NULL,
    visit_order INT,
    PRIMARY KEY (plan_id, place_id),
    FOREIGN KEY (plan_id) REFERENCES travel_plans(plan_id) ON DELETE CASCADE,
    FOREIGN KEY (place_id) REFERENCES tourist_places(place_id) ON DELETE CASCADE
);

-- Sample tourist places
INSERT INTO tourist_places
(city_name, place_name, description, category)
VALUES
('Hyderabad', 'Charminar', 'Historic monument and popular tourist attraction', 'Historical'),
('Hyderabad', 'Golconda Fort', 'Historic fort with scenic views', 'Historical'),
('Hyderabad', 'Hussain Sagar Lake', 'Lake with boating and city views', 'Nature');

-- Useful queries
-- Show favorite cities of a user
-- SELECT * FROM saved_cities WHERE user_id = 1 AND is_favorite = TRUE;

-- Show recent weather searches
-- SELECT * FROM weather_history ORDER BY searched_at DESC LIMIT 10;

-- Find tourist places in a city
-- SELECT * FROM tourist_places WHERE city_name = 'Hyderabad';

-- Display a user's travel plans
-- SELECT * FROM travel_plans WHERE user_id = 1;

-- Display places included in a travel plan
-- SELECT tp.plan_name, p.place_name, pp.visit_order
-- FROM travel_plans tp
-- JOIN plan_places pp ON tp.plan_id = pp.plan_id
-- JOIN tourist_places p ON pp.place_id = p.place_id
-- WHERE tp.plan_id = 1
-- ORDER BY pp.visit_order;
