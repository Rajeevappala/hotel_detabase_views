# HotelDatabase — View-Based Security & Reporting

## 📌 Project Overview
This project demonstrates **SQL Server security and data abstraction** using **Views**.  
We create a complex view summarizing customer order data, then grant restricted access to that view while preventing direct access to sensitive base tables.

---

## 🛠️ Technologies Used
- **SQL Server**
- **T-SQL**
- **Database Security (GRANT / REVOKE)**
- **Views for Abstraction**

---

## 📂 Database Used
**HotelDatabase** with the following key tables:
- `CUSTOMERS`
- `ORDERS`

---

## 🚀 Steps Implemented

### 1️⃣ Create a Server-Level Login
```sql
CREATE LOGIN reporting_user WITH PASSWORD = 'Rajeev@123';

```
### 2️⃣ Create a Database User for the Login

``` sql
CREATE USER reporting_user FOR LOGIN reporting_user;
```

### 🎯 Key Learnings

Views can simplify complex queries.

Security can be enforced by granting access to views while restricting base tables.

Aggregate functions (COUNT, SUM, AVG) can be combined with GROUP BY for reporting.
