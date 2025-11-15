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
    CASE 
        WHEN MonthStart = '9999-12-01' THEN 'Grand Total'
        ELSE DATE_FORMAT(MonthStart, '%c/%Y')
    END AS OrderMonth,
    TotalOrderPrice,
    TotalOrderCost,
    Profit
FROM (
    SELECT
        o.ordertable_OrderType AS CustomerType,
        DATE_FORMAT(o.ordertable_OrderDateTime, '%Y-%m-01') + INTERVAL 0 DAY AS MonthStart,
        SUM(o.ordertable_CustPrice) AS TotalOrderPrice,
        SUM(o.ordertable_BusPrice) AS TotalOrderCost,
        SUM(o.ordertable_CustPrice - o.ordertable_BusPrice) AS Profit
    FROM ordertable o
    GROUP BY o.ordertable_OrderType, MonthStart

    UNION ALL

    SELECT
        '' AS CustomerType,
        '9999-12-01' AS MonthStart,
        SUM(o.ordertable_CustPrice) AS TotalOrderPrice,
        SUM(o.ordertable_BusPrice) AS TotalOrderCost,
        SUM(o.ordertable_CustPrice - o.ordertable_BusPrice) AS Profit
    FROM ordertable o
) AS combined
ORDER BY CustomerType desc, MonthStart asc;


