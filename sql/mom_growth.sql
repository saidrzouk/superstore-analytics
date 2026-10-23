select
    trunc(order_date, 'mm') as month_start,
    round(sum(sales), 2) as total_sales
from superstore
group by trunc(order_date, 'mm')
order by month_start;

select
    trunc(order_date, 'mm') as month_start,
    round(sum(profit), 2) as total_profit
from superstore
group by trunc(order_date, 'mm')
order by month_start;

with monthly_sales as (
    select
        trunc(order_date, 'mm') as month_start,
        sum(sales) as total_sales
    from superstore
    group by trunc(order_date, 'mm')
),
sales_with_previous as (
    select
        month_start,
        total_sales,
        lag(total_sales) over (order by month_start) as previous_month_sales
    from monthly_sales
)
select
    month_start,
    round(total_sales, 2) as total_sales,
    round(previous_month_sales, 2) as previous_month_sales,
    round(total_sales  - previous_month_sales) as difference,
    round(
        (total_sales - previous_month_sales)
        / nullif(previous_month_sales, 0) * 100,
        2
    ) as sales_mom_growth_percent
from sales_with_previous
order by month_start;

with monthly_profit as (
    select
        trunc(order_date, 'mm') as month_start,
        sum(profit) as total_profit
    from superstore
    group by trunc(order_date, 'mm')
),
profit_with_previous as (
    select
        month_start,
        total_profit,
        lag(total_profit) over (order by month_start) as previous_month_profit
    from monthly_profit
)
select
    month_start,
    round(total_profit, 2) as total_profit,
    round(previous_month_profit, 2) as previous_month_profit,
    round(total_profit - previous_month_profit) as difference,
    round(
        (total_profit - previous_month_profit)
        / nullif(abs(previous_month_profit), 0) * 100,
        2
    ) as profit_mom_growth_percent
from profit_with_previous
order by month_start;

select
    trunc(order_date, 'mm') as month_start,
    round(sum(sales), 2) as total_sales,
    round(sum(profit), 2) as total_profit,
    round(sum(profit) / nullif(sum(sales), 0) * 100, 2)
        as profit_margin_percent
from superstore
group by trunc(order_date, 'mm')
order by month_start;
