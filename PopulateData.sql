USE PizzaDB;

-- Insert values into the topping table
INSERT INTO topping (topping_TopName, topping_SmallAMT, topping_MedAMT, topping_LgAMT, topping_XLAMT, topping_CustPrice, topping_BusPrice, topping_MinINVT, topping_CurINVT) VALUES
('Bacon', 1, 1.5, 2, 3, 1.5, 0.25, 0, 89),
('Banana Peppers', 0.6, 1, 1.3, 1.75, 0.5, 0.05, 0, 36),
('Black Olives', 0.75, 1, 1.5, 2, 0.6, 0.1, 25, 39),
('Chicken', 1.5, 2, 2.25, 3, 1.75, 0.25, 25, 56),
('Feta Cheese', 1.75, 3, 4, 5.5, 1.5, 0.18, 0, 75),
('Four Cheese Blend', 2, 3.5, 5, 7, 1, 0.15, 25, 150),
('Goat Cheese', 1.6, 2.75, 4, 5.5, 1.5, 0.2, 0, 54),
('Green Pepper', 1, 1.5, 2, 2.5, 0.5, 0.02, 25, 79),
('Ham', 2, 2.5, 3.25, 4, 1.5, 0.15, 25, 78),
('Jalapenos', 0.5, 0.75, 1.25, 1.75, 0.5, 0.05, 0, 64),
('Mushrooms', 1.5, 2, 2.5, 3, 0.75, 0.1, 50, 52),
('Onion', 1, 1.5, 2, 2.75, 0.5, 0.02, 25, 85),
('Pepperoni', 2, 2.75, 3.5, 4.5, 1.25, 0.2, 50, 100),
('Pineapple', 1, 1.25, 1.75, 2, 1, 0.25, 0, 15),
('Regular Cheese', 2, 3.5, 5, 7, 0.5, 0.12, 50, 250),
('Roma Tomato', 2, 3, 3.5, 4.5, 0.75, 0.03, 10, 86),
('Sausage', 2.5, 3, 3.5, 4.25, 1.25, 0.15, 50, 100);

-- Insert values into discounts table
INSERT INTO discount (discount_DiscountName, discount_Amount, discount_IsPercent) VALUES
('Employee', 15, 1),
('Gameday Special', 20, 1),
('Happy Hour', 10, 1),
('Lunch Special Large', 2, 0),
('Lunch Special Medium', 1, 0),
('Specialty Pizza', 1.5, 0);

-- Insert values into Base Prices
INSERT INTO baseprice (baseprice_Size, baseprice_CrustType, baseprice_CustPrice, baseprice_BusPrice) VALUES
('Small', 'Thin', 3, 0.5),
('Small', 'Original', 3, 0.75),
('Small', 'Pan', 3.5, 1),
('Small', 'Gluten-Free', 4, 2),
('Medium', 'Thin', 5, 1),
('Medium', 'Original', 5, 1.5),
('Medium', 'Pan', 6, 2.25),
('Medium', 'Gluten-Free', 6.25, 3),
('Large', 'Thin', 8, 1.25),
('Large', 'Original', 8, 2),
('Large', 'Pan', 9, 3),
('Large', 'Gluten-Free', 9.5, 4),
('XLarge', 'Thin', 10, 2),
('XLarge', 'Original', 10, 3),
('XLarge', 'Pan', 11.5, 4.5),
('XLarge', 'Gluten-Free', 12.5, 6);

-- insert into ordertable
INSERT INTO ordertable
(ordertable_OrderType, ordertable_OrderDateTime, ordertable_CustPrice, ordertable_BusPrice, ordertable_isComplete)
VALUES
('dinein',    '2025-01-05 12:03:00', 19.75, 3.68, 1),
('dinein',    '2025-02-03 12:05:00', 19.78, 4.63, 1),
('pickup',    '2025-01-03 21:30:00', 89.28, 19.8, 1),
('delivery',  '2025-02-20 19:11:00', 68.95, 17.39, 1),
('pickup',    '2025-01-02 17:30:00', 28.7, 7.84, 1),
('delivery',  '2025-01-02 18:17:00', 25.81, 3.64, 1),
('delivery',  '2025-02-13 20:32:00', 31.66, 6, 1);

-- Create orders

-- insert into pizza
INSERT INTO pizza VALUES
    (1, 'Large', 'Thin', 'Completed', '2025-01-05 12:03:00', 19.75, 3.68, 1),
    (2, 'Medium', 'Pan', 'Completed', '2025-02-03 12:05:00', 12.85, 3.23, 2),
    (3, 'Small', 'Original', 'Completed', '2025-02-03 12:05:00', 6.93, 1.40, 2),
    (4, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (5, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (6, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (7, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (8, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (9, 'Large', 'Original', 'Completed', '2025-01-03 21:30:00', 14.88, 3.30, 3),
    (10, 'XLarge', 'Original', 'Completed', '2025-02-20 19:11:00', 27.94, 5.59, 4),
    (11, 'XLarge', 'Original', 'Completed', '2025-02-20 19:11:00', 31.50, 6.25, 4),
    (12, 'XLarge', 'Original', 'Completed', '2025-02-20 19:11:00', 26.75, 5.55, 4),
    (13, 'XLarge', 'Gluten-Free', 'Completed', '2025-01-02 17:30:00', 28.70, 7.84, 5),
    (14, 'Large', 'Thin', 'Completed', '2025-01-02 18:17:00', 25.81, 3.64, 6),
    (15, 'Large', 'Thin', 'Completed', '2025-02-13 20:32:00', 18.00, 2.75, 7),
    (16, 'Large', 'Thin', 'Completed', '2025-02-13 20:32:00', 19.25, 3.25, 7);

-- insert into customer
INSERT INTO customer (customer_FName, customer_LName, customer_PhoneNum) VALUES
     ('Andrew', 'Wilkes-Krier', '8642545861'),
     ('Matt', 'Engers', '8644749953'),
     ('Frank', 'Turner', '8642328944'),
     ('Milo', 'Auckerman', '8648785679');

-- insert values into delivery
insert into delivery (ordertable_OrderID, delivery_HouseNum, delivery_Street, delivery_City, delivery_State, delivery_ZIP, delivery_IsDelivered) values
     (4, 115, 'Party Blvd', 'Anderson', 'SC', 29621, 1),
     (6, 6745, 'Wessex St', 'Anderson', 'SC', 29621, 1),
     (7, 8879, 'Suburban Lane', 'Anderson','SC', 29621, 1);
     
-- insert into pickup
insert into pickup (ordertable_OrderID, pickup_IsPickedUp) values (3, 1); 
insert into pickup (ordertable_OrderID, pickup_IsPickedUp) values (5, 1);

-- insert into dinein
insert into dinein (ordertable_OrderID, dinein_TableNum) values (1, 21);
insert into dinein (ordertable_OrderID, dinein_TableNum) values (2, 4);