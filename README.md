<div align="center">

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:43CBFF,100:9708CC&height=200&section=header&text=SQL%20EDA%20Project&fontSize=42&fontColor=ffffff&animation=fadeIn&fontAlignY=38&desc=by%20Rindhya%20JS%20%E2%80%94%20My%20first%20deep%20dive%20into%20Exploratory%20Data%20Analysis%20using%20SQL&descAlignY=58&descSize=15" width="100%"/>

<a href="#">
  <img src="https://readme-typing-svg.demolab.com/?font=Fira+Code&weight=600&size=22&pause=1000&color=9708CC&center=true&vCenter=true&width=650&lines=Hi%2C+I'm+Rindhya+JS+%F0%9F%91%8B;Exploring+data+with+SQL;Learning+CTEs+%2B+Window+Functions;Turning+raw+tables+into+real+insights!" alt="Typing SVG" />
</a>

<br/><br/>

![SQL](https://img.shields.io/badge/SQL-T--SQL-43CBFF?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Level](https://img.shields.io/badge/Level-Beginner%20Friendly-9708CC?style=for-the-badge)
![Made with](https://img.shields.io/badge/Made%20with-Curiosity%20%F0%9F%94%8D-orange?style=for-the-badge)

</div>

<br/>

## 👋 About This Project

Hi, I'm **Rindhya JS** 🙌 — and this is one of my **first hands-on projects in SQL** , **Built on top of the Gold layer from my SQL Data Warehouse Project**, where I practiced **Exploratory Data Analysis (EDA)** on a retail sales dataset (organized as a **Gold layer** — clean fact & dimension tables, warehouse-style).

Instead of just writing random queries, I followed a proper analyst's workflow — starting from *"what does this database even look like?"* all the way to *"which products are actually performing well over time?"* 🎯

This project helped me get comfortable with things like **CTEs**, **window functions**, **ranking**, and **time-series trend analysis** — the real building blocks behind any data analytics dashboard.

---

## 🧩 Data I Worked With

A simple **star schema** — one fact table surrounded by two dimension tables:

```
      gold.dim_customers            gold.dim_products
             │                             │
             │      customer_key           │  product_key
             └────────────┐        ┌───────┘
                           ▼        ▼
                     gold.fact_sales
        (order_date, sales_amount, quantity, price)
```

| Table | What's in it |
|---|---|
| 🧾 `gold.fact_sales` | Every sale — date, amount, quantity, price |
| 🙋 `gold.dim_customers` | Customer info — country, gender, birthdate |
| 📦 `gold.dim_products` | Product info — category, subcategory, cost |

---

## 🗂️ What's Inside This Repo

| # | Script | What I Explored |
|---|---|---|
| 🔎 | `database_exploration.sql` | Getting familiar with tables & columns |
| 🌍 | `dimenstion_exploration.sql` | Unique countries, categories & products |
| 📅 | `date_exploration.sql` | Order date range & customer age |
| 📈 | `measure_report.sql` | Core numbers — total sales, orders, customers |
| ⚖️ | `magnitude.sql` | Breaking numbers down by country/gender/category |
| 🏆 | `Ranking_Analysis.sql` | Best & worst performing products |
| ⏳ | `CHANGES_OVER_TIME_ANALYSIS.sql` | Yearly & monthly sales trends |
| 📊 | `CUMMULATIVE_ANALYSIS.sql` | Running totals & moving averages |
| 🚀 | `PERFORMANCE_ANALYSIS.sql` | Product performance vs. average & last period |

---

## 🛠️ Skills I Practiced

<table>
<tr>
<td width="50%" valign="top">

**🔤 SQL Basics**
- `GROUP BY` / `ORDER BY`
- `SUM()`, `AVG()`, `COUNT()`
- `UNION ALL` for combined reports
- `TOP N` filtering

</td>
<td width="50%" valign="top">

**⚡ Leveled-Up SQL**
- Common Table Expressions (CTEs)
- Window Functions: `OVER()`, `LAG()`, `ROW_NUMBER()`
- Date functions: `DATETRUNC()`, `DATEDIFF()`
- Running totals & moving averages

</td>
</tr>
</table>

---

## 🧠 My Thought Process

```
Step 1  →  Explore the database (what tables/columns exist?)
Step 2  →  Explore dimensions (what categories/countries exist?)
Step 3  →  Explore dates (what time period does the data cover?)
Step 4  →  Calculate key business measures (the "big numbers")
Step 5  →  Break measures down by dimension (magnitude analysis)
Step 6  →  Rank products (who's winning, who's not?)
Step 7  →  Study trends over time (yearly/monthly changes)
Step 8  →  Track cumulative growth (running totals)
Step 9  →  Analyze performance vs. average & previous period
```

---

## ▶️ Try It Yourself

```bash
# 1. Clone this repo
git clone https://github.com/<your-username>/<your-repo>.git

# 2. Set up a SQL Server database with a "gold" schema
#    containing: fact_sales, dim_customers, dim_products

# 3. Run the scripts in order — start with exploration,
#    then measures, then the deeper analysis files
```

---

## 💡 What I Learned

> Working on this project taught me that **EDA isn't just about writing queries** — it's about asking the right questions in the right order, and letting each query build on the last one. 🌱

---

<div align="center">

### 🚧 This is a learning project — I'm still growing as a data analyst!
### Feedback, tips & suggestions are always welcome 💬

**— Rindhya JS**

<img src="https://capsule-render.vercel.app/api?type=waving&color=0:9708CC,100:43CBFF&height=120&section=footer" width="100%"/>

</div>
