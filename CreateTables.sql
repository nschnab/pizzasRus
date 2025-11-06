DROP SCHEMA IF EXISTS PizzaDB;
CREATE SCHEMA PizzaDB;
USE PizzaDB;

DROP USER IF EXISTS 'dbtester';
CREATE USER 'dbtester' IDENTIFIED BY 'CPSC4620'; 
GRANT ALL ON PizzaDB.* TO 'dbtester';

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