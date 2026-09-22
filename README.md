# DecodeLabs Data Analytics Internship: Project 3 (SQL Data Analysis)
**Batch:** 2026  
**Track:** SQL Data Analysis — Querying for Truth  
**Deliverable:** Relational Database Extraction & Analytical Verification  

---

## 1. Executive Summary & Objective
The objective of Project 3 is to transition from exploratory scripts to structured declarative querying using SQL. Using the enterprise retail orders dataset (1,200 records), we construct targeted queries to evaluate product revenue distribution, monitor fulfillment pipeline leakage (returns/cancellations), analyze marketing channel efficiency with post-aggregation filtering (`HAVING`), and evaluate promotional discounting behavior.

---

## 2. Declarative Execution Architecture
All queries respect the database engine compilation lifecycle:
$$\text{FROM / JOIN} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{SELECT} \longrightarrow \text{ORDER BY}$$

- **Row Filtering (`WHERE`):** Evaluated prior to grouping to prune unqualified transaction rows efficiently.
- **Aggregation (`COUNT`, `SUM`, `AVG`):** Computed across grouped categorical keys, handling `NULL` values in promotional codes using `COALESCE`.
- **Group Filtering (`HAVING`):** Applied strictly to aggregate values (`SUM(TotalPrice) > 200000`) rather than row-level predicates.

---

## 3. SQL Query Catalog & Key Results

### Query 1: Top High-Volume Shipped Orders
Extracts orders successfully shipped with purchase quantities $\ge 4$, sorted by order value.
- **Keywords:** `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- **Output Reference:** `q1_top_shipped_orders.csv`

### Query 2: Product Performance & Category Financials
Calculates total orders, total units sold, average unit price, gross revenue, and AOV grouped by product.
- **Keywords:** `COUNT()`, `SUM()`, `AVG()`, `ROUND()`, `GROUP BY`, `ORDER BY`
- **Output Reference:** `q2_product_performance.csv`

### Query 3: Fulfillment Pipeline Leakage Analysis
Identifies transaction volume and gross dollar amounts lost due to cancellations and returns across each product line.
- **Keywords:** `WHERE ... IN`, `GROUP BY`, `SUM()`
- **Output Reference:** `q3_revenue_leakage.csv`

### Query 4: Marketing Acquisition Performance (Post-Aggregation Filtering)
Isolates referral sources achieving over 200 transactions and generating greater than $200,000 in gross revenue.
- **Keywords:** `GROUP BY`, `HAVING COUNT() >= 200 AND SUM(TotalPrice) > 200000`
- **Output Reference:** `q4_channel_having.csv`

### Query 5: Promotional Code & Basket Size Analysis
Categorizes transactions by promotional tier (`SAVE10`, `FREESHIP`, `WINTER15`, or `NO_COUPON`) to inspect average basket quantity and cart size.
- **Keywords:** `COALESCE()`, `COUNT()`, `AVG()`, `GROUP BY`
- **Output Reference:** `q5_promotional_impact.csv`

---

## 4. Key Business Takeaways
1. **Category Concentration:** Revenue is heavily driven by high-ticket electronics (Monitors, Tablets, Laptops), which also account for the highest aggregate return dollar amounts.
2. **Channel Efficiency:** Major referral sources meet enterprise volume thresholds ($>200$ transactions), confirming sustained balanced acquisition across Google, Facebook, Instagram, and direct Referrals.
3. **Discount Basket Mechanics:** Average order quantities remain stable (~2.9–3.0 items) regardless of coupon tier, indicating that discounts are not actively incentivizing larger basket sizes and should be gated behind minimum spend conditions.
