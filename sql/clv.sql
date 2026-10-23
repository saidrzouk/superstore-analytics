select
    customer_id,
    customer_name,
    count(distinct order_id) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by customer_id, customer_name
order by total_profit desc;

select
    customer_id,
    customer_name,
    count(distinct order_id) as total_orders,
    round(sum(sales), 2) as total_sales,
    round(sum(sales) / nullif(count(distinct order_id), 0), 2)
        as average_order_value,
    round(sum(profit) / nullif(count(distinct order_id), 0), 2)
        as average_order_profit
from superstore
group by customer_id, customer_name
order by total_orders desc, total_sales desc;

with customer_dates as (
    select
        customer_id,
        customer_name,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        count(distinct order_id) as total_orders
    from superstore
    group by customer_id, customer_name
),
dataset_end as (
    select max(order_date) as dataset_end_date
    from superstore
)
select
    c.customer_id,
    c.customer_name,
    c.first_order_date,
    c.last_order_date,
    c.total_orders,
    d.dataset_end_date - c.last_order_date as days_since_last_order,
    round(months_between(c.last_order_date, c.first_order_date), 1)
        as relationship_months,
    case
        when d.dataset_end_date - c.last_order_date <= 90 then 'active'
        when d.dataset_end_date - c.last_order_date <= 180 then 'at risk'
        else 'inactive'
    end as customer_status
from customer_dates c
cross join dataset_end d
order by days_since_last_order;

with customer_metrics as (
    select
        customer_id,
        customer_name,
        count(distinct order_id) as total_orders,
        min(order_date) as first_order_date,
        max(order_date) as last_order_date,
        sum(sales) as total_sales,
        sum(profit) as total_profit
    from superstore
    group by customer_id, customer_name
)
select
    customer_id,
    customer_name,
    total_orders,
    round(total_sales, 2) as historical_revenue_clv,
    round(total_profit, 2) as historical_profit_clv,
    round(total_sales / nullif(total_orders, 0), 2)
        as average_order_value,
    round(total_profit / nullif(total_orders, 0), 2)
        as average_order_profit,
    round(months_between(last_order_date, first_order_date), 1)
        as relationship_months
from customer_metrics
order by historical_profit_clv desc;
