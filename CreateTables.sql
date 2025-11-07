
-- Create Schema
DROP SCHEMA IF EXISTS PizzaDB;
CREATE SCHEMA PizzaDB;
USE PizzaDB;

-- Create user 
DROP USER IF EXISTS 'dbtester';
CREATE USER 'dbtester' IDENTIFIED BY 'CPSC4620'; 
GRANT ALL ON PizzaDB.* TO 'dbtester';


-- Create Tables
create table customer (
	customer_CustID int primary key not null,
    customer_FName varchar(30) not null,
    customer_LName varchar(30) not null,
    customer_PhoneNum varchar(30)
);

create table ordertable (
	ordertable_OrderID int primary key not null,
    customer_CustID int not null,
    ordertable_OrderType varchar(30),
    ordertable_OrderDateTime datetime,
    ordertable_CustPrice decimal (5,2),
    ordertable_BusPrice decimal (5,2),
    ordertable_isComplete boolean,
    constraint foreign key (customer_CustID) references customer(customer_CustID)
);

create table pickup (
	ordertable_OrderID int primary key not null,
    pickup_IsPickedUp boolean,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table delivery (
	ordertable_OrderID int primary key not null,
	delivery_HouseNum int,
    delivery_Street varchar(30),
    delivery_City varchar(30),
    delivery_State varchar(30),
    delivery_Zip int,
    delivery_IsDelivered boolean,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table dinein (
	ordertable_OrderID int primary key not null,
    dinein_TableNum int,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table discount (
	discount_DiscountID int primary key not null,
    discount_DiscountName varchar(30),
    discount_Amount decimal (5,2),
    discount_IsPercent boolean
);

create table order_discount (
	ordertable_OrderID int not null,
    discount_DiscountID int not null,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID),
    constraint foreign key (discount_DiscountID) references discount(discount_DiscountID)
);

create table pizza (
	pizza_PizzaID int primary key not null,
    pizza_Size varchar(30),
    pizza_CrustType varchar(30),
    pizza_PizzaState varchar(30),
    pizza_PizzaDate datetime,
    pizza_CustPrice decimal (5,2),
    pizza_BusPrice decimal (5,2),
    ordertable_orderID int not null,
    constraint foreign key (ordertable_orderID) references ordertable(ordertable_orderID)
);

create table pizza_discount (
	pizza_PizzaID int not null,
    discount_DiscountID int not null,
    constraint foreign key (pizza_PizzaID) references pizza(pizza_PizzaID),
    constraint foreign key (discount_DiscountID) references discount(discount_DiscountID)
);

create table baseprice (
	baseprice_Size varchar(30) not null,
    baseprice_CrustType varchar(30) not null,
    baseprice_CustPrice decimal (5,2),
    baseprice_BusPrice decimal(5,2),
    primary key (baseprice_Size, baseprice_CrustType)
);

create table topping (
	topping_TopID int primary key not null,
	topping_TopName varchar(30),
    topping_SmallAMT decimal(5,2),
    topping_MedAMT decimal(5,2),
    topping_LgAMT decimal(5,2),
    topping_XLAMT decimal(5,2),
    topping_CustPrice decimal(5,2),
    topping_BusPrice decimal(5,2),
    topping_MinINVT int,
    topping_CutINVT int
);

create table pizza_topping (
	pizza_PizzaID int not null,
    topping_TopID int not null,
    pizza_topping_IsDouble int,
    constraint foreign key (pizza_PizzaID) references pizza(pizza_PizzaID),
    constraint foreign key (topping_TopID) references topping(topping_TopID)
);