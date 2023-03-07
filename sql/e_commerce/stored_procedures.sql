DROP PROCEDURE IF EXISTS getActiveUsers;
DROP PROCEDURE IF EXISTS getAllUsers;
DROP PROCEDURE IF EXISTS searchUserByName;

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
DELIMITER ;

CALL getActiveUsers();
