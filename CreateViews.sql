drop view if exists ToppingPopularity;
create view ToppingPopularity as
select topping_TopName as "Topping", (topping_SmallAMT + topping_MedAMT + topping_LgAMT + topping_XLAMT) as `ToppingCount`
from topping
order by `ToppingCount` desc, topping_TopName;

drop view if exists ProfitByPizza;
create view ProfitByPizza as
select p.pizza_Size as Size, p.pizza_CrustType as Crust, (p.pizza_CustPrice - p.pizza_BusPrice) * d.discount_Amount as Profit, month(p.pizza_PizzaDate) as OrderMonth
from pizza p
join pizza_discount pd on pd.pizza_PizzaID = p.pizza_PizzaID
join discount d on d.discount_DiscountID = pd.discount_DiscountID;

drop view if exists ProfitByOrderType;