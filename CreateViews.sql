-- drop view if exists ToppingPopularity;
create view ToppingPopularity as
select 
	topping_TopName as "Topping", 
    (topping_SmallAMT + topping_MedAMT + topping_LgAMT + topping_XLAMT) as `ToppingCount`
from topping
order by `ToppingCount` desc, topping_TopName;

-- drop view if exists ProfitByPizza;
CREATE VIEW ProfitByPizza AS
SELECT 
    p.pizza_Size AS Size,
    p.pizza_CrustType AS Crust,
    (p.pizza_CustPrice - p.pizza_BusPrice) * d.discount_Amount AS Profit,
    DATE_FORMAT(p.pizza_PizzaDate, '%m') AS OrderMonth
FROM pizza p
JOIN pizza_discount pd ON pd.pizza_PizzaID = p.pizza_PizzaID
JOIN discount d ON d.discount_DiscountID = pd.discount_DiscountID;

-- drop view if exists ProfitByOrderType;
CREATE VIEW ProfitByOrderType AS
SELECT 
    o.ordertable_OrderType AS CustomerType,
    DATE_FORMAT(o.ordertable_OrderDateTime, '%m-%d') AS OrderMonth,
    o.ordertable_CustPrice - o.ordertable_BusPrice AS Profit,
    o.ordertable_BusPrice AS TotalOrderCost,
    o.ordertable_CustPrice AS TotalOrderPrice
FROM ordertable o;
