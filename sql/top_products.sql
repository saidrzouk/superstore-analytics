select
    product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    rank() over (order by sum(sales) desc) as sales_rank
from superstore
group by product_id, product_name
order by sales_rank, product_name;

select
    product_id,
    product_name,
    round(sum(profit), 2) as total_profit,
    rank() over (order by sum(profit) desc) as profit_rank
from superstore
group by product_id, product_name
order by profit_rank, product_name;

select
    product_id,
    product_name,
    sum(quantity) as total_quantity,
    rank() over (order by sum(quantity) desc) as quantity_rank
from superstore
group by product_id, product_name
order by quantity_rank, product_name;

select
    product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(avg(discount), 4) as average_discount,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent,
    case
        when sum(profit) < 0 then 'loss-making product'
        when avg(discount) >= 0.30
             and sum(profit) / nullif(sum(sales), 0) < 0.10
            then 'review discounting'
        else 'profitable product'
    end as product_status
from superstore
group by product_id, product_name
order by total_profit asc;

select
    product_id,
    product_name,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(avg(discount), 4) as average_discount,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by product_id, product_name
having sum(profit) < 0
order by total_profit;
