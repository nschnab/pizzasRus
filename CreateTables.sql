
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
	customer_CustID int primary key not null auto_increment,
    customer_FName varchar(30) not null,
    customer_LName varchar(30) not null,
    customer_PhoneNum varchar(30) not null
);

create table ordertable (
	ordertable_OrderID int primary key not null auto_increment,
    customer_CustID int,
    ordertable_OrderType varchar(30) not null,
    ordertable_OrderDateTime datetime not null,
    ordertable_CustPrice decimal (5,2) not null,
    ordertable_BusPrice decimal (5,2) not null,
    ordertable_isComplete boolean default 0,
    constraint foreign key (customer_CustID) references customer(customer_CustID)
);

create table pickup (
	ordertable_OrderID int primary key not null,
    pickup_IsPickedUp boolean not null default 0,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table delivery (
	ordertable_OrderID int primary key not null,
	delivery_HouseNum int not null,
    delivery_Street varchar(30) not null,
    delivery_City varchar(30) not null,
    delivery_State varchar(30) not null,
    delivery_Zip int not null,
    delivery_IsDelivered boolean not null default 0,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table dinein (
	ordertable_OrderID int primary key not null,
    dinein_TableNum int not null,
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID)
);

create table discount (
	discount_DiscountID int primary key not null auto_increment,
    discount_DiscountName varchar(30) not null,
    discount_Amount decimal (5,2) not null,
    discount_IsPercent boolean not null
);

create table order_discount (
	ordertable_OrderID int not null,
    discount_DiscountID int not null,
    primary key (ordertable_OrderID, discount_DiscountID),
    constraint foreign key (ordertable_OrderID) references ordertable(ordertable_OrderID),
    constraint foreign key (discount_DiscountID) references discount(discount_DiscountID)
);

create table pizza (
	pizza_PizzaID int primary key not null auto_increment,
    pizza_Size varchar(30),
    pizza_CrustType varchar(30),
    pizza_PizzaState varchar(30),
    pizza_PizzaDate datetime,
    pizza_CustPrice decimal (5,2),
    pizza_BusPrice decimal (5,2),
    ordertable_orderID int not null,
    constraint foreign key (ordertable_orderID) references ordertable(ordertable_orderID),
    constraint foreign key (pizza_CrustType) references baseprice(baseprice_CrustType),
    constraint foreign key (pizza_Size) references baseprice(baseprice_Size)
);

create table pizza_discount (
	pizza_PizzaID int not null,
    discount_DiscountID int not null,
    primary key (pizza_PizzaID, discount_DiscountID),
    constraint foreign key (pizza_PizzaID) references pizza(pizza_PizzaID),
    constraint foreign key (discount_DiscountID) references discount(discount_DiscountID)
);

create table baseprice (
	baseprice_Size varchar(30) not null,
    baseprice_CrustType varchar(30) not null,
    baseprice_CustPrice decimal (5,2) not null,
    baseprice_BusPrice decimal(5,2) not null,
    primary key (baseprice_Size, baseprice_CrustType)
);

create table topping (
	topping_TopID int primary key not null auto_increment,
	topping_TopName varchar(30) not null,
    topping_SmallAMT decimal(5,2) not null,
    topping_MedAMT decimal(5,2) not null,
    topping_LgAMT decimal(5,2) not null,
    topping_XLAMT decimal(5,2) not null,
    topping_CustPrice decimal(5,2) not null,
    topping_BusPrice decimal(5,2) not null,
    topping_MinINVT int not null,
    topping_CurINVT int not null
);

create table pizza_topping (
	pizza_PizzaID int not null,
    topping_TopID int not null,
    pizza_topping_IsDouble int not null,
    primary key (pizza_PizzaID, topping_TopID),
    constraint foreign key (pizza_PizzaID) references pizza(pizza_PizzaID),
    constraint foreign key (topping_TopID) references topping(topping_TopID)
);