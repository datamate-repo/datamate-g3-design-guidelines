# Datamate G3 — Dropdowns & Selection Fields

> The definitive specification for all dropdown and searchable selection fields in Datamate G3.

---

## Core Principle

A dropdown in Datamate G3 is an **interactive selection field**. It strictly matches standard text field dimensions at rest — **40px** fixed height, subtle **#ECEFF2** fill, **6px** border radius, and **1px #DCE1E7** border. 

A trailing chevron indicates selectability, and a clear button (✕) provides one-click reset when enabled.

---

## Base Trigger Dimensions

Identical to standard text fields:

| Property | Value |
| :--- | :--- |
| Height | **40px** — strictly enforced |
| Border radius | **6px** |
| Background fill | **#ECEFF2** |
| Border | 1px solid **#DCE1E7** |
| Text style | **Poppins 13.5px Medium**, color **#1E293B** |
| Horizontal padding | **12px** left, **4px** right (to accommodate trailing icon) |
| Trailing icon | Chevron down, **20px**, color **#64748B** |
| Clear icon (when enabled) | ✕ icon, **16px**, color **#64748B** (sits adjacent to chevron) |

---

## Label Placement

Labels sit **to the left** of the field, centered vertically, never stacked above:

```
  User Role:     [  Administrator          ▾  ]
  ←   label   → 8px gap ←      dropdown       →
```

| Property | Value |
| :--- | :--- |
| Label font | **Poppins 13px Semi-Bold** |
| Label color | **#1E293B** |
| Gap between label and dropdown | **8px** |
| Vertical alignment | Center-aligned to the 40px field height |

---

## Focus & Active States

| State | Appearance |
| :--- | :--- |
| Default | Standard input appearance with trailing chevron |
| Focused (closed) | Border changes to **#20389B** (Primary Dark Blue), **1.5px** width |
| Open (overlay active) | Trigger maintains **#20389B** border; overlay drops anchored below/above |
| Disabled | **50% opacity** border, muted text (**#64748B**), cursor `not-allowed` |

---

## Dropdown Types

### 1. Standard Dropdown (`DatamateDropdown`)

> 🔗 **Interactive Catalog Showcase:** [Open Standard Dropdown (`DatamateDropdown`) in Catalog](http://localhost:3003/#/dropdowns?item=standard)

Used for small, static option sets (2–10 items) where full search is unnecessary.

- Used for: User Role, Sort Order, Priority, Status
- Displays selected option directly in the field
- Opens native/standard popover menu (max height 240px)

---

### 2. Searchable Dropdown (`DatamateSearchableDropdown`)

> 🔗 **Interactive Catalog Showcase:** [Open Searchable Dropdown (`DatamateSearchableDropdown`) in Catalog](http://localhost:3003/#/dropdowns?item=searchable)

Used for medium-to-large local datasets (10–500 items) like country lists, category trees, product tags, or project assignees.

#### Behavior:
- **Instant Search:** Typing an alphanumeric character while focused on the trigger field immediately opens the overlay with that character pre-filled into the search box.
- **Real-Time Filtering:** Results filter instantaneously as the user types in the overlay's 40px search bar.
- **Scroll Sync:** Automatically scrolls to the currently selected item on open.
- **Clear Button:** When `clearable: true`, a small ✕ icon appears next to the chevron when an item is chosen.

#### Floating Overlay Dimensions:
| Property | Value |
| :--- | :--- |
| Default width | **440px** |
| Default height | **420px** |
| Background | White / Surface color |
| Elevation | **6dp** with subtle drop shadow |
| Border | 1px solid **#DCE1E7**, radius **8px** |
| Header | Title on left, optional action button ("+ Add"), close button (✕) on right |
| Search bar | Fixed **40px** height, `#ECEFF2` fill, 6px radius, search icon prefix |
| Row min-height | **44px** per list item |
| Selected row tint | `#20389B` at **10% opacity** |

---

### 3. Asynchronous / API Searchable Dropdown (`DatamateAsyncSearchableDropdown`)

> 🔗 **Interactive Catalog Showcase:** [Open Asynchronous Dropdown (`DatamateAsyncSearchableDropdown`) in Catalog](http://localhost:3003/#/dropdowns?item=async)

Used for remote databases, server-side search, and lazy-loading datasets with thousands of records (e.g. customer databases, master item catalogs, global address lookups).

#### Behavior:
- **Debounced Remote Query:** Search input changes wait for a **500ms debounce** before invoking the remote `onSearch` callback, avoiding API request spam.
- **Loading Spinner:** A clean 24px spinner in `#20389B` displays while remote requests are in flight.
- **Reactive Stream / Notifier:** Overlay updates reactively as remote items stream in.
- **Empty State:** Clean centered *"No results found"* text when queries return zero records.
- **Extensible Header:** Supports custom action widgets (e.g. quick "New Record" modal trigger) and filter chips directly in the overlay header.

---

### 4. Inline Dropdown (Table & Data Grid Cells)

Used inside table rows where column headers already provide context.

- Label is **omitted**
- Height remains strictly **40px**
- Expands to fill cell width

---

## Keyboard Navigation Rules

Both Searchable and Asynchronous dropdowns implement standard enterprise desktop keyboard ergonomics:

| Key Event | Action |
| :--- | :--- |
| `[a-z]`, `[0-9]` on trigger | Opens overlay with character pre-filled in search field |
| `Enter` on trigger | Opens overlay |
| `Arrow Down` on trigger | Opens overlay |
| `Arrow Down` in overlay | Highlights next item in list |
| `Arrow Up` in overlay | Highlights previous item; if on top item, returns focus to search input |
| `Enter` in overlay | Commits highlighted selection, fires `onChanged`, and closes overlay |
| `Escape` in overlay | Dismisses overlay without altering current selection |

---

## Overlay Positioning & Collision Detection

The floating overlay is dynamically anchored to the trigger field using screen coordinate calculations:

1. **Default Placement:** Directly below the trigger with a **4px vertical gap**.
2. **Bottom Collision:** If `trigger.bottom + overlay.height > screen.height`, the overlay automatically flips **above** the trigger (`trigger.top - overlay.height - 4px`).
3. **Right Collision:** If `trigger.left + overlay.width > screen.width`, the overlay shifts leftward to remain inside the viewport with a **16px safety margin**.

---

## Quick Reference

```
┌─ Label ──────── 8px ──── Dropdown Field ──────────────────────────┐
│                          ┌──────────────────────────── ✕ ── ▾ ──┐ │
│  Customer:               │  Alex Morgan (Acme Corp)             │ │
│  Poppins 13px SemiBold   │  40px tall, #ECEFF2 fill, 6px radius │ │
│                          └──────────────────────────────────────┘ │
│                                                                   │
│                          ┌──────────────────────────────────────┐ │
│                          │ Customer                    [+ Add] ✕│ │
│                          │ ┌──────────────────────────────────┐ │ │
│                          │ │ 🔍 Type to filter...          ✕  │ │ │
│                          │ └──────────────────────────────────┘ │ │
│                          │ ──────────────────────────────────── │ │
│                          │   Alex Morgan (Acme Corp)   ✓        │ │
│                          │   Beth Harmon (Lexington Tech)       │ │
│                          │   Charles Xavier (Mutant Systems)    │ │
│                          └──────────────────────────────────────┘ │
│                           ↑ 440×420px overlay, 8px radius, shadow │
└───────────────────────────────────────────────────────────────────┘
```
