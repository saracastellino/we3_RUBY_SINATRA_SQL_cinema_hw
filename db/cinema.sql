DROP TABLE IF EXISTS tickets;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS screenings;


CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);

CREATE TABLE screenings (
  id SERIAL PRIMARY KEY,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  screening_time VARCHAR(255)
);

CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE,
  screening_id INT REFERENCES screenings(id) ON DELETE CASCADE 
);
