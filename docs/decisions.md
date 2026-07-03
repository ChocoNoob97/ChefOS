Decision #1

Users select Refrigerator, Pantry or Freezer first.

Reason:

Makes onboarding easier.

--------------------

Decision #2

ChefOS recommends a Use By reminder instead of an expiration date.

Reason:

Expiration varies by storage method.

--------------------

Decision #3

Only one primary action per screen.

Decision #4

ChefOS provides a recommended "Use By" date instead of displaying only an expiration date.

Reason:

Storage methods affect food longevity. ChefOS should guide users while still allowing them to override the recommendation with their own date.

Decision #5

Title:
Primary actions should remain visible whenever practical.

Decision:
ChefOS keeps the primary action accessible instead of relying on users to discover it by scrolling.

Reason:
Reducing friction and unnecessary finger movement is a core design principle of ChefOS.


Decision #6

Title:
Primary action remains fixed on form screens.

Decision:
ChefOS keeps the primary action ("Continue", "Save", etc.) pinned to the bottom of the screen while the content scrolls.

Reason:
Users should never have to search or scroll to find the next action. This reduces friction, supports one-handed use, and reinforces ChefOS's "one primary action per screen" design principle.

Decision #7

Title:
ChefOS will use reusable page layouts.

Decision:
Form-based screens will be built using a shared ChefFormPage widget, while informational screens will use a shared ChefPage widget.

Reason:
This eliminates repeated layout code, ensures consistency across the app, reduces maintenance, and allows future design updates to be made in one place.

Decision #8

Title:
Shared form layout.

Decision:
All ChefOS form screens will use a reusable ChefFormPage widget.

Reason:
A single reusable layout provides consistent navigation, spacing, scrolling, and primary actions while significantly reducing duplicated code.

Decision #9

Title:
Framework-first development.

Decision:
ChefOS will prioritize reusable framework components before expanding new features.

Reason:
Building reusable layouts and widgets reduces duplicated code, accelerates future development, and keeps the user experience consistent across the app.

Decision #10

Title:
Bottom-up component architecture.

Decision:
ChefOS builds reusable UI from small components (buttons, app bars, text fields) before composing larger page layouts.

Reason:
Smaller reusable components reduce duplication, simplify testing, and allow future pages to inherit improvements automatically.

Decision #11

Title:
Two-Time Rule

Decision:
If the same Flutter UI or logic is written twice, it should be converted into a reusable ChefOS component.

Reason:
This reduces duplicate code, speeds up future development, improves consistency, and makes the app easier to maintain as it grows.

Decision #12

Title:
Unified Button System

Decision:
ChefOS will use a single reusable button component supporting both primary and outlined variants.

Reason:
A unified button system ensures visual consistency, reduces duplicate code, simplifies maintenance, and allows future styling changes to propagate throughout the app from a single location.


Decision #13

Title:
Interactive Recommendation Card

Decision:
The ChefOS recommendation card serves as both information and the action to apply the recommended date.

Reason:
This removes a redundant button, reduces scrolling and finger movement, and creates a more assistant-like experience while preserving the user's ability to override the recommendation.


## Decision: Pass data between screens instead of hardcoding values

### Why

The Review Item screen should display the information the user entered on the Item Details screen. Hardcoded placeholder values would prevent the app from accurately reflecting user input.

### Decision

Use TextEditingControllers and pass values through the Navigator to ReviewItemScreen during Phase 1.

### Future

Replace manual data passing with a shared data layer or state management solution in Phase 2.

## Decision: Introduce a shared InventoryItem model

### Reason

Multiple screens (Item Details, Review Item, Dashboard, Inventory) require the same item information. Using a shared model avoids duplicated variables and prepares ChefOS for future database integration.

### Decision

Phase 1 will use a shared InventoryItem object passed between screens. Phase 2 will store these objects in local and cloud storage.

## Shared Inventory Model

Decision:
Use a single InventoryItem model throughout the application instead of passing individual values.

Reason:
Keeps every screen synchronized and prepares ChefOS for local storage and Supabase integration.

Status:
Implemented in Phase 1.

## Decision: Standardize screen layout

ChefOS screens will use ChefFormPage and ChefAppBar as the default page structure.

Reason:
Creates a consistent layout, reduces duplicate code, and keeps primary actions pinned while allowing content to scroll.

## Decision: Build a small reusable widget library

### Why

The app now has repeated patterns across buttons, text inputs, headings, details rows, and dashboard cards. A small shared widget library keeps the UI consistent, reduces duplicate code, and makes future screen changes easier without introducing unnecessary abstraction.

### Decision

Phase 1 will introduce lightweight reusable widgets for the most common UI patterns:
- ChefButton for actions
- ChefTextField for inputs
- ChefSectionTitle for headings
- ChefInfoTile for detail rows
- ChefStatCard for dashboard metrics
- ChefEmptyState for empty states
- ChefInventoryCard for inventory rows

### Reason

These widgets preserve the current design language while replacing repeated implementation details with consistent components that can be reused across screens.

### Scope

This decision is intentionally limited to Phase 1. No repositories, services, or state-management abstractions are introduced as part of this update.

## Decision: Store the storage location once during setup

### Why

The app should not ask users to choose or type their storage location more than once. Repeating the same decision in Item Details creates unnecessary friction and conflicts with the approved setup-first experience.

### Decision

The location selected during Setup is the single source of truth for the item and is passed through the item-details, review, dashboard, and inventory flow.

### Result

- Item Details no longer asks for the location again.
- Review Item shows the location as read-only.
- Dashboard and Inventory display the stored location without prompting for a second choice.

## Decision: Keep dashboard summary values live and derived from inventory

### Why

Hardcoded dashboard metrics become inaccurate as soon as items are added, removed, or changed. The Phase 1 experience should reflect the current inventory state at all times.

### Decision

The dashboard summary is calculated directly from the live inventory list. Counts update automatically whenever the inventory changes.

### Result

- Total Items updates as items are added or removed.
- At Risk Items updates based on the current list.
- Pantry, Refrigerator, and Freezer counts update from the current storage locations.

## Decision: Make summary cards interactive and keep inventory titles dynamic

### Why

The dashboard should make it easy to jump into the relevant part of the inventory without extra taps or duplicate screens. The inventory title should clearly reflect the current filter so the user understands what they are viewing.

### Decision

Each inventory summary card navigates to the shared Inventory screen with the relevant filter applied. The Inventory screen title and subtitle update automatically from the active filter.

### Result

- Total Items opens the full inventory.
- Pantry, Refrigerator, and Freezer cards open filtered inventory lists.
- The inventory title reflects the active filter with the matching item count.

## Decision: Refocus the dashboard on assistant-style actions

### Why

The dashboard should help the user take the next best action rather than act like a storage map. The product goal is to save money, reduce waste, and remove effort while staying honest about what ChefOS knows.

### Decision

The dashboard now focuses on four summary areas: Total Items, Expiring Soon, High Priority Recommendations, and Recommended Recipes. Storage organization is handled inside the Inventory screen instead of on the dashboard.

### Result

- The dashboard is simpler and more action-oriented.
- Storage-area counts no longer appear on the dashboard.
- The high-priority section is explicitly framed as recommendations based only on known inventory data.

## Decision: Keep recommendations transparent and evidence-based

### Why

ChefOS should never pretend to know what the user has eaten or finished. Recommendations should only be based on known inventory information and should explain why they appear.

### Decision

High-priority recommendations now include a reason such as Expires Today, Expires Tomorrow, Expires in X Days, or Earliest Expiration. The app never generates guesses or blame-based messages.

### Result

- Recommendations are easier to trust.
- The app remains supportive, even when the user’s inventory is imperfect.
- Future AI features can build on this transparent foundation.

## Decision: Centralize recommendation logic

### Why

Recommendation formatting and urgency rules should be defined once so the Dashboard, Inventory, and future AI features use the exact same logic.

### Decision

Expiration labels and recommendation reasons now live in a shared utility so the app avoids duplicated logic across screens.

### Result

- Dashboard and Inventory stay aligned.
- Future AI or reminder features can consume the same recommendation source.

## Decision: Make the Dashboard FAB the primary add-item action

### Why

Adding inventory should be the fastest action in the app. The dashboard should help users act quickly rather than navigate through a secondary path.

### Decision

The Dashboard floating action button now opens the Add Item flow directly.

### Result

- Inventory entry is faster and more discoverable.
- Inventory remains available through the standard navigation as well.

## Decision: Mark Kitchen Check-In as a Phase 2 placeholder

### Why

The current Kitchen Check-In experience should feel intentional, not broken or misleading.

### Decision

Kitchen Check-In now shows a coming-soon message that explains it is being prepared for Phase 2 and does not pretend to perform inventory updates yet.

### Result

- The feature feels honest and low-friction.
- The app preserves a clear path for future implementation without fake functionality.

## Decision: Normalize names before saving

### Why

Inconsistent capitalization and spacing make inventory entries look messy and can create duplicate entries that differ only by formatting.

### Decision

Product names are normalized before saving by trimming spaces, collapsing extra whitespace, and capitalizing words consistently. The normalized value is shown across the app and is used to prevent duplicate items that differ only by capitalization.

### Result

- Item names are more polished and consistent.
- Inventory stays easier to scan and manage.
- The app avoids duplicate clutter from formatting differences.

## Decision: Start with a fresh, empty inventory experience

### Why

Sample ingredients create confusion and make the app feel less trustworthy. A new account should start from an empty state that reflects the real user experience.

### Decision

The app starts with an empty inventory list. Dashboard counts begin at zero and are calculated only from items entered by the user.

### Result

- The app displays zeroed summary values before any item is added.
- Empty inventory shows a simple empty state and an Add First Item action.

## Decision: Add minimal inventory management actions

### Why

Phase 1 should support the basic operations needed to keep the list accurate without introducing unnecessary complexity.

### Decision

Inventory items can be deleted directly from the inventory list, and the Profile screen includes a Clear Inventory action that requires confirmation before clearing everything.

### Result

- Deleting an item updates all summaries immediately.
- Clearing inventory is protected by a confirmation dialog to reduce accidental data loss.