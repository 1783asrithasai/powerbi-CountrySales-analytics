# Order Date Table (DAX)

> Create this as a **calculated table** in Power BI, then mark it as the Date table and set `[Date]` as the date column.

```DAX
Order Date =
VAR MinDate =
    DATE ( YEAR ( MINX ( ALL ( Sales ), Sales[Order Date] ) ), 1, 1 )
VAR MaxDate =
    DATE ( YEAR ( MAXX ( ALL ( Sales ), Sales[Order Date] ) ), 12, 31 )
RETURN
ADDCOLUMNS (
    CALENDAR ( MinDate, MaxDate ),
    "Order Date Year", YEAR ( [Date] ),
    "Order Date Month Number", MONTH ( [Date] ),
    "Order Date Month", FORMAT ( [Date], "MMM" ),
    "Order Date Year-Month", FORMAT ( [Date], "YYYY-MM" ),
    "Order Date Quarter", "Q" & FORMAT ( [Date], "Q" ),
    "Order Date Week Number", WEEKNUM ( [Date], 2 ),
    "IsYTD", YEAR ( [Date] ) = YEAR ( TODAY() ) && [Date] <= TODAY()
)
```
