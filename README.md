# Power BI Country Analytics

This repository organizes your project files by country and provides a simple structure for code, data, and reports. It’s ready to initialize as a Git repository and push to GitHub.

## Structure
```
powerbi-country-analytics/
├─ data/                  # Raw inputs by country (Excel files)
│  ├─ Australia/
│  ├─ Canada/
│  ├─ France/
│  ├─ Germany/
│  ├─ New_Zealand/
│  └─ United_Kingdom/
├─ code/                  # Scripts (e.g., data prep, helpers for DAX exports, etc.)
├─ reports/               # Exported visuals, PDFs, images, or notebooks
└─ docs/                  # Documentation (methodology, data dictionary)
```

## Power BI report link
- App workspace/report: https://app.powerbi.com/groups/me/list?ctid=cd62b7dd-4b48-44bd-90e7-e143a22c8ead&experience=power-bi

## Included data files
{
  "Australia": [
    "Australia 2022.xlsx",
    "Australia Pre 2022.xlsx"
  ],
  "New_Zealand": [
    "New Zealand 2022.xlsx"
  ],
  "Canada": [
    "Canada 202201.xlsx",
    "Canada 202202.xlsx",
    "Canada 202203.xlsx",
    "Canada 202204.xlsx",
    "Canada 202205.xlsx",
    "Canada 202206.xlsx",
    "Canada 202207.xlsx",
    "Canada Pre 2022.xlsx"
  ],
  "France": [
    "France 2022.xlsx",
    "France Pre 2022.xlsx"
  ],
  "Germany": [
    "Germany 2022.xlsx",
    "Germany Pre 2022.xlsx"
  ],
  "United_Kingdom": [
    "United Kingdom 2022.xlsx",
    "United Kingdom Pre 2022.xlsx"
  ]
}

## Quick start (CLI)
```bash
# 1) Initialize Git (from inside the folder)
cd powerbi-country-analytics
git init

# 2) Create a new repo on GitHub (from the GitHub UI). Then add the remote:
git remote add origin https://github.com/<your-username>/powerbi-country-analytics.git

# 3) Stage and commit
git add .
git commit -m "Initial commit: organize data by country, add README and .gitignore"

# 4) Push
git branch -M main
git push -u origin main
```

> Tip: If your .pbix file is large, consider Git LFS:
```bash
# One-time on your machine
git lfs install
# Track Power BI files
git lfs track "*.pbix"
git add .gitattributes
git commit -m "Track PBIX with LFS"
```

## Suggested workflow
- Place Power BI `.pbix` in the repo root or `reports/`.
- Export any Power Query (M) or DAX measures as text and put them in `code/`.
- Add a short write-up in `docs/` explaining sources, transformations, and assumptions.
- Use consistent file names and keep raw vs. processed files separate.
