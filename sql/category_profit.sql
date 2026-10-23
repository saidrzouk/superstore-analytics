select
    category,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    sum(quantity) as total_quantity,
    round(avg(discount), 4) as average_discount,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by category
order by total_profit desc;

select
    category,
    subcategory,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    sum(quantity) as total_quantity,
    round(avg(discount), 4) as average_discount,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent,
    case
        when sum(profit) < 0 then 'loss-making'
        when sum(profit) / nullif(sum(sales), 0) < 0.10 then 'low margin'
        else 'profitable'
    end as profitability_status
from superstore
group by category, subcategory
order by total_profit desc;

select
    region,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    sum(quantity) as total_quantity,
    round(avg(discount), 4) as average_discount,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by region
order by total_profit desc;

select
    region,
    category,
    subcategory,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by region, category, subcategory
order by region, total_profit desc;

select
    category,
    round(avg(discount), 4) as average_discount,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent,
    case
        when avg(discount) >= 0.30
             and sum(profit) / nullif(sum(sales), 0) < 0.10
            then 'review discounting'
        else 'no immediate warning'
    end as discount_status
from superstore
group by category
order by average_discount desc;
