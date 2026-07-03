# ChefOS Design System

Version 1.0

---

# Mission

ChefOS helps people save money, waste less food, and cook smarter.

Every screen should feel clean, simple, and approachable.

---

# Design Philosophy

Less taps.

Less thinking.

More cooking.

Every screen should answer one question:

"What should I do next?"

---

# Colors

Primary

Black

Background

White

Secondary Text

Grey

Error

Red

No gradients.

No unnecessary colors.

---

# Typography

Hero Title

30
Bold

Screen Title

24
Bold

Section Title

18
SemiBold

Body

16

Caption

14

---

# Buttons

Primary

Black background

White text

Used for:

- Continue
- Save
- Scan Barcode
- Get Started

Secondary

White background

Black outline

Black text

Used for:

- Manual Entry
- Refrigerator
- Pantry
- Freezer
- Choose Date

---

# Cards

Rounded corners

12px radius

Light gray background

Thin border

No shadows

---

# Reusable Widgets

## ChefButton

Purpose:
Use ChefButton for all primary and secondary actions.

Why it exists:
It standardizes button appearance, supports disabled states, and keeps the current black-and-white visual language intact.

Use it for:
- Continue
- Save Item
- Get Started
- Secondary storage choices
- Date selection actions

## ChefTextField

Purpose:
Use ChefTextField for all simple form inputs.

Why it exists:
It centralizes label, hint, keyboard, validation, and spacing behavior while staying visually consistent with the existing form design.

Use it for:
- Product name
- Quantity
- Location
- Search input

## ChefSectionTitle

Purpose:
Use ChefSectionTitle for repeated headings and supporting copy.

Why it exists:
It removes repeated heading markup and ensures section titles look consistent across screens.

Use it for:
- Dashboard sections
- Inventory sections
- Review screen sections
- Setup prompts

## ChefInfoTile

Purpose:
Use ChefInfoTile for information rows that appear as stacked cards.

Why it exists:
It replaces repeated ListTile patterns and keeps review, dashboard, and inventory information rows visually consistent.

Use it for:
- Review Item details
- Dashboard storage-area items
- Inventory summaries

## ChefStatCard

Purpose:
Use ChefStatCard for small summary metrics on the dashboard.

Why it exists:
It gives the dashboard a consistent summary card pattern without changing the current layout or tone.

Use it for:
- Total items
- Items at risk

## ChefEmptyState

Purpose:
Use ChefEmptyState when a screen has no visible content to show yet.

Why it exists:
It creates a simple, friendly empty experience for inventory and search states without adding extra complexity.

Use it for:
- Empty inventory lists
- No-search-results state

## ChefInventoryCard

Purpose:
Use ChefInventoryCard for inventory rows that need product, quantity, expiration, and location information.

Why it exists:
It captures the repeating product-card pattern in one reusable widget and keeps dashboard and inventory content aligned.

Use it for:
- Inventory list rows
- Dashboard priority items

---

# Spacing

XS = 4

SM = 8

MD = 16

LG = 24

XL = 40

---

# Navigation

White AppBar

Centered "ChefOS"

Minimal navigation

One primary action per screen

---

# Product Principles

Save Money.

Waste Less.

Cook Smarter.

Every Ingredient Matters.


Ched OS Design Principles
1. One primary action per screen.

2. Reduce unnecessary taps.

3. Reduce unnecessary thinking.

4. Every screen should answer:
   "What should I do next?"

5. Helpful over clever.
   ChefOS guides the user instead of expecting them to remember things.

6. Consistency beats customization.

7. If a UI pattern appears twice,
   it becomes a ChefOS component.