-- Calculate the Total Revenue
select sum(total_price) as Total_Revenue 
from pizza_sales;

-- Calculate Average Order Value
select sum(total_price) / count(distinct (order_id)) as Average_Order_Value
from pizza_sales;

-- Calculate Pizzas Sold
select sum(quantity) as Pizzas_Sold
from pizza_sales;

-- Calculate Total Orders Placed
select count(distinct (order_id)) as Total_Orders
from pizza_sales;

-- Calculate Average Pizzas per Order
select cast(cast(sum(quantity) as decimal(10,2))/
cast(count(distinct(order_id)) as decimal(10,2)) as decimal (10,2))
as Average_Pizzas_Per_Order
from pizza_sales;

-- Calculate Daily Trends for Total Orders
select datename(dw, order_date) as Order_Day, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by datename(dw, order_date) 
order by Total_Orders desc;

-- Calculate Monthly Trends for Total Orders
select datename(month, order_date) as Order_Month, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by datename(month, order_date)
order by Total_Orders desc;


-- Calculate % of Sales by Pizza Category
select pizza_category, cast(sum(total_price) as decimal(10,2)) as Total_Revenue,
cast((sum(total_price) * 100 / (select sum(total_price) from pizza_sales)) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_category
order by PCT desc;

-- Calculate % of Sales by Pizza Size
select pizza_size, cast(sum(total_price) as decimal(10,2)) as Total_Revenue,
cast((sum(total_price) * 100 / (select sum(total_price) from pizza_sales)) as decimal(10,2)) as PCT
from pizza_sales
group by pizza_size
order by PCT desc;

-- Calculate Total Pizzas sold by category for entire year
select pizza_category, sum(quantity) as Total_Quantity_Sold
from pizza_sales
group by pizza_category
order by Total_Quantity_Sold desc;

-- Calculate Total Pizzas sold by category for a particular month
select pizza_category, sum(quantity) as Total_Quantity_Sold
from pizza_sales
where month(order_date) = 3
group by pizza_category
order by Total_Quantity_Sold desc;

-- Calculate Total Pizzas sold by category for a particular quarter
select pizza_category, sum(quantity) as Total_Quantity_Sold
from pizza_sales
where datepart(quarter, order_date) = 1
group by pizza_category
order by Total_Quantity_Sold desc;

-- Calculate Top 5 Pizzas by Revenue
select top 5 pizza_name, cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue desc;

-- Calculate Bottom 5 Pizzas by Revenue
select top 5 pizza_name, cast(sum(total_price) as decimal (10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by Total_Revenue asc;

-- Calculate Top 5 Pizzas by Total Quantity
select top 5 pizza_name, sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity desc;

-- Calculate Bottom 5 Pizzas by Total Quantity
select top 5 pizza_name, sum(quantity) as Total_Quantity
from pizza_sales
group by pizza_name
order by Total_Quantity asc;

-- Calculate Top 5 Pizzas by Total Orders
select top 5 pizza_name, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders desc;

-- Calculate Bottom 5 Pizzas by Total Quantity
select top 5 pizza_name, count(distinct (order_id)) as Total_Orders
from pizza_sales
group by pizza_name
order by Total_Orders asc;
