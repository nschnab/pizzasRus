drop view if exists ToppingPopularity;
create view ToppingPopularity as
select 
	topping_TopName as "Topping", 
	count(*) as `ToppingCount`
from topping t
join pizza_topping pt on pt.topping_TopID = t.topping_TopID
join pizza p on p.pizza_pizzaID = tp.pizza_pizzaID
group by t.topping_TopName
order by `ToppingCount` desc, topping_TopName;

drop view if exists ProfitByPizza;
CREATE VIEW ProfitByPizza AS
SELECT 
    p.pizza_Size AS Size,
    p.pizza_CrustType AS Crust,
    (p.pizza_CustPrice - p.pizza_BusPrice) * d.discount_Amount AS Profit,
    DATE_FORMAT(p.pizza_PizzaDate, '%m/%Y') AS `OrderMonth`
FROM pizza p
JOIN pizza_discount pd ON pd.pizza_PizzaID = p.pizza_PizzaID
JOIN discount d ON d.discount_DiscountID = pd.discount_DiscountID
group by `OrderMonth`;


DROP VIEW IF EXISTS ProfitByOrderType;
CREATE VIEW ProfitByOrderType AS
SELECT * FROM (
    SELECT 
        o.ordertable_OrderType AS CustomerType,
        DATE_FORMAT(o.ordertable_OrderDateTime, '%m/%Y') AS OrderMonth,
        SUM(o.ordertable_CustPrice) AS TotalOrderPrice,
        SUM(o.ordertable_BusPrice) AS TotalOrderCost,
        SUM(o.ordertable_CustPrice - o.ordertable_BusPrice) AS Profit
    FROM ordertable o
    GROUP BY o.ordertable_OrderType, OrderMonth

    UNION ALL

    SELECT 
        '' AS CustomerType,
        'Grand Total' AS OrderMonth,
        SUM(o.ordertable_CustPrice) AS TotalOrderPrice,
        SUM(o.ordertable_BusPrice) AS TotalOrderCost,
        SUM(o.ordertable_CustPrice - o.ordertable_BusPrice) AS Profit
    FROM ordertable o
) AS combined
ORDER BY CustomerType;

