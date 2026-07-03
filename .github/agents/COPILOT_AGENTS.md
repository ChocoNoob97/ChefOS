# ChefOS Custom Agents

This file documents the custom agents available for ChefOS and when each one should be used.

## 1. ChefOS Architecture Agent
- Purpose: Review the app’s structure, widget hierarchy, models, scalability, and technical debt.
- When to use it: Use this agent when you want a high-level technical review of the codebase, reusable-widget opportunities, or a low-risk architecture recommendation without implementing changes.
- Example prompts:
  - "Review the current architecture and suggest the next best improvements."
  - "Identify reusable widget opportunities without over-engineering."
  - "What technical debt should we address next in a low-risk way?"

## 2. ChefOS Cleanup Agent
- Purpose: Audit the project for cleanup opportunities such as dead code, unused imports, duplicate code, unused widgets, TODOs, and placeholder code.
- When to use it: Use this agent when you want a maintenance-oriented review before making any edits, especially for pruning stale code or simplifying the project.
- Example prompts:
  - "Audit the project and produce a cleanup checklist."
  - "Find dead code and placeholder screens that should be removed or repurposed."
  - "Review the codebase for low-risk cleanup items that preserve behavior."

## 3. ChefOS Documentation Agent
- Purpose: Maintain ChefOS Markdown documentation after completed features.
- When to use it: Use this agent when documentation needs to be updated for shipped work, design-system changes, or milestone progress.
- Example prompts:
  - "Update the development log with the latest completed work."
  - "Refresh the documentation for the new reusable widgets."
  - "Document the latest Phase 1 completion in the project docs."

## 4. ChefOS Product Agent
- Purpose: Review features and workflows from the user’s perspective and recommend simpler, lower-friction improvements.
- When to use it: Use this agent when you want product-oriented feedback focused on reducing tapping, typing, confusion, waste, or cost.
- Example prompts:
  - "Suggest simpler inventory flow improvements for users."
  - "Review the current onboarding experience and reduce friction."
  - "What product changes would make the app feel faster and easier to use?"

## 5. ChefOS UI Agent
- Purpose: Maintain consistency across the ChefOS UI system and identify reusable widget opportunities.
- When to use it: Use this agent when reviewing spacing, typography, colors, layout patterns, or repeated widget structures without redesigning the app.
- Example prompts:
  - "Review the UI for duplicated widgets and inconsistent patterns."
  - "Suggest small consistency improvements that preserve the current design."
  - "Find reusable widget opportunities in the current screens."
