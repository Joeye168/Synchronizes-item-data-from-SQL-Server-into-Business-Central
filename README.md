# Synchronizes-item-data-from-SQL-Server-into-Business-Central

This repository documents the **Power Automate Flow** that synchronizes item data from a SQL Server table into **Microsoft Dynamics 365 Business Central (BC)**, using multiple custom API pages (`Item General`, `Item Price Sales`, `Item UoM`, `Item Purch Xfer Setup`, etc.).

---
<img width="454" height="854" alt="{6B8E0AEB-5F5B-488C-AFDF-160115881CA0}" src="https://github.com/user-attachments/assets/e54f3297-52c8-459b-ad5a-07c58b53994a" />

## 📦 Overview

### 🔹 Flow Name
**`ScynItem SQL Server -> Business Central`**

### 🔹 Purpose
Automatically synchronize item data from the SQL Server staging table `[dbo].[Add New Item TEST]` into corresponding Business Central entities.

The flow checks whether the item already exists in BC:
- ✅ If **exists** → updates all related records.  
- 🆕 If **not exists** → creates new records and fills in related tables.

---

## ⚙️ Architecture


flowchart TD
    A[🔁 Recurrence Trigger<br>(Weekly)] --> B[🗄️ Get Rows from SQL]
    B --> C[🔎 Filter Array<br>CL_OpenPriceItem = 1]
    C --> D[🔁 For Each SQL Record]
    D --> E[🔍 Find Item in BC]
    E --> F{Item Exists?}
    F -->|Yes| G1[🧩 Update Item]
    G1 --> G2[🧩 Update General Info]
    G2 --> G3[🧩 Update Price & Sales Info]
    G3 --> G4[🔎 Find Item UoM]
    G4 --> G5{UoM Exists?}
    G5 -->|Yes| G6[✏️ Update UoM]
    G5 -->|No| G7[➕ Create UoM]
    G6 --> G8[🔎 Find Item Purch Xfer Setup]
    G8 --> G9{Xfer Exists?}
    G9 -->|Yes| G10[✏️ Update Xfer Setup]
    G9 -->|No| G11[➕ Create Xfer Setup]
    G10 --> G12[💰 Update Cost & Posting Info]
    G12 --> G13[🐾 Update PetSave Info]
    G13 --> G14[✅ Update SQL Record (ScynTime)]
    F -->|No| H1[🆕 Create Item in BC]
    H1 --> H2[🧩 Update General Info]
    H2 --> H3[🧩 Update Price Info]
    H3 --> H4[➕ Create UoM]
    H4 --> H5[🔎 Find Purch Xfer Setup]
    H5 --> H6{Exists?}
    H6 -->|Yes| H7[✏️ Update Xfer]
    H6 -->|No| H8[➕ Create Xfer]
    H8 --> H9[💰 Update Cost & Posting]
    H9 --> H10[🐾 Update PetSave]
    H10 --> H11[✅ Update SQL Record]
````

---

## 🧩 Key Components

### 🔹 Data Sources

| Type             | Connector                | Name                        | Description                |
| ---------------- | ------------------------ | --------------------------- | -------------------------- |
| SQL              | `shared_sql`             | `[dbo].[Add New Item TEST]` | Source of all item records |
| Business Central | `shared_dynamicssmbsaas` | TESTBC / CRONUS             | Target BC environment      |

---

## 🧠 Core Logic Breakdown

### 1️⃣ **Trigger**

* Type: `Recurrence`
* Runs weekly (every 7 days)

---

### 2️⃣ **Get SQL Data**

* Action: `Get rows (Items)`
* Table: `[dbo].[Add New Item TEST]`
* Top Count: 14
* Filter: `CL_OpenPriceItem = 1`

---

### 3️⃣ **Find Record in BC**

* API: `items`
* Filter Query:

  ```text
  number eq '@{items('Apply_to_each')?['BX_x0020_ITEM']}'
  ```

---

### 4️⃣ **If Exists → Update**

#### ✅ Update Chain:

1. **UpdateRecord(V3)** → Update `items`
2. **Update_General_Info** → Update `itemGenerals`
3. **UpdatePriceSalesInfo** → Update `itemPriceSales`
4. **FindItemUoM**

   * `$filter`:

     ```text
     ItemNo eq '@{items('Apply_to_each')?['I_x0020_ASWO']}' and Code eq '@{items('Apply_to_each')?['J_x0020_SellUoM']}'
     ```
5. **Condition_2**

   * `length(outputs('FindItemUoM')?['body/value']) > 0`
6. **Update or Create UoM**
7. **FindUoMRecord / Condition_1**

   * Similar structure for `itemPurchXferSetup`
8. **Update_Cost_and_Posting_info**
9. **Update_PetSave_Info**
10. **Update_row_(V2)** → Update SQL flag + timestamp

---

### 5️⃣ **If Not Exists → Create**

#### 🆕 Creation Chain:

1. **CreateRecord(V3)** → Create new `item`
2. **Update_General_Info_2** → Fill general fields
3. **UpdatePriceSalesInfo_1**
4. **Create_Item_UoM1**
5. **FindUoMRecord1 / Condition_1_1**
6. **Update_Cost_and_Posting_fields**
7. **Update_PetSave_Fields**
8. **Update_row_(V2)_1**

---

## 🧩 Field Mapping Examples

| BC Table            | Field            | SQL Field                 | Notes                    |
| ------------------- | ---------------- | ------------------------- | ------------------------ |
| itemGenerals        | Description      | D_x0020_DescriptionPOS    | Primary item description |
| itemGenerals        | WebItem          | CI_x0020_WebItem          | Boolean-like flag        |
| itemPriceSales      | finalRetailPrice | BB_x0020_FinalRetailPrice | Retail price field       |
| itemUnitsOfMeasure  | Code             | J_x0020_SellUoM           | Sell UoM value           |
| itemPurchXferSetups | PurchUoM         | M_x0020_PurchUoM          | Purchase UoM setup       |
| itemCostPostings    | TariffDuty       | AH_x0020_Tariff           | Custom duty mapping      |

---

## 🧩 Conditions & Expressions

### Condition: Item Exists

```text
length(outputs('FindItem')?['body/value']) > 0
```

### Condition: UoM Exists

```text
length(outputs('FindItemUoM')?['body/value']) > 0
```

### Condition: Purch/Xfer Exists

```text
length(outputs('FindUoMRecord')?['body/value']) > 0
```

---

## 🔁 SQL Update Backflow

At the end of each loop:

* Sets `CL_OpenPriceItem = 0`
* Updates `ScynTime` with UTC timestamp

---

## 📡 Connectors

| Connector ID             | Type             | Environment |
| ------------------------ | ---------------- | ----------- |
| `shared_sql`             | SQL Server       | Default     |
| `shared_dynamicssmbsaas` | Business Central | TESTBC      |

---

## 🧾 Technical Notes

* **ODataKeyFields** correctly defined on all custom API pages (e.g., `SystemId`, `ItemNo`).
* All BC entities use `DelayedInsert = true`.
* Flow uses `FindRecords` + `Condition` instead of `GetRecord`, to avoid lookup failures.
* JSON keys with `_x0020_` correspond to SQL columns containing spaces.


## ✍️ Author

**Joe Ye**
Business Systems Analyst / Developer
Specializing in **Business Central, Power Platform, Azure AI, SQL Integration**

---

## 🧠 Future Enhancements

* [ ] Add error logging to Dataverse or Azure Table Storage
* [ ] Automate dependency tracking for BC API version updates
* [ ] Add Power BI dashboard for Flow sync statistics


> 💡 *This Flow provides a robust, modular structure for Business Central integration via Power Automate, using clean separation of API layers and SQL-driven mapping.*




