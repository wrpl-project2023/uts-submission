-- vim: foldmethod=marker :

-- USERS {{{

DELIMITER $$
DROP PROCEDURE IF EXISTS getActiveUsers$$
CREATE PROCEDURE getActiveUsers()
CONTAINS SQL
BEGIN
        SELECT *
        FROM users
        JOIN orders
        ON orders.user_id = users.id
        WHERE orders.order_date >= NOW() - INTERVAL 3 MONTH
        GROUP BY orders.user_id
        HAVING COUNT(orders.user_id) > 2;
END$$

DROP PROCEDURE IF EXISTS getUsers$$
CREATE PROCEDURE getUsers()
CONTAINS SQL
BEGIN
        SELECT * FROM users;
END$$

DROP PROCEDURE IF EXISTS getUserByID$$
CREATE PROCEDURE getUserByID(IN id INT)
CONTAINS SQL
BEGIN
        SELECT * FROM users WHERE id=id;
END$$

DROP PROCEDURE IF EXISTS getUserByName$$
CREATE PROCEDURE getUserByName(IN keyword VARCHAR(50))
CONTAINS SQL
BEGIN
        SELECT * FROM users
        WHERE
                name LIKE CONCAT('%', keyword, '%');
END$$

DROP PROCEDURE IF EXISTS getUserOrders$$
CREATE PROCEDURE getUserOrders(IN userid INT)
CONTAINS SQL
BEGIN
        SELECT users.id, orders.id, users.name, orders.status
        FROM users
        JOIN orders ON orders.user_id = users.id
        WHERE
                users.id = userid;
END$$

DROP PROCEDURE IF EXISTS getUserPayments$$
CREATE PROCEDURE getUserPayments(IN userid INT)
CONTAINS SQL
BEGIN
        SELECT *
        FROM users u
        JOIN payments p ON p.user_id = u.i
        WHERE
                users.id = userid;
END$$

DROP PROCEDURE IF EXISTS getOrderDetails$$
CREATE PROCEDURE getOrderDetails(IN oid INT)
CONTAINS SQL
BEGIN
        SELECT
                p.id, p.name,
                od.quantity,
                od.price AS total_price,
                p.price as unit_price
        FROM orders o
        JOIN order_details od
                ON o.id = od.order_id
        JOIN products p
                ON p.id = od.product_id
        WHERE
                o.id = oid;
END$$

DROP PROCEDURE IF EXISTS authenticateUser$$
CREATE PROCEDURE authenticateUser(IN username VARCHAR(50),
        IN password VARCHAR(50))
CONTAINS SQL
BEGIN
        SELECT *
        FROM users
        WHERE
                username = username
                AND
                password = password
        LIMIT 1;
END$$

DROP PROCEDURE IF EXISTS changeUserPassword$$
CREATE PROCEDURE changeUserPassword(IN username VARCHAR(50),
        IN newPassword VARCHAR(50))
CONTAINS SQL
BEGIN
        UPDATE users
        SET password = newPassword
        WHERE username = username;
END$$

DROP PROCEDURE IF EXISTS changeUserPassword$$
CREATE PROCEDURE changeUserPassword(IN username VARCHAR(50),
        IN newPassword VARCHAR(50))
CONTAINS SQL
BEGIN
        UPDATE users
        SET password = newPassword
        WHERE username = username;
END$$

-- }}}

-- ORDERS {{{

DROP PROCEDURE IF EXISTS getOrders$$
CREATE PROCEDURE getOrders()
CONTAINS SQL
BEGIN
        SELECT * FROM orders;
END$$

DROP PROCEDURE IF EXISTS getOrderByID$$
CREATE PROCEDURE getOrderByID(IN id INT)
CONTAINS SQL
BEGIN
        SELECT * FROM orders
        WHERE id = id;
END$$

DROP PROCEDURE IF EXISTS getOrdersInDate$$
CREATE PROCEDURE getOrdersInDate(
        IN sd DATETIME,
        IN ed DATETIME
)
CONTAINS SQL
BEGIN
        SELECT * FROM orders
        WHERE order_date BETWEEN sd and ed;
END$$

DROP PROCEDURE IF EXISTS getOrdersInDate$$
CREATE PROCEDURE getOrdersInDate(
        IN sd DATETIME,
        IN ed DATETIME
)
CONTAINS SQL
BEGIN
        SELECT * FROM orders
        WHERE order_date BETWEEN sd and ed;
END$$

DROP PROCEDURE IF EXISTS getUnpaidOrders$$
CREATE PROCEDURE getUnpaidOrders()
CONTAINS SQL
BEGIN
        SELECT * FROM orders
        WHERE status = 0;
END$$

DROP PROCEDURE IF EXISTS getOrderByStatus$$
CREATE PROCEDURE getOrderByStatus(IN status INT)
CONTAINS SQL
BEGIN
        SELECT * FROM orders
        WHERE status = status;
END$$

DROP PROCEDURE IF EXISTS cancelOrder$$
CREATE PROCEDURE cancelOrder(IN id INT)
CONTAINS SQL
BEGIN
        UPDATE orders
        SET status = 4
        WHERE id = id;
END$$

-- }}}

-- PAYMENTS {{{

DROP PROCEDURE IF EXISTS getPayments$$
CREATE PROCEDURE getPayments()
CONTAINS SQL
BEGIN
        SELECT *
        FROM payments;
END$$

DROP PROCEDURE IF EXISTS getPaymentByID$$
CREATE PROCEDURE getPaymentByID(IN id INT)
CONTAINS SQL
BEGIN
        SELECT *
        FROM payments
        WHERE id = id;
END$$

DROP PROCEDURE IF EXISTS isPaymentPaid$$
CREATE PROCEDURE isPaymentPaid(IN id INT)
CONTAINS SQL
BEGIN
        SELECT *
        FROM payments
        WHERE status = 3;
END$$

DROP PROCEDURE IF EXISTS updatePaymentAsPaid$$
CREATE PROCEDURE updatePaymentAsPaid(IN id INT)
CONTAINS SQL
BEGIN
        UPDATE payments
        SET status = 3
        WHERE id = id;
END$$

DROP PROCEDURE IF EXISTS cancelPayment$$
CREATE PROCEDURE cancelPayment(IN id INT)
CONTAINS SQL
BEGIN
        UPDATE payments
        SET status = 4
        WHERE id = id;
END$$

DROP PROCEDURE IF EXISTS addAdditionalCharge$$
CREATE PROCEDURE addAdditionalCharge(
        IN order_id INT,
        IN description TEXT,
        IN amount INT
)
CONTAINS SQL
BEGIN
        INSERT INTO
        additional_charges
        (description, amount, order_id)
        VALUES
        (description, amount, order_id);
END$$

-- }}}

DELIMITER ;
