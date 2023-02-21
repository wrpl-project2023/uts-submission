CREATE TABLE IF NOT EXISTS users
(
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  street_address TEXT NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(130) NOT NULL,  -- pbkdf2_sha512
  country TEXT NOT NULL,
  is_admin BOOLEAN NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (phone_number),
  UNIQUE (email)
);


CREATE TABLE IF NOT EXISTS products
(
  id INT NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  price FLOAT NOT NULL,
  stock INT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS orders
(
  id INT NOT NULL,
  status INT NOT NULL,
  order_date DATETIME NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS order_details
(
  id INT NOT NULL,
  quantity INT NOT NULL,
  price INT NOT NULL,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id),
  FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS payments
(
  id INT NOT NULL,
  status INT NOT NULL,
  amount INT NOT NULL,
  ts DATETIME NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS additional_charges
(
  id INT NOT NULL,
  description TEXT NOT NULL,
  amount INT NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);
