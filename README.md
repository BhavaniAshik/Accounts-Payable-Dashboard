# 💰 Accounts Payable Dashboard | Power BI

## 📌 Project Overview
This project is an **Accounts Payable (AP) Analytics Dashboard** built using **Power BI** to provide clear insights into vendor payments, outstanding liabilities, invoice aging, and payment performance.

The dashboard helps finance teams monitor overdue invoices, manage vendor relationships, and improve cash-flow decision-making.

---

## 🎯 Business Objectives
- Track **total payables and outstanding balances**
- Identify **overdue invoices**
- Analyze **invoice aging buckets**
- Monitor **vendor-wise payment status**
- Improve **cash flow visibility**

---

## 📊 Key KPIs
- Total Invoice Amount  
- Total Outstanding Amount  
- Overdue Amount  
- Invoice Count  
- Paid vs Unpaid Invoices  
- Average Days Overdue  

---

## 📈 Dashboard Visuals
- KPI Cards (Total Payable, Outstanding, Overdue)
- Invoice Aging Bucket Chart (0–30, 31–60, 61–90, 90+ Days)
- Vendor-wise Outstanding Amount
- Invoice Trend by Month
- Paid vs Unpaid Invoice Count
- Vendor Payment Status Table
- Slicers (Date, Vendor, Payment Status)

---

## 🧠 Data Model
**Fact Table**
- FactAPInvoices  
  - Invoice Date  
  - Due Date  
  - Payment Date  
  - Invoice Amount  
  - Paid Amount  
  - Outstanding Amount  
  - Vendor ID  

**Dimension Tables**
- DimVendor  
- DimDate  

Star schema implemented for performance and scalability.

---

## 🧮 Key DAX Measures
- Total Invoice Amount  
- Outstanding Amount  
- Overdue Amount  
- Invoice Count  
- Paid Invoice Count  
- Unpaid Invoice Count  
- Aging Bucket  
- Average Days Overdue  
- Vendor Rank by Outstanding  

DAX logic is built using proper **filter context** and **date intelligence**.

---

## 🛠 Tools & Technologies
- Power BI Desktop  
- DAX  
- Power Query  
- Data Modeling  
- Excel / CSV  

---

