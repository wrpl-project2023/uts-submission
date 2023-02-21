CREATE TABLE users
(
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  street_address TEXT NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(130) NOT NULL,
  country TEXT NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (phone_number),
  UNIQUE (email)
);

CREATE TABLE orders
(
  id INT NOT NULL,
  status INT NOT NULL,
  order_date DATETIME NOT NULL,
  user_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE payments
(
  id INT NOT NULL,
  status INT NOT NULL,
  amount INT NOT NULL,
  ts DATETIME NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE additional_charges
(
  id INT NOT NULL,
  description TEXT NOT NULL,
  amount INT NOT NULL,
  order_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE TABLE stores
(
  id INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  phone_number VARCHAR(20) NOT NULL,
  street_address TEXT NOT NULL,
  country VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  owner_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (owner_id) REFERENCES users(id)
);

CREATE TABLE products
(
  id INT NOT NULL,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  price FLOAT NOT NULL,
  stock INT NOT NULL,
  store_id INT NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (store_id) REFERENCES stores(id)
);

CREATE TABLE order_details
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
