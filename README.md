# Retail Analytics SQL Project

## 📌 Project Overview
This project demonstrates my SQL skills through the design and analysis of a fictional retail database.
The goal is to answer real-world business questions related to sales performance, customer behavior,
marketing effectiveness, and customer retention using structured query language.

The project follows a clean and reproducible workflow:
database schema design → data population → analytical queries.

---

## 🛠️ Tech Stack
- Database: Microsoft SQL Server
- Language: T-SQL (Transact-SQL)
- Tool: SQL Server Management Studio (SSMS)

---

## 🧩 Database Schema
The database consists of the following tables:

- customers  
- products  
- orders  
- order_items  
- returns  
- marketing_campaigns  
- customer_campaigns  

The schema was designed to support transactional analysis, customer-level insights,
and marketing performance evaluation.

---

## 🔍 Key Analyses
The project includes SQL queries that address the following business questions:

- Revenue and sales analysis
- Product return rates and return impact
- Marketing campaign effectiveness
- Customer Lifetime Value (LTV)
- Churn proxy analysis based on customer inactivity

Advanced SQL concepts used:
- Complex JOINs
- Aggregations and GROUP BY
- Common Table Expressions (CTEs)
- Window functions
- Conditional logic (CASE statements)

---

## 📊 Example Insights
- A small percentage of customers generates the majority of total revenue
- The Winter Sale campaign outperformed the Spring Promo campaign in terms of revenue
- Customers inactive for more than 60 days were identified as churned using a time-based proxy

---

## 📁 Project Structure
**Database Schema:** [Script Creazione Tabelle](Retail_Analytics_sql/schema_create_tables.sql)
**Data Ingestion:** [Script Popolamento Dati](Retail_Analytics_sql/data.sql)
**Analisi SQL (Queries):**
    * [Livello Base](Retail_Analytics_sql/Queries/Basic_Queries.sql)
    * [Livello Intermedio](Retail_Analytics_sql/Queries/Intermediate_Level_Queries.sql)
    * [Livello Avanzato](Retail_Analytics_sql/Queries/Advanced_Level_Queries.sql)


