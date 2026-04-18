# plotting_in_r

An R project for exploratory data analysis and visualisation of environmental
data, using [`renv`](https://rstudio.github.io/renv/) for reproducible package
management and [Quarto](https://quarto.org/) for literate analysis documents.

---

## Project Structure

```
plotting_in_r/
├── plotting_in_r.Rproj      # RStudio project file
├── .Rprofile                # Activates renv on startup
├── renv.lock                # Pinned package versions (commit this)
├── renv/
│   └── activate.R           # renv bootstrap loader
├── data/
│   └── environmental_data.csv  # Sample environmental dataset (100 rows)
└── analysis/
    └── environmental_analysis.qmd  # Quarto analysis script
```

---

## Setup

### Prerequisites

| Tool | Version |
|---|---|
| R | ≥ 4.4 |
| Quarto CLI | ≥ 1.5 |

### 1. Clone the repository

```bash
git clone https://github.com/daniel-lee-wilkinson/plotting_in_r.git
cd plotting_in_r
```

### 2. Open the project in RStudio

Open `plotting_in_r.Rproj` in RStudio.  
The `.Rprofile` will automatically activate the `renv` environment on startup.

### 3. Restore the R package library

```r
renv::restore()
```

This installs all packages listed in `renv.lock` into the project-local library.

### 4. Render the Quarto document

Either click **Render** in RStudio, or run from the terminal:

```bash
quarto render analysis/environmental_analysis.qmd
```

The rendered HTML report is written to `analysis/environmental_analysis.html`.

---

## Dataset — `data/environmental_data.csv`

100 simulated field observations across major US national parks.

| Variable | Type | Description |
|---|---|---|
| `sample_id` | String | Unique record ID (e.g. `ENV_001`) |
| `date` | String | Date of observation (`YYYY-MM-DD`) |
| `location` | String | National park name |
| `observer_name` | String | Field observer's name |
| `season` | Categorical | `Spring`, `Summer`, `Autumn`, `Winter` |
| `weather_condition` | Categorical | `Clear`, `Partly Cloudy`, `Overcast`, `Light Rain`, `Heavy Rain`, `Foggy`, `Snowy` |
| `land_use_type` | Categorical | `Forest`, `Grassland`, `Wetland`, `Desert`, `Alpine`, `Coastal`, `Urban Fringe` |
| `temperature_c` | Numerical | Air temperature (°C) |
| `humidity_pct` | Numerical | Relative humidity (%) |
| `wind_speed_kmh` | Numerical | Wind speed (km/h) |
| `precipitation_mm` | Numerical | Precipitation (mm) |
| `air_quality_index` | Numerical | AQI score |
| `uv_index` | Numerical | UV radiation index (0–11) |
| `visibility_km` | Numerical | Atmospheric visibility (km) |

---

## Package Management with renv

This project uses [`renv`](https://rstudio.github.io/renv/) to create a
reproducible, project-local R library.

| Command | Purpose |
|---|---|
| `renv::restore()` | Install packages from `renv.lock` |
| `renv::install("pkg")` | Add a new package |
| `renv::snapshot()` | Update `renv.lock` after adding packages |
| `renv::status()` | Check library vs lockfile consistency |

> **Tip:** Commit `renv.lock` but **not** `renv/library/` (already in `.gitignore`).
