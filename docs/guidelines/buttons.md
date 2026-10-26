# Datamate G3 — Buttons & Actions

> The definitive specification for all interactive buttons in Datamate G3.

---

## Button Types at a Glance

| Type | Color | Where it lives | Purpose |
| :--- | :--- | :--- | :--- |
| **Primary** | Blue `#20389B` | Footer / Action bar (far right) | Save Changes, Submit, Confirm |
| **Exit** | Red `#D32F2F` | Top Header Bar (far right) | Close, Discard Changes |
| **Secondary** | Outlined (blue text) | Footer / Action bar (far left) | View All, Export CSV, Print |
| **Row Add** | Green `#2E7D32` | Grid row (right end) | Add a new record |
| **Row Clear** | Orange `#ED6C02` | Grid row (right end) | Reset / clear record |
| **Row Delete** | Red `#D32F2F` | Grid row (right end) | Remove record |

---

## 1. Primary Button (Save / Submit / Confirm)

> 🔗 **Interactive Catalog Showcase:** [Open Primary Button (`DatamatePrimaryButton`) in Catalog](http://localhost:3003/#/buttons?item=primary)

The primary action on every screen. There is only ever **one** primary progression button per context.

| Property | Value |
| :--- | :--- |
| Background | **#20389B** (Primary Blue) |
| Text color | **White** |
| Font | **Poppins 13.5px Semi-Bold** |
| Height | **40px** |
| Horizontal padding | **24px** |
| Border radius | **6px** |
| Icon | Optional, placed to the left of the label with 8px gap |
| Placement | Typically anchored at the **rightmost** position of action footers |

### States

| State | Appearance |
| :--- | :--- |
| Default | Blue background, white text |
| Hover | Slight brightness increase (lighten 8%) |
| Pressed | Darken 5% |
| Loading | Replaces label with a spinner, disables clicks |
| Disabled | 50% opacity, cursor `not-allowed` |

---

## 2. Exit Button (Close / Discard)

> 🔗 **Interactive Catalog Showcase:** [Open Exit Button (`DatamateExitButton`) in Catalog](http://localhost:3003/#/buttons?item=exit)

Signals that the user is exiting or abandoning the current workflow. Uses red to communicate "leaving this context."

| Property | Value |
| :--- | :--- |
| Background | **#D32F2F** (Semantic Red) |
| Text color | **White** |
| Font | **Poppins 13px Semi-Bold** |
| Height | **36px** |
| Border radius | **6px** |
| Icon | ✕ icon, placed to the left of label |
| Placement | Anchored at the **rightmost** edge of the Top Header Bar |

---

## 3. Secondary Buttons (View All / Export / Print)

> 🔗 **Interactive Catalog Showcase:** [Open Secondary Button (`DatamateSecondaryButton`) in Catalog](http://localhost:3003/#/buttons?item=secondary)

Utility actions that do not commit primary form changes. Outlined to remain visually subservient to the primary button.

| Property | Value |
| :--- | :--- |
| Background | **Transparent** |
| Border | 1px solid **#DCE1E7** |
| Text color | **#20389B** (Primary Blue) |
| Font | **Poppins 13px Semi-Bold** |
| Height | **40px** |
| Horizontal padding | **16px** |
| Border radius | **6px** |
| Icon | Optional, 16px size, placed to the left |
| Placement | Typically positioned on the **far left** of action bars |

### States

| State | Appearance |
| :--- | :--- |
| Default | Transparent with subtle border |
| Hover | Light blue tint background (`#20389B` at 5% opacity) |
| Pressed | `#20389B` at 10% opacity |

---

## 4. Row Action Buttons (Simple Icon Buttons)

> 🔗 **Interactive Catalog Showcase:** [Open Row Action Buttons (`DatamateRowActionButton`) in Catalog](http://localhost:3003/#/buttons?item=row-actions)

Row actions appear at the right end of a row or grid item. They are **simple icon buttons** — no container boxes, no colored background tiles, and no borders. They are clean icons with built-in hover states and tooltips.

### Properties

| Property | Value |
| :--- | :--- |
| Style | Clean **IconButton** (transparent background, no borders) |
| Icon size | **20px** |
| Target area | **32 × 32px** clickable touch target |
| Gap between buttons | **8px** |
| Hover / Splash | Standard Material ink ripple on hover |
| Tooltip | Mandatory tooltip on hover (e.g. "Add", "Clear", "Delete") |

### Colors by Action

| Action | Icon Color | Icon | Purpose |
| :--- | :--- | :--- | :--- |
| **Add** | Green **#2E7D32** | ＋ circle (`add_circle_outline_rounded`) | Append a new row |
| **Clear** | Orange **#ED6C02** | ↻ refresh (`refresh_rounded`) | Reset/clear row inputs |
| **Delete** | Red **#D32F2F** | 🗑 trash (`delete_outline_rounded`) | Remove the row |

### Inline Row Layout

```
│  ... row inputs ...  │  [＋] 8px [↻] 8px [🗑]  │
│                      │  ← simple icon buttons → │
```

---

## Placement Rules Summary

```
┌─────────────────────── HEADER BAR ────────────────────────────┐
│  Page Title                                [✕ Close]         │
│                                             ↑ Exit button     │
├──────────────────────────────────────────────────────────────┤
│                                                               │
│  (content area — no buttons here except in-row actions)       │
│                                                               │
├─────────────────────── ACTION FOOTER ─────────────────────────┤
│  [View All] [Export CSV]              [✓ Save Changes]       │
│  ↑ Secondary actions (left)            ↑ Primary action (right)│
└──────────────────────────────────────────────────────────────┘
```

> **Rule:** Never place a primary action button in the header. Never place a close/exit button in the footer.
