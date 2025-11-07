drop view if exists ToppingPopularity;
create view ToppingPopularity as
select topping_TopName as "Topping", (topping_SmallAMT + topping_MedAMT + topping_LgAMT + topping_XLAMT) as `ToppingCount`
from topping
order by `ToppingCount` desc, topping_TopName;

drop view if exists ProfitByPizza;



drop view if exists ProfitByOrderType;