# Data Model

This document describes the star schema, table columns, relationships, and key measures used in the Power BI report.

---

## Star Schema (High-level)
- **Fact**: `Sales`
- **Dimensions**: `Order Date`, `Customer`, `Product`, `Sales Territory`



---

## Relationships
- `Sales[Order Date]` → `Order Date[Order Date]` (Many-to-One, single direction)
- `Sales[Customer Key]` → `Customer[Customer Key]` (Many-to-One)
- `Sales[Produc(y) Key]` → `Product[Product Key]` (Many-to-One)
- `Sales[Sale Territory Key]` → `Sales Territory[Sale Territory Key]` (Many-to-One)

> Note: If “Produc**y** Key” is a typo, rename to **Product Key** in the model for clarity.

---

## Tables & Columns

### 1) Sales (Fact)
*(Grain: one row per sales **order line**)*  
![Sales Fields](./sales-fields.png)

**Keys / Links**
- `Sales Order Number`
- `Sales Order Line Number`
- `Customer Key` (→ `Customer`)
- `Produc(y) Key` (→ `Product`)
- `Sale Territory Key` (→ `Sales Territory`)
- `Order Date` (→ `Order Date`)

**Numeric Columns**
- `Order Quantity`
- `Unit Price`
- `Line Total Cost`
- `Line Total Sales`
- `Line margin`
- `Line margin percentage`

**Helper Columns (if needed)**
- `Count`, `Count_1`, `Count_all`, `Count_Geater_50`
- `line_all`
- `Target`

**Measures (from model)**
- `Total Sales`
- `Total Sales SUMX`
- `Total Sales YoY% 3`
- `Total Margin`
- `Total margin percentage`

> Keep helper columns if you use them in visuals; otherwise consider removing to simplify the model.

---

### 2) Order Date (Dimension)
*(Marked as Date table)*
- `Order Date`
- `Order Date Month`
- `Order Date Month Number`
- `Order Date Year`
- `Order Date Hierarchy` (composite hierarchy)

**Typical DAX (example if you need a calculated date table)**
```DAX
Order Date =
ADDCOLUMNS (
    CALENDAR ( DATE ( 2019, 1, 1 ), DATE ( 2026, 12, 31 ) ),
    "Order Date Year", YEAR ( [Date] ),
    "Order Date Month Number", MONTH ( [Date] ),
    "Order Date Month", FORMAT ( [Date], "MMM" )
)
