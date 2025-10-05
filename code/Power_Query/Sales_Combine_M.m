// Power Query (M) — Combine Country Files into one table
// Adjust sheet/table names and types to your sources.

let
    // 1) Read all files under the repo's data folder
    Source = Folder.Files("data"),

    // 2) Keep only Excel files
    KeepExcel = Table.SelectRows(Source, each Text.EndsWith([Extension], ".xlsx")),

    // 3) Add Country from folder path
    AddCountry = Table.AddColumn(KeepExcel, "Country", each
        let p = Text.Lower([Folder Path]) in
        if Text.Contains(p, "australia") then "Australia"
        else if Text.Contains(p, "canada") then "Canada"
        else if Text.Contains(p, "france") then "France"
        else if Text.Contains(p, "germany") then "Germany"
        else if Text.Contains(p, "new_zealand") or Text.Contains(p, "new zealand") then "New Zealand"
        else if Text.Contains(p, "united_kingdom") or Text.Contains(p, "united kingdom") then "United Kingdom"
        else null
    ),

    // 4) Open each workbook and expand all tables/sheets
    GetWorkbook = Table.AddColumn(AddCountry, "WB", each Excel.Workbook([Content], true)),
    ExpandWB = Table.ExpandTableColumn(GetWorkbook, "WB", {"Name","Data","Item","Kind"}, {"Name","Data","Item","Kind"}),

    // 5) Filter to Tables/Sheets, then expand the data
    OnlyTables = Table.SelectRows(ExpandWB, each [Kind] = "Table" or [Kind] = "Sheet"),
    FirstTableCols = if Table.RowCount(OnlyTables) > 0 then Table.ColumnNames(OnlyTables{0}[Data]) else {},
    ExpandData = if List.Count(FirstTableCols) > 0 then Table.ExpandTableColumn(OnlyTables, "Data", FirstTableCols) else OnlyTables,

    // 6) Standardize column names
    RenameCols = Table.TransformColumnNames(ExpandData, each Text.Trim(_)),

    // 7) Type conversion (edit to match your schema)
    Typed =
        Table.TransformColumnTypes(
            RenameCols,
            {
                {"Order Date", type date},
                {"Order Quantity", Int64.Type},
                {"Unit Price", type number},
                {"Line Total Sales", type number},
                {"Line margin", type number},
                {"Customer Key", type text},
                {"Product Key", type text},
                {"Sales Order Number", type text},
                {"Sales Order Line Number", type text}
            },
            "en-US"
        ),

    // 8) Compute Line Total Sales if missing
    WithAmount =
        if List.Contains(Table.ColumnNames(Typed), "Line Total Sales")
        then Typed
        else Table.AddColumn(Typed, "Line Total Sales", each [Order Quantity] * [Unit Price], type number),

    // 9) Keep valid rows
    CleanRows = Table.SelectRows(WithAmount, each try [Order Quantity] > 0 otherwise false),

    // 10) Output
    Result = CleanRows
in
    Result
