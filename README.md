# Superstore Analytics

A retail analytics project using Oracle SQL, Excel, and Power BI to analyze the Superstore dataset from Kaggle.

## Project structure

```text
superstore-analytics/
├── data/                         # Source dataset
├── sql/                          # Oracle SQL analysis queries
├── excel/                        # Excel workbook and export outputs
├── powerbi/                      # Power BI dashboard assets
├── .gitignore
└── README.md
```

## Dataset

Download the Superstore dataset from Kaggle and save it as:

```text
data/Sample - Superstore.csv
```

## Oracle setup

Create an Oracle table named `superstore`, then import the CSV using Oracle SQL Developer or SQL*Loader. The SQL files expect these normalized columns:

```text
order_id, order_date, ship_date, ship_mode, customer_id, customer_name,
segment, country, city, state, postal_code, region, product_id, category,
sub_category, product_name, sales, quantity, discount, profit
```

Validate the import with:

```sql
select count(*) from superstore;
select sum(sales), sum(profit) from superstore;
```

Expected results are approximately 9,994 rows, $2,297,200.86 in sales, and $286,397.02 in profit.

## SQL analysis

- Month-over-month sales, profit, growth, and margin
- Top products and loss-making products
- Category, subcategory, regional, and discount profitability
- Customer revenue, frequency, recency, CLV, and retention actions

## Excel outputs

The `excel/exports/` directory contains CSV results that can be imported into worksheets for further analysis and reporting.

## Power BI dashboard

Open the Power BI report in `powerbi/` and validate the visuals, filters, and KPI pages before publishing the final dashboard.

## Validation checklist

- [ ] CSV imported into Oracle
- [ ] Row count and sales/profit totals validated
- [ ] SQL queries executed successfully
- [ ] Excel export outputs reviewed
- [ ] Power BI slicers and filters tested
- [ ] Dashboard published or shared as needed
