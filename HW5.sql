USE mydb;

SELECT 
    od.*,
    (SELECT o.customer_id 
     FROM orders o 
     WHERE o.id = od.order_id) AS customer_id
FROM order_details od;


SELECT *
FROM order_details
WHERE order_id IN (
    SELECT id 
    FROM orders 
    WHERE shipper_id = 3);
SELECT 
    filtered_od.order_id,
    AVG(filtered_od.quantity) AS avg_quantity
FROM (
    SELECT order_id, quantity 
    FROM order_details 
    WHERE quantity > 10)
AS filtered_od
GROUP BY filtered_od.order_id;

DROP FUNCTION IF EXISTS divide_floats;
DELIMITER //
CREATE FUNCTION divide_floats(val1 FLOAT, val2 FLOAT)
RETURNS FLOAT
DETERMINISTIC
BEGIN
    IF val2 = 0 THEN
        RETURN NULL;
    END IF;
    
    RETURN val1 / val2;
END //
DELIMITER ;
SELECT 
    id,
    quantity,
    divide_floats(quantity, 2.5) AS divided_quantity
FROM order_details;

