# Datamate G3 — Text Fields

> The definitive specification for all text input fields in Datamate G3.

---

## Base Dimensions

Every text field in Datamate G3 uses these exact measurements:

| Property | Value |
| :--- | :--- |
| Height | **40px** — no taller, no shorter |
| Border radius | **6px** |
| Horizontal padding (inside) | **12px** left and right |
| Background fill | **#ECEFF2** (subtle grey) |
| Border | 1px solid **#DCE1E7** |
| Text style | **Poppins 13.5px Medium**, color **#1E293B** |
| Placeholder style | **Poppins 13.5px Regular**, color **#64748B** |

---

## Focus State

When a text field receives focus:

| Property | Value |
| :--- | :--- |
| Border color | Changes to **#20389B** (Primary Dark Blue) |
| Border width | Increases to **1.5px** |
| Background | Remains **#ECEFF2** (no change) |
| Shadow | None — border stroke transition only |

---

## Label Placement

Labels sit **to the left** of the input, centered vertically, never stacked above:

```
  Full Name:     [  Alex Morgan                ]
  ←   label   → 8px gap ←       input         →
```

| Property | Value |
| :--- | :--- |
| Label font | **Poppins 13px Semi-Bold** |
| Label color | **#1E293B** (Text Primary) |
| Gap between label and input | **8px** |
| Vertical alignment | Center-aligned to the 40px input field |

---

## Text Field Variations

### 1. Standard Input

> 🔗 **Interactive Catalog Showcase:** [Open `DatamateTextField` (Standard) in Catalog](http://localhost:3003/#/text-fields?item=standard)

The default text field used for entering user names, emails, titles, descriptions, and addresses.

- Background: `#ECEFF2`
- Editable, with placeholder text
- Example: Full Name, Email Address, Product Title

### 2. Numeric / Currency Input

> 🔗 **Interactive Catalog Showcase:** [Open Numeric / Currency Input in Catalog](http://localhost:3003/#/text-fields?item=numeric)

Used for monetary amounts, quantities, rates, and percentages.

- Text alignment: **Right-aligned** inside the input
- Placeholder: `0.00` (right-aligned)
- Same 40px height, 6px radius, and border specifications
- Example: Price ($), Quantity, Discount Rate, Total Amount

### 3. Prefix & Suffix Icon Inputs

> 🔗 **Interactive Catalog Showcase:** [Open Icon Prefix/Suffix Inputs in Catalog](http://localhost:3003/#/text-fields?item=icons)

Used when an input benefits from visual context or clear triggers.

- Prefix icon: Placed at the left interior edge (e.g. email envelope icon, website URL icon)
- Suffix icon: Placed at the right interior edge (e.g. calendar date picker trigger, clear button)
- Icon size: **18px**, color **#64748B**
- Height constraint: Strictly **40px** fixed height — icon constraints are bounded so icons never distort or expand the field height
- Example: Email Address, Date Selection Inputs

### 4. Read-Only / Disabled Input

> 🔗 **Interactive Catalog Showcase:** [Open Disabled / Read-Only Input in Catalog](http://localhost:3003/#/text-fields?item=disabled)

Used for non-editable fields such as system-generated identifiers, license keys, or immutable metadata.

- Border: 1px solid `#DCE1E7` at **50% opacity**
- Text color: **#64748B** (Text Muted)
- Background: `#ECEFF2`
- Cursor: `not-allowed`
- Example: System ID, API Token, Fixed Reference

---

## Spacing Between Multiple Fields

> 🔗 **Interactive Catalog Showcase:** [Open Form Spacing (16px Grid) in Catalog](http://localhost:3003/#/text-fields?item=spacing)

When multiple fields are placed side by side in a row:

| Scenario | Gap |
| :--- | :--- |
| Adjacent fields horizontally | **16px** |
| Fields wrapping to a new line vertically | **16px** |

---

## Inside Data Grid Cells

When text fields appear inside a data grid row:

- Labels are **omitted** (the column header acts as the label)
- Height remains **40px**
- The field fills the available cell width
- Numeric columns are right-aligned

---

## Quick Reference

```
┌─ Label ──────── 8px ──── Input Box ──────────────────────────┐
│                          ┌──────────────────────────────────┐ │
│  Full Name:              │  Alex Morgan                     │ │
│  Poppins 13px SemiBold   │  40px tall, #ECEFF2 fill         │ │
│  #1E293B                 │  12px horizontal padding         │ │
│                          │  1px #DCE1E7 border, 6px radius  │ │
│                          └──────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────┘
```
