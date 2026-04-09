SELECT u.user_id, b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE (b.user_id, b.booking_date) IN (
    SELECT user_id, MAX(booking_date)
    FROM bookings
    GROUP BY user_id
);


SELECT b.booking_id, 
       SUM(i.item_rate * bc.item_quantity) AS total_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(b.booking_date) = 11 AND YEAR(b.booking_date) = 2021
GROUP BY b.booking_id;


SELECT bc.bill_id,
       SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE MONTH(bc.bill_date) = 10 AND YEAR(bc.bill_date) = 2021
GROUP BY bc.bill_id
HAVING bill_amount > 1000;


WITH item_totals AS (
    SELECT 
        MONTH(bc.bill_date) AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.item_id
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS max_rank,
           RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS min_rank
    FROM item_totals
)
SELECT month, item_id, total_qty,
       CASE 
           WHEN max_rank = 1 THEN 'Most Ordered'
           WHEN min_rank = 1 THEN 'Least Ordered'
       END AS category
FROM ranked
WHERE max_rank = 1 OR min_rank = 1;


WITH bill_values AS (
    SELECT 
        u.user_id,
        MONTH(bc.bill_date) AS month,
        SUM(i.item_rate * bc.item_quantity) AS total_bill
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN users u ON b.user_id = u.user_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY u.user_id, MONTH(bc.bill_date)
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) AS rnk
    FROM bill_values
)
SELECT user_id, month, total_bill
FROM ranked
WHERE rnk = 2;
