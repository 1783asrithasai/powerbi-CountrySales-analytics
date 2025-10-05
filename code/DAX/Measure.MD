# DAX Measures (Power BI)

> Model tables: **Sales** (fact), **Order Date** (date), **Customer**, **Product**, **Sales Territory**.  
> Time intelligence uses `'Order Date'[Order Date]` (marked as Date table).

## 1) Core Sales
```DAX
Total Sales =
SUM ( Sales[Line Total Sales] )

Total Quantity =
SUM ( Sales[Order Quantity] )

Total Sales (SUMX) =
SUMX (
    Sales,
    Sales[Order Quantity] * Sales[Unit Price]
)
```

## 2) Margin
```DAX
Total Margin =
SUM ( Sales[Line margin] )

Total Margin % =
DIVIDE ( [Total Margin], [Total Sales] )
```

## 3) Orders / Pricing
```DAX
Orders =
DISTINCTCOUNT ( Sales[Sales Order Number] )

Avg Order Value =
DIVIDE ( [Total Sales], [Orders] )

Avg Selling Price =
DIVIDE ( [Total Sales], [Total Quantity] )
```

## 4) Time Intelligence
```DAX
Sales YTD =
TOTALYTD ( [Total Sales], 'Order Date'[Order Date] )

Sales YoY =
VAR PrevYear =
    CALCULATE ( [Total Sales], DATEADD ( 'Order Date'[Order Date], -1, YEAR ) )
RETURN [Total Sales] - PrevYear

Sales YoY % =
VAR PrevYear =
    CALCULATE ( [Total Sales], DATEADD ( 'Order Date'[Order Date], -1, YEAR ) )
RETURN DIVIDE ( [Total Sales] - PrevYear, PrevYear )
```

## 5) Optional extras
```DAX
Quantity YTD =
TOTALYTD ( [Total Quantity], 'Order Date'[Order Date] )

Orders YTD =
TOTALYTD ( [Orders], 'Order Date'[Order Date] )
```
