DROP PROCEDURE IF EXISTS getActiveUsers;
DROP PROCEDURE IF EXISTS getAllUsers;
DROP PROCEDURE IF EXISTS searchUserByName;
DROP PROCEDURE IF EXISTS getUserOrders;
DROP PROCEDURE IF EXISTS getOrderDetails;

DELIMITER $$
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

CREATE PROCEDURE getAllUsers()
CONTAINS SQL
BEGIN
        SELECT * FROM users;
END$$

CREATE PROCEDURE searchUserByName(IN keyword VARCHAR(50))
CONTAINS SQL
BEGIN
        SELECT * FROM users
        WHERE
                name LIKE CONCAT('%', keyword, '%');
END$$

CREATE PROCEDURE getUserOrders(IN userid INT)
CONTAINS SQL
BEGIN
        SELECT users.id, orders.id, users.name, orders.status
        FROM users
        JOIN orders ON orders.user_id = users.id
        WHERE
                users.id = userid;
END$$

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
DELIMITER ;
