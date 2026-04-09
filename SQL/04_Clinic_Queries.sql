SELECT 
    sales_channel,
    SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021   
GROUP BY sales_channel;


SELECT 
    c.uid,
    c.name,
    SUM(cs.amount) AS total_spent
FROM customer c
JOIN clinic_sales cs ON c.uid = cs.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY c.uid, c.name
ORDER BY total_spent DESC
LIMIT 10;

WITH revenue AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_revenue
    FROM clinic_sales
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
expense AS (
    SELECT 
        MONTH(datetime) AS month,
        SUM(amount) AS total_expense
    FROM expenses
    WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT 
    r.month,
    r.total_revenue,
    COALESCE(e.total_expense, 0) AS total_expense,
    (r.total_revenue - COALESCE(e.total_expense, 0)) AS profit,
    CASE 
        WHEN (r.total_revenue - COALESCE(e.total_expense, 0)) > 0 
        THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
LEFT JOIN expense e ON r.month = e.month;

WITH clinic_profit AS (
    SELECT 
        cl.city,
        cl.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs 
        ON cl.cid = cs.cid AND MONTH(cs.datetime) = 4 AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e 
        ON cl.cid = e.cid AND MONTH(e.datetime) = 4 AND YEAR(e.datetime) = 2021
    GROUP BY cl.city, cl.cid
),
ranked AS (
    SELECT *,
           RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM clinic_profit
)
SELECT city, cid, profit
FROM ranked
WHERE rnk = 1;

WITH clinic_profit AS (
    SELECT 
        cl.state,
        cl.cid,
        SUM(cs.amount) - COALESCE(SUM(e.amount), 0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs 
        ON cl.cid = cs.cid AND MONTH(cs.datetime) = 4 AND YEAR(cs.datetime) = 2021
    LEFT JOIN expenses e 
        ON cl.cid = e.cid AND MONTH(e.datetime) = 4 AND YEAR(e.datetime) = 2021
    GROUP BY cl.state, cl.cid
),
ranked AS (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM clinic_profit
)
SELECT state, cid, profit
FROM ranked
WHERE rnk = 2;
