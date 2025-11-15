drop view if exists ToppingPopularity;
CREATE VIEW ToppingPopularity AS
SELECT 
    t.topping_TopName AS Topping,
    COALESCE(SUM(
        CASE 
            WHEN pt.pizza_topping_IsDouble IS NULL THEN 0
            WHEN pt.pizza_topping_IsDouble = true THEN 2 
            ELSE 1 
        END
    ), 0) AS ToppingCount
FROM topping t
LEFT JOIN pizza_topping pt 
    ON pt.topping_TopID = t.topping_TopID
GROUP BY t.topping_TopName
ORDER BY ToppingCount DESC, Topping;


DROP VIEW IF EXISTS ProfitByPizza;
CREATE VIEW ProfitByPizza AS
SELECT
    p.pizza_Size AS Size,
    p.pizza_CrustType AS Crust,
    SUM(p.pizza_CustPrice - p.pizza_BusPrice) AS Profit,
    DATE_FORMAT(p.pizza_PizzaDate, '%c/%Y') AS OrderMonth
FROM pizza p
GROUP BY p.pizza_Size, p.pizza_CrustType, OrderMonth
ORDER BY Profit asc;


DROP VIEW IF EXISTS ProfitByOrderType;
CREATE VIEW ProfitByOrderType AS
SELECT
    CustomerType,
    OrderMonth,
    TotalOrderPrice,
    TotalOrderCost,
    Profit
FROM (
    SELECT
        o.ordertable_OrderType AS CustomerType,
        DATE_FORMAT(o.ordertable_OrderDateTime, '%c/%Y') AS OrderMonth,
        SUM(o.ordertable_CustPrice) AS TotalOrderPrice,
        SUM(o.ordertable_BusPrice) AS TotalOrderCost,
        SUM(o.ordertable_CustPrice - o.ordertable_BusPrice) AS Profit,
        (YEAR(o.ordertable_OrderDateTime) * 100 + MONTH(o.ordertable_OrderDateTime)) AS YM
    FROM ordertable o
    GROUP BY o.ordertable_OrderType, YEAR(o.ordertable_OrderDateTime), MONTH(o.ordertable_OrderDateTime)
    UNION ALL
    SELECT
        '' AS CustomerType,
        'Grand Total' AS OrderMonth,
        SUM(ordertable_CustPrice) AS TotalOrderPrice,
        SUM(ordertable_BusPrice) AS TotalOrderCost,
        SUM(ordertable_CustPrice - ordertable_BusPrice) AS Profit,
        -1 AS YM
    FROM ordertable
) AS combined
ORDER BY
    CASE CustomerType
        WHEN 'dinein' THEN 1
        WHEN 'delivery' THEN 2
        WHEN 'pickup' THEN 3
        WHEN '' THEN 4
        ELSE 5
    END,
    CASE
        WHEN CustomerType = 'delivery' THEN YM        -- delivery: ascending
        ELSE -YM                                     -- dinein & pickup: descending
    END;