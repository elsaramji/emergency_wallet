# Emergency Cash — Design System v1.0
> **Document Type:** Design System & Component Specification  
> **Version:** 1.0 — MVP  
> **Product:** Emergency Cash (Personal Finance App)  
> **Author:** Saramji — Junior Product Owner  
> **Target Platforms:** iOS & Android (Flutter)  
> **Languages Supported:** English (LTR) + Arabic (RTL)  
> **Region Focus:** MENA — Egypt MVP  

---

## Table of Contents

1. [Design Principles](#1-design-principles)
2. [Information Architecture](#2-information-architecture)
3. [Component System](#3-component-system)
4. [Design Tokens](#4-design-tokens)
5. [Localization & RTL Guidelines](#5-localization--rtl-guidelines)
6. [Visual Language](#6-visual-language)
7. [Behavior & Interaction Rules](#7-behavior--interaction-rules)
8. [Accessibility](#8-accessibility)
9. [Microcopy Guidelines (Bilingual)](#9-microcopy-guidelines-bilingual)
10. [Edge Cases](#10-edge-cases)

---

## 1. Design Principles

### 1.1 Core Philosophy

Emergency Cash is built on four foundational pillars. Every design decision must pass through this filter before implementation.

| Pillar | Definition | Design Implication |
|---|---|---|
| **Clarity** | Financial data must be instantly readable — no ambiguity | Large numerals, strong contrast, uncluttered layouts |
| **Trust** | Users are handing you visibility into their money | Conservative color use, no dark patterns, transparent logic |
| **Simplicity** | The app should feel easier than a notebook | One primary action per screen, minimal cognitive load |
| **Financial Awareness** | Surface insights without overwhelming | Progressive disclosure — show totals first, details on demand |

> **Core Design Mantra:** "The user should know their financial position within 3 seconds of opening the app."

---

### 1.2 Cultural Considerations for MENA Users

These are not optional. They are non-negotiable requirements for the Egyptian/MENA market.

**Trust Signals**
- Egyptians are skeptical of financial apps. Avoid excessive data requests at onboarding. Ask only for: Name, Phone, Password, Salary status.
- Never use the word "bank" or show bank-like iconography — this app is explicitly **not** a bank (as stated in the PRD). Use wallet metaphors instead.
- Display a clear "Your data stays on your device" message at onboarding (local-first storage model).

**Visual Culture**
- Green (`#00C48C`) is strongly associated with **financial success and blessing** in Egyptian culture. Use it for positive financial events (money received, savings growing).
- Red is associated with **loss and danger** — use it only for genuine error states and destructive actions. Never use red for neutral UI.
- Orange/amber (`#FF6B35`) signals caution without panic — ideal for the Emergency Wallet's "handle with care" personality.

**Behavioral Patterns**
- Many Egyptian users operate with cash-first habits (physical money). The app must treat Cash wallet as the primary wallet in hierarchy.
- Arabic users read financial amounts from left to right even when in RTL mode (numbers are universal). Design for this mixed-direction data.
- Prayer times and end-of-month salary periods are high-activity moments. Consider notification timing logic around these (Phase 2).

**Language Tone**
- Egyptian Arabic is warm, direct, and slightly informal. Avoid formal Modern Standard Arabic (فصحى) in UI copy — it feels cold and bureaucratic.
- Use Egyptian colloquial phrases in empty states and success messages.
- Never be judgmental about spending behavior. The app is a witness, not a judge.

---

### 1.3 Bi-Directional UX Principles (LTR + RTL Parity)

**The Golden Rule:** The app must feel natively designed for Arabic speakers — not a mirrored afterthought. Arabic users should feel the layout was built for them first.

**Parity Rules:**
- Every screen layout must be tested in both LTR and RTL before marking as complete.
- Component designs must define RTL behavior explicitly (see Section 3 for per-component rules).
- No hardcoded `left`/`right` values. Use logical properties: `start`/`end` in Flutter (`EdgeInsetsDirectional`, `TextDirection`).
- Touch targets, tap zones, and gesture areas must be mirrored correctly in RTL.
- Animations must reverse direction in RTL (slide-in from left in LTR → slide-in from right in RTL).

---

## 2. Information Architecture

### 2.1 App Structure — Screen Hierarchy

```
Emergency Cash App
│
├── ONBOARDING FLOW (First Launch Only)
│   ├── 01. Splash / Brand Screen
│   ├── 02. Registration (Name + Phone + Password)
│   ├── 03. OTP Verification
│   ├── 04. Salary Profile Question ("Do you have a stable salary?")
│   │   ├── YES → 05a. Enter Salary Amount → Emergency Wallet Activated
│   │   └── NO  → 05b. Confirmation Screen → Emergency Wallet Locked
│   └── 06. Initial Wallet Balance Setup (Cash / Visa / Smart Wallet)
│
├── MAIN APP (Post-Onboarding)
│   │
│   ├── HOME SCREEN (Dashboard)
│   │   ├── Total Available Balance Header
│   │   ├── Wallet Cards Grid (Cash / Visa / Smart / Emergency)
│   │   └── Recent Transactions Preview (last 3)
│   │
│   ├── CASH-IN SCREEN (Log Income)
│   │   ├── Amount Input
│   │   ├── Wallet Selector (Cash / Visa / Smart Wallet)
│   │   ├── Salary Toggle (checkbox — salaried users only)
│   │   └── Notes Field (optional)
│   │
│   ├── CASH-OUT SCREEN (Log Expense)
│   │   ├── Amount Input
│   │   ├── Wallet Selector (Cash / Visa / Smart / Emergency*)
│   │   ├── Category Selector
│   │   └── Notes Field (optional)
│   │       *Emergency wallet has restricted cashout flow
│   │
│   ├── TRANSACTION HISTORY SCREEN
│   │   ├── Full Transaction List (newest first)
│   │   ├── Filter: By Wallet Type
│   │   └── Filter: By Date Range
│   │
│   └── PROFILE / SETTINGS SCREEN
│       ├── Salary Profile (view / edit)
│       ├── Language Toggle (EN / AR)
│       └── Notification Preferences
│
└── MODALS & OVERLAYS
    ├── Emergency Withdrawal Warning Modal
    ├── Auto-Save Confirmation Bottom Sheet
    ├── Location Permission Request
    └── Category Selection Bottom Sheet
```

---

### 2.2 Navigation Hierarchy

**Navigation Pattern:** Bottom Tab Bar (4 items)

| Tab | Icon | Label (EN) | Label (AR) | Route |
|---|---|---|---|---|
| 1 | 🏠 | Home | الرئيسية | `/home` |
| 2 | ➕ | Add | إضافة | `/transaction/new` (FAB-style center button) |
| 3 | 📋 | History | السجل | `/history` |
| 4 | 👤 | Profile | الملف | `/profile` |

**RTL Navigation Mirroring:**
- Tab bar order stays the same (Home on left in LTR → Home on right in RTL). This is correct — tabs are not directional elements, they are positional.
- Back button (chevron) flips: `‹` in LTR → `›` in RTL.
- Swipe-to-go-back gesture reverses direction in RTL.
- Navigation slide transitions reverse: screens push from right in LTR → push from left in RTL.

---

### 2.3 Key User Flows

#### Flow A: Onboarding (Salaried User)

```
App Launch
  → Splash (1.5s)
  → Sign in With email and password 
  → Sign in with social Authentication [Google]
  → Registration Screen
      [Name] [Email] [Password] → [Continue]
  → Check Your email to Verified
  → Salary Question Screen
      "Do you receive a stable monthly salary?"
      [YES ✓]  [NO ✗]
      → (YES) Enter Salary Amount Screen
          [Amount Input in EGP]
          → [Activate Emergency Wallet]
          → Success Animation: "Emergency Wallet Ready 🔒"
  → Wallet Setup Screen
      "Set your current balances"
      [Cash Balance] [Visa Balance] [Smart Wallet Balance]
      → [Start Tracking]
  → HOME SCREEN (Dashboard)
```

#### Flow B: Cash-In (Salary Day)

```
HOME → Tap [+] FAB or "Cash In" button
  → CASH-IN SCREEN
      [Amount: 5000 EGP]
      [Wallet: Cash ▾]
      [☑ This is my salary] ← Toggle appears for salaried users
      [Notes: optional]
      → [Save]
  → SYSTEM CALCULATES: 20% of 5000 = 1000 EGP
  → AUTO-SAVE CONFIRMATION SHEET slides up:
      "✅ 1000 EGP saved to Emergency Wallet
       4000 EGP added to Cash"
      [OK, Got It]
  → Push Notification: "Your emergency fund just grew 💪"
  → HOME: Balances updated, Emergency Wallet shows 1000 EGP
```

#### Flow C: Emergency Withdrawal (Blocked)

```
HOME → Tap [+] → Cash Out
  → CASH-OUT SCREEN
      [Wallet: Emergency 🔒]
  → SYSTEM CHECKS: Cash + Visa + Smart = 320 EGP (> 50 EGP threshold)
  → BLOCK MODAL appears:
      ⚠️ "Emergency funds are protected"
      "You still have 320 EGP available in your other wallets.
       Emergency Cash is only for when you truly have nothing left."
      [Got It — Use Other Wallets]
      [I Really Have Nothing Left] ← escalation path
  → (If escalation): Confirmation Dialog
      "Are you sure? This withdraws from your emergency savings."
      [Cancel] [Yes, Withdraw]
```

#### Flow D: Emergency Withdrawal (Allowed)

```
CASH-OUT SCREEN
  → [Wallet: Emergency 🔒]
  → SYSTEM CHECKS: Total = 30 EGP (≤ 50 EGP threshold)
  → WARNING DIALOG:
      "⚠️ You're about to use emergency savings"
      [Cancel] [Confirm Withdrawal]
  → (Confirm): Transaction logged, balance deducted
  → Push notification: "Emergency fund used. Rebuild when you can 🔄"
```

---

## 3. Component System

### Component Naming Convention

```
[ComponentName].[Variant].[State]
Example: WalletCard.Emergency.Locked
         Button.Primary.Disabled
         InputField.Amount.Error
```

---

### 3.1 Wallet Cards

**Purpose:** Communicate wallet type, current balance, and status at a glance.

#### Variants

| Variant | Identity Color | Icon | Special Behavior |
|---|---|---|---|
| `WalletCard.Cash` | `#00C48C` (Green) | 💵 Banknote | Primary wallet — shown first |
| `WalletCard.Visa` | `#0A6EFF` (Blue) | 💳 Card | Shows last 4 digits (future) |
| `WalletCard.SmartWallet` | `#9B5CFF` (Purple) | 📱 Phone | Label: "Vodafone Cash / Fawry" |
| `WalletCard.Emergency` | `#FF6B35` (Orange) | 🛡️ Shield | Always separate, read-only |

#### Card Anatomy

```
┌─────────────────────────────────────┐
│  [Icon]  [Wallet Name]    [Status]  │  ← Header row
│                                     │
│         [Balance Amount]            │  ← Primary content (large number)
│         [Currency Label]            │
│                                     │
│  [Bottom meta: last updated / lock] │  ← Footer row
└─────────────────────────────────────┘
```

#### States

| State | Visual Treatment |
|---|---|
| `Default` | Solid colored background, white text, full opacity |
| `Active` (selected as source/dest) | Elevated shadow, subtle inner glow border |
| `Locked` (Emergency — non-salaried) | Desaturated background, lock icon overlay, 60% opacity on balance |
| `Empty` | Balance shows "0.00 EGP", subtle dashed border hint |

#### Sizing & Layout

| Property | Value |
|---|---|
| Height | 140px |
| Border Radius | `radius-xl` (28px) |
| Horizontal Padding | 20px |
| Vertical Padding | 20px |
| Balance Font Size | 32px / `font-weight: 700` |
| Wallet Name Font Size | 14px / `font-weight: 500` |
| Card Shadow | `shadow-card` (see tokens) |

#### RTL/LTR Rules

- In LTR: Icon → Name (left side), Status badge (right side)
- In RTL: Status badge (left side), Name ← Icon (right side)
- Balance number stays center-aligned in both directions (it's purely numerical)
- Currency label (`EGP` / `ج.م`) position: after number in LTR (`1,000 EGP`), before number in Arabic convention (`١٬٠٠٠ ج.م`)

---

### 3.2 Input Fields

#### Variants

| Variant | Usage | Special Rules |
|---|---|---|
| `InputField.Amount` | Money entry | Numeric keyboard, auto-format with commas, no negative values |
| `InputField.Notes` | Free text entry | Max 100 characters, character counter shown at 80+ chars |
| `InputField.Phone` | Registration | Tel keyboard, Egyptian number format: `01X XXXX XXXX` |
| `InputField.Password` | Registration | Masked, show/hide toggle, min 8 characters |
| `InputField.SalaryAmount` | Onboarding | Numeric only, EGP suffix always visible |

#### States

| State | Border | Label | Helper Text |
|---|---|---|---|
| `Default` | `ink-100` (1px) | Gray (`ink-500`) | Hidden |
| `Focused` | `primary` (2px) | Blue (`primary`) | Optional hint visible |
| `Filled` | `ink-100` (1px) | Small floating label (above) | Hidden |
| `Error` | `danger` (2px) | Red label | Error message visible below |
| `Disabled` | `ink-100` dashed | Gray, 40% opacity | Disabled reason (if any) |

#### Amount Field — Special Behavior

```
Input Rules:
- Accepts only digits and one decimal point
- Auto-inserts thousands separator on blur (1000 → 1,000)
- EGP label always visible as suffix (LTR) or prefix (RTL/Arabic)
- Maximum value: 9,999,999 EGP (prevents unrealistic entries)
- On focus: selects all text for easy replacement
- Placeholder: "0.00" (not "Enter amount" — numbers don't need explanation)
```

#### RTL/LTR Rules

- In LTR: Label top-left, currency suffix on right side of input
- In RTL: Label top-right, currency prefix on left side of input (Arabic numeral convention)
- Error messages: left-aligned in LTR, right-aligned in RTL
- Password show/hide icon: right side in LTR, left side in RTL

---

### 3.3 Buttons

#### Variants

| Variant | Usage | Background | Text Color |
|---|---|---|---|
| `Button.Primary` | Main CTA (Save, Continue, Confirm) | `primary (#0A6EFF)` | White |
| `Button.Secondary` | Secondary actions (Cancel, Back) | `primary-light (#E8F1FF)` | `primary` |
| `Button.Destructive` | Dangerous actions (Emergency Withdraw) | `danger (#FF3B3B)` | White |
| `Button.Ghost` | Tertiary / text actions | Transparent | `primary` |
| `Button.Warning` | Cautionary confirm (used in emergency flow) | `emergency (#FF6B35)` | White |

#### Sizes

| Size | Height | Font Size | Padding H | Usage |
|---|---|---|---|---|
| `lg` | 56px | 16px | 24px | Full-width primary CTAs |
| `md` | 48px | 15px | 20px | Modal actions, secondary screens |
| `sm` | 40px | 14px | 16px | Inline actions, filter chips |
| `xs` | 32px | 13px | 12px | Tag-like actions |

#### States

| State | Visual |
|---|---|
| `Default` | Base styles |
| `Hover / Pressed` | 8% darker background + slight scale (0.97) |
| `Loading` | Spinner replaces label, disabled interaction |
| `Disabled` | 40% opacity, cursor blocked |
| `Success` | Green checkmark replaces label (1.5s then reset) |

#### RTL/LTR Rules
- Button text is always centered — no directional change needed.
- Icon-before-text (LTR): icon on left → In RTL: icon on right.
- Full-width buttons: stretch full container in both directions identically.
- Back/Next button pairs: in LTR [Back] [Next] → in RTL [التالي] [رجوع] (order reverses spatially).

---

### 3.4 Salary Toggle (Checkbox)

**Purpose:** Marks a Cash-In as salary, triggering the 20% auto-save rule.

#### Anatomy

```
[ ☑ ] This is my salary  →  Auto-saves 20% to Emergency Wallet
```

| Property | Value |
|---|---|
| Size | 24×24px touch target minimum (40×40px expanded) |
| Checked Color | `success (#00C48C)` |
| Unchecked Color | `ink-300` border |
| Label | 15px, `ink-700` |
| Sub-label (when checked) | "20% will be saved automatically" — 13px, `ink-500` |

#### States

| State | Behavior |
|---|---|
| `Unchecked` | Default, no auto-save triggered |
| `Checked` | Sub-label appears, confirmation preview shows |
| `Disabled` | Shown only to non-salaried users with lock icon + "Set up salary profile first" |

#### RTL/LTR Rules
- LTR: Checkbox on left, label on right
- RTL: Label on right, checkbox on left (natural Arabic reading direction)
- The checkbox itself does NOT flip internally — the checkmark direction stays consistent.

---

### 3.5 Alerts & Modals

#### Alert Types

| Type | Icon | Color | Use Case |
|---|---|---|---|
| `Alert.Info` | ℹ️ | `primary-light` | Informational, non-blocking |
| `Alert.Success` | ✅ | `success-light` | Positive confirmation |
| `Alert.Warning` | ⚠️ | `warning-light` | Needs attention, not critical |
| `Alert.Danger` | 🚫 | `danger-light` | Error or blocking issue |
| `Alert.Emergency` | 🛡️ | `emergency-light` | Emergency wallet specific |

#### Emergency Withdrawal Warning Modal

This is the most critical modal in the app. It must:
1. Stop the user from making a hasty decision
2. Communicate the stakes without being alarming
3. Provide a clear, non-judgmental path forward

**Structure:**

```
┌────────────────────────────────────┐
│  🛡️  Emergency Funds Protected     │  ← Icon + Title
│                                    │
│  You still have [X] EGP available  │  ← Dynamic balance check
│  in your other wallets.            │
│                                    │
│  Emergency savings are for when    │  ← Explanation
│  you truly have nothing left.      │
│                                    │
│  [Got It — Use Other Wallets]      │  ← Primary CTA (Button.Primary)
│  [I Really Need It]                │  ← Escalation (Button.Ghost)
└────────────────────────────────────┘
```

**Modal Properties:**

| Property | Value |
|---|---|
| Type | Bottom Sheet (not full modal — less alarming) |
| Border Radius (top) | `radius-xl` (28px) |
| Drag Handle | Visible — users can dismiss by dragging |
| Backdrop | Semi-transparent dark, 60% opacity |
| Animation | Slide up from bottom (300ms, `ease-spring`) |
| RTL Animation | Same — bottom sheets are not directional |

---

### 3.6 Transaction List Items

#### Anatomy

```
LTR Layout:
┌─────────────────────────────────────────────┐
│ [Cat. Icon]  [Title]         [+/-Amount]    │
│              [Wallet] · [Time]  [Currency]  │
└─────────────────────────────────────────────┘

RTL Layout:
┌─────────────────────────────────────────────┐
│ [المبلغ+/-]      [العنوان]   [أيقونة الفئة] │
│ [العملة]    [الوقت] · [المحفظة]             │
└─────────────────────────────────────────────┘
```

| Property | Value |
|---|---|
| Height | 72px |
| Icon Size | 40×40px, rounded `radius-md` |
| Amount Font Size | 17px, `font-weight: 600` |
| Amount Color — Cash In | `success (#00C48C)` |
| Amount Color — Cash Out | `ink-900` (neutral — not red, not judgmental) |
| Emergency Cashout Color | `emergency (#FF6B35)` |
| Secondary Text | 13px, `ink-500` |
| Divider | 1px `ink-50`, `margin-start: 68px` (aligns after icon) |

#### States

| State | Visual |
|---|---|
| `Default` | Standard layout |
| `Pressed` | `ink-50` background highlight |
| `Emergency` | Left/right accent bar in `emergency` color |

---

### 3.7 Notifications (Push)

#### Notification Templates

| Type | Title | Body |
|---|---|---|
| Auto-Save Triggered | "Emergency fund updated 🛡️" | "1,000 EGP saved automatically from your salary." |
| Emergency Used | "Emergency fund accessed ⚠️" | "500 EGP withdrawn. Rebuild when you're ready." |
| Daily Reminder | "Did anything happen today? 💰" | "Keep your balances accurate — takes 10 seconds." |
| Low Emergency Fund | "Your safety net is thin 🔄" | "Your emergency fund is below 500 EGP. Consider saving more." |

**Notification Design Rules:**
- Always include emoji at end of title — it increases open rates in MENA market (analysis-based recommendation).
- Body copy: max 2 lines on lock screen. Never truncate mid-word.
- Never use notification for promotional or non-essential content (trust preservation).
- Respect Do Not Disturb — financial notifications are not urgent enough to bypass it.

---

## 4. Design Tokens

### 4.1 Color System

```
COLOR TOKENS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Primary Brand
--color-primary:         #0A6EFF   // Actions, links, focus states
--color-primary-light:   #E8F1FF   // Backgrounds, subtle highlights
--color-primary-dark:    #0047CC   // Pressed states, emphasis

// Success / Positive Financial
--color-success:         #00C48C   // Cash-in, savings, growth, Cash wallet
--color-success-light:   #E0FAF3   // Success backgrounds
--color-success-dark:    #00916A   // Success emphasis

// Warning / Caution
--color-warning:         #FFB400   // Alerts, low balance, attention needed
--color-warning-light:   #FFF6DC   // Warning backgrounds
--color-warning-dark:    #CC8F00   // Warning emphasis

// Danger / Error
--color-danger:          #FF3B3B   // Errors, destructive actions only
--color-danger-light:    #FFE9E9   // Error backgrounds
--color-danger-dark:     #CC2020   // Error emphasis

// Emergency Wallet Identity
--color-emergency:       #FF6B35   // Emergency wallet — cautious, not panic
--color-emergency-light: #FFF0EB   // Emergency backgrounds
--color-emergency-dark:  #CC4A1A   // Emergency emphasis

// Wallet Identity Colors
--wallet-cash:           #00C48C   // Cash wallet
--wallet-visa:           #0A6EFF   // Visa/Bank wallet
--wallet-smart:          #9B5CFF   // Smart/Mobile wallet
--wallet-emergency:      #FF6B35   // Emergency wallet

// Neutral / Ink Scale
--color-ink-900:         #0D0F14   // Body text, primary content
--color-ink-800:         #1A1D26   // Secondary headings
--color-ink-700:         #2E3348   // Subheadings, labels
--color-ink-500:         #6B7280   // Secondary text, metadata
--color-ink-300:         #B0B8C8   // Borders, dividers, placeholder text
--color-ink-100:         #E8ECF2   // Input borders, subtle dividers
--color-ink-50:          #F4F6FA   // Page background, subtle fills
--color-white:           #FFFFFF   // Card backgrounds, modals

// Financial State Colors
--color-balance-positive: var(--color-success)    // Positive balance display
--color-balance-zero:     var(--color-ink-500)    // Zero balance
--color-balance-locked:   var(--color-ink-300)    // Locked/read-only balance
```

**Color Usage Rules:**
- Never use `danger` red for neutral Cash-Out amounts — it creates anxiety. Use `ink-900` for standard expenses.
- The emergency color (`#FF6B35`) must only appear in Emergency Wallet contexts. Do not use it elsewhere.
- Success green is the app's primary emotional color — it should dominate the home screen when things are going well.
- Maintain minimum 4.5:1 contrast ratio for all text on backgrounds (WCAG AA).

---

### 4.2 Typography System

#### Font Pairing

| Role | Font | Weights Used | Usage |
|---|---|---|---|
| **Primary (Arabic + Latin)** | Cairo | 300, 400, 500, 600, 700, 900 | All UI text, body, labels |
| **Display / Headings** | Cairo | 700, 900 | Large balance numbers, screen titles |
| **Monospace** | JetBrains Mono | 400, 500 | Transaction IDs, codes, OTP fields |

> **Why Cairo?**  
> Cairo is a Google Font designed specifically for Arabic + Latin bilingual UIs. It handles both scripts with consistent stroke weight and spacing. It's free, renders beautifully at small sizes, and feels modern without being cold. Alternative: IBM Plex Sans Arabic (if more enterprise feel is needed in Phase 2).

#### Type Scale

```
TYPE SCALE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Display (Balance amounts, heroes)
--text-display-xl:   font-size: 48px / line-height: 1.1 / weight: 700
--text-display-lg:   font-size: 36px / line-height: 1.2 / weight: 700
--text-display-md:   font-size: 28px / line-height: 1.3 / weight: 600

// Headings (Screen titles, card headers)
--text-h1:   font-size: 24px / line-height: 1.3 / weight: 700
--text-h2:   font-size: 20px / line-height: 1.4 / weight: 600
--text-h3:   font-size: 17px / line-height: 1.4 / weight: 600

// Body (Descriptions, content)
--text-body-lg:   font-size: 16px / line-height: 1.6 / weight: 400
--text-body-md:   font-size: 15px / line-height: 1.6 / weight: 400
--text-body-sm:   font-size: 14px / line-height: 1.5 / weight: 400

// Labels & UI (Buttons, tags, tabs)
--text-label-lg:   font-size: 16px / line-height: 1.4 / weight: 500
--text-label-md:   font-size: 14px / line-height: 1.4 / weight: 500
--text-label-sm:   font-size: 12px / line-height: 1.4 / weight: 500

// Caption & Meta (Timestamps, secondary info)
--text-caption:    font-size: 12px / line-height: 1.4 / weight: 400
--text-overline:   font-size: 11px / line-height: 1.4 / weight: 500 / letter-spacing: 0.06em / UPPERCASE

// Monospace (Transaction codes, OTP)
--text-mono-md:    font-size: 15px / line-height: 1.5 / weight: 500 / font-family: JetBrains Mono
--text-mono-sm:    font-size: 13px / line-height: 1.5 / weight: 400 / font-family: JetBrains Mono
```

#### Arabic Typography Special Rules

- **Minimum readable size for Arabic:** 14px. Never use Arabic text below 14px in UI — Arabic characters are more complex than Latin and become illegible at small sizes.
- **Line height for Arabic:** Increase to 1.7x for body text (Arabic needs more vertical breathing room due to above/below diacritical marks even when not shown).
- **Arabic numerals in financial context:** Use Western/Latin numerals (`0-9`) throughout the Arabic UI — this is standard in Egyptian fintech and avoids confusion. Eastern Arabic numerals (`٠١٢٣٤٥٦٧٨٩`) may be shown optionally in settings (Phase 2).
- **Font weight:** Arabic typefaces render differently than Latin. Prefer `500` weight for body text instead of `400` — it reads cleaner at mobile sizes.

---

### 4.3 Spacing System

Base unit: **4px**

```
SPACING TOKENS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--sp-1:   4px    // Micro (icon padding, tight rows)
--sp-2:   8px    // Small (inline element gaps)
--sp-3:   12px   // Component internal padding
--sp-4:   16px   // Standard (most padding/gaps)
--sp-5:   20px   // Card padding, section gaps
--sp-6:   24px   // Generous (modal padding, section headers)
--sp-8:   32px   // Large (between major sections)
--sp-10:  40px   // XL (screen vertical padding)
--sp-12:  48px   // XXL (hero areas)
--sp-16:  64px   // Jumbo (splash, empty states)
--sp-20:  80px   // Display (full-screen moments)
```

#### RTL-Aware Spacing Rules

```
// Flutter implementation — ALWAYS use DirectionalProperties
// WRONG:  EdgeInsets.only(left: 16)     ← hardcoded, breaks RTL
// RIGHT:  EdgeInsetsDirectional.only(start: 16)  ← direction-aware

// Common patterns:
// List item icon gutter:     start: 16, end: 12
// Card internal padding:     horizontal: 20, vertical: 20
// Screen horizontal padding: horizontal: 20
// Section gap:               bottom: 32
// Tab bar item padding:      symmetric horizontal: 12
```

---

### 4.4 Border Radius

```
RADIUS TOKENS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

--radius-sm:   6px    // Small tags, chips, badges
--radius-md:   12px   // Input fields, small cards
--radius-lg:   16px   // Buttons (default)
--radius-xl:   24px   // Wallet cards, modals
--radius-2xl:  32px   // Bottom sheets (top corners)
--radius-full: 9999px // Pills, avatars, toggles
```

---

### 4.5 Elevation / Shadows

```
SHADOW TOKENS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Shadow values: offset-x offset-y blur spread color
--shadow-sm:    0 1px 3px rgba(13,15,20,0.06), 0 1px 2px rgba(13,15,20,0.04)
                → Use: Interactive list items, small cards

--shadow-md:    0 4px 16px rgba(13,15,20,0.08), 0 2px 6px rgba(13,15,20,0.05)
                → Use: Input fields (focused), dropdowns

--shadow-lg:    0 12px 40px rgba(13,15,20,0.12), 0 4px 12px rgba(13,15,20,0.07)
                → Use: Modals, bottom sheets, floating elements

--shadow-card:  0 8px 32px rgba(10,110,255,0.10)
                → Use: Wallet cards (tinted to brand)

--shadow-emergency: 0 8px 32px rgba(255,107,53,0.15)
                → Use: Emergency wallet card specifically
```

---

## 5. Localization & RTL Guidelines

> ⚠️ **This section is CRITICAL.** RTL support done wrong is worse than no RTL support. Every rule here must be implemented and tested before shipping to the Egyptian market.

---

### 5.1 Layout Mirroring Rules

#### What FLIPS in RTL (Directional Elements)

| Element | LTR | RTL | Reason |
|---|---|---|---|
| Back button (chevron) | Points left `‹` | Points right `›` | Directional |
| Navigation slide animation | Push from right | Push from left | Reading direction |
| List item layout | Icon ← Label → Amount (left to right) | Amount ← Label → Icon (right to left) | Reading direction |
| Input field icon position | Icon on left | Icon on right | Context start |
| Dropdown/select chevron | Chevron on right | Chevron on left | Context end |
| Progress bar fill | Fills left → right | Fills right → left | Reading direction |
| Swipe actions (list items) | Swipe left to reveal | Swipe right to reveal | Directional |
| Checkmark position in toggle | Left side of label | Right side of label | Reading start |
| Currency suffix/prefix | `1,000 EGP` (suffix) | `ج.م 1,000` (prefix) | Arabic convention |

#### What STAYS FIXED (Non-Directional Elements)

| Element | Stays the Same | Reason |
|---|---|---|
| Numbers | `1,234.50` | Universal notation |
| Wallet card layout | Centered balance | Purely visual |
| Circular icons/avatars | Same position | Not directional |
| Rating stars | Left → right | Universal visual convention |
| Bottom sheet slide direction | Always slides up | Vertical, not horizontal |
| Logos and brand marks | Same orientation | Brand identity |
| Category icons | Same appearance | Pictographic, not directional |
| Clock/time display | `10:30 AM` | Universal time format |
| Calendar date picker | Depends on calendar locale | Use system locale |

---

### 5.2 Text Alignment Rules

```
TEXT ALIGNMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Primary rule: Always align text to its reading direction start
// In Flutter: Use TextAlign.start (not TextAlign.left)

// English (LTR):
  All text → text-align: start  →  appears LEFT-aligned

// Arabic (RTL):
  All text → text-align: start  →  appears RIGHT-aligned

// Exceptions (always centered regardless of language):
  - Balance amounts on wallet cards
  - Screen titles in navigation bar
  - Empty state illustrations + text
  - Onboarding step content
  - OTP digit inputs

// Mixed content rules:
  - A transaction amount inside Arabic sentence:
    → Isolate the number in a separate text span
    → Apply LTR direction to the number span
    → Example: "تم حفظ ‏1,000 ج.م‏ في المحفظة" (use Unicode LTR marks: U+202A / U+202C)
```

---

### 5.3 Number Formatting

**Decision: Use Western Arabic numerals (`0–9`) throughout the entire app — both in LTR and RTL mode.**

**Rationale:** Egyptian users, especially in fintech contexts, are accustomed to Western numerals. Eastern Arabic numerals (`٠١٢٣٤٥٦٧٨٩`) while culturally authentic, cause friction when scanning financial data quickly. This is consistent with how Egyptian banks, Vodafone Cash, and Fawry display amounts.

```
NUMBER FORMATTING RULES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Standard amount format
1,234.50            → Thousands separator: comma (,)
                    → Decimal separator:   period (.)
                    → No trailing zeros for whole amounts: 1,000 (not 1,000.00)
                    → Show 2 decimal places only when non-zero: 1,234.50

// Phone number (Egyptian)
EN: 010 1234 5678
AR: ٠١٠١٢٣٤٥٦٧٨   ← Optional Eastern numerals for phone display only

// Percentage
EN: 20%
AR: %20            ← Percent sign goes to left in RTL (direction of reading end)
    Note: In practice, showing "٪٢٠" or "20%" both acceptable — use "20%" for clarity.

// Date format
EN: 26 Apr 2025        (DD MMM YYYY)
AR: ٢٦ أبريل ٢٠٢٥    (same order — day month year is universal)
    Short: 26/04/2025  → Same format in both languages

// Time
EN: 10:30 AM
AR: 10:30 ص           (ص = صباحاً / م = مساءً)
```

---

### 5.4 Currency Display (EGP)

```
CURRENCY FORMATTING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// English (LTR)
Full:     1,250 EGP
Short:    1.2K EGP       ← Use for compact spaces (K = thousands)
Precise:  1,250.75 EGP

// Arabic (RTL) — currency symbol precedes amount in Arabic convention
Full:     1,250 ج.م
Short:    1.2K ج.م
Precise:  1,250.75 ج.م

// Rules:
// 1. Never show "LE" (old abbreviation) — use "EGP" or "ج.م" only
// 2. Currency code always in same text direction as surrounding text
// 3. In mixed content, the currency value + symbol is treated as one LTR atom
// 4. Zero balance: "0 EGP" (not "EGP 0") — zero has no magnitude direction
// 5. Negative values: -500 EGP (dash before amount, never after)
```

---

### 5.5 Handling Mixed-Language Content

```
MIXED CONTENT RULES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Scenario: Arabic sentence containing English brand name
"محفظة Visa الخاصة بك" → Keep "Visa" in LTR within RTL text
→ Flutter: Use TextSpan with locale override

// Scenario: Arabic sentence with number
"وفّرت 1,000 ج.م تلقائياً" → Number stays Western numerals, LTR direction
→ Wrap number in Unicode LTR marks or use TextSpan

// Scenario: Wallet names in Arabic UI
"Cash" wallet → Display as "كاش" (transliterated) OR "النقدية" (translated)
→ Decision for MVP: Use "كاش" — shorter, familiar to Egyptian youth market
→ "Visa" → stays "فيزا" (transliterated)
→ "Smart Wallet" → "المحفظة الذكية"
→ "Emergency Wallet" → "محفظة الطوارئ"

// Scenario: App store / external brand names in Arabic UI
→ Keep in original English: "Vodafone Cash", "Fawry"
→ Never translate brand names
```

---

### 5.6 Font Recommendations for Arabic Readability

| Font | Recommendation | Best For | License |
|---|---|---|---|
| **Cairo** ⭐ Primary | Excellent bilingual support, modern feel | All UI text, labels, body | Open Font License (Google Fonts) |
| **IBM Plex Sans Arabic** | Professional, enterprise feel | Future enterprise version | Open Font License |
| **Noto Sans Arabic** | Google's universal Arabic support | Fallback/system font | Open Font License |
| **Tajawal** | Slightly more informal, round | Alternative to Cairo | Open Font License |

> **Do NOT use:** Droid Arabic Naskh (too traditional), Scheherazade (too decorative), or any Arabic Naskh-style for UI — they have low readability at small sizes.

---

## 6. Visual Language

### 6.1 Style Direction

**Style:** Financial Minimalism with Warm Personality

This is not a cold banking interface. It's a personal financial companion. The visual language should feel:
- **Clean:** White space is not wasted space — it communicates calm and control.
- **Warm:** Rounded corners, gradient-touched cards, organic spacing.
- **Trustworthy:** Consistent color usage, no visual noise, predictable layouts.
- **Human:** Friendly illustrations in empty states, encouraging microcopy, no corporate jargon.

**Design Do's:**
- Generous white space between sections
- Wallet cards with subtle gradient overlays (not flat — money feels premium)
- Consistent corner rounding throughout (no mixing sharp and round in the same view)
- Animation for positive financial events (money saved = celebration micro-animation)

**Design Don'ts:**
- No stock photography (too generic, breaks trust)
- No complex data visualizations in MVP (charts come in Phase 2)
- No dark/red color schemes as default — this is aspirational, not a warning sign
- No cluttered dashboards — maximum 4 wallet cards + 3 recent transactions on home

---

### 6.2 Iconography Rules

**Icon Style:** Rounded, filled icons (not outline). Filled icons test better at small sizes on mobile and feel more decisive — appropriate for financial action icons.

**Recommended Icon Library:** Material Symbols (Rounded variant) or custom set built on same grid.

**Icon Sizing:**

| Context | Icon Size | Touch Target |
|---|---|---|
| Tab bar | 24×24px | 44×44px |
| Wallet card header | 28×28px | N/A (decorative) |
| List item category | 20×20px | Within 40×40px row |
| Button icon | 20×20px | Within button |
| Input field icon | 20×20px | 40×40px tap zone |
| Notification icon | 16×16px | N/A |

**RTL Icon Mirroring Rules:**

Directional icons MUST flip in RTL. Non-directional icons stay the same.

| Icon | Flips in RTL? | Reason |
|---|---|---|
| Back arrow `←` | ✅ YES → `→` | Directional |
| Forward arrow `→` | ✅ YES → `←` | Directional |
| Share icon | ✅ YES | Contains directionality |
| Chevron/caret `›` | ✅ YES | Navigation direction |
| Send/submit arrow | ✅ YES | Message direction |
| Wallet/card icon 💳 | ❌ NO | Pictographic |
| Checkmark ✓ | ❌ NO | Symbolic |
| Shield 🛡️ | ❌ NO | Symbolic |
| Warning ⚠️ | ❌ NO | Symbolic |
| Plus / Minus ± | ❌ NO | Mathematical |
| Category icons (food, transport) | ❌ NO | Pictographic |
| Person/profile icon | ❌ NO | Pictographic |
| Filter icon | ❌ NO | Symmetric |

---

### 6.3 Wallet Differentiation System

Each wallet has a complete visual identity system:

| Wallet | Color | Icon | Card Style | Personality |
|---|---|---|---|---|
| **Cash** | `#00C48C` (Green) | Banknote 💵 | Solid green gradient | Primary, accessible, everyday |
| **Visa** | `#0A6EFF` (Blue) | Credit card 💳 | Solid blue gradient | Formal, digital, institutional |
| **Smart Wallet** | `#9B5CFF` (Purple) | Smartphone 📱 | Solid purple gradient | Modern, mobile-first |
| **Emergency** | `#FF6B35` (Orange) | Shield 🛡️ | Textured / special treatment | Protected, serious, valuable |

**Emergency Wallet Special Visual Treatment:**
- Card has a subtle "DO NOT TOUCH" visual metaphor — either a lock icon overlay, a dashed border, or a slightly different card texture.
- Balance number displays in orange instead of white (to visually separate from regular wallets).
- "Protected" badge in top-right corner.
- When locked (non-salaried user): entire card desaturates to gray, lock icon prominently shown.

---

## 7. Behavior & Interaction Rules

### 7.1 Auto-Save Feedback (20% Emergency Rule)

When the user logs a salary Cash-In with the Salary Toggle activated, this is the most important positive financial moment in the app. It deserves a multi-step celebration:

**Step 1: Immediate UI Response (< 100ms)**
- The Cash-In form submits successfully.
- Wallet balance shows updating animation (number counts up with subtle motion).

**Step 2: Auto-Save Confirmation Sheet (300ms after submit)**
- Bottom sheet slides up.
- Shows split: "4,000 EGP → Cash wallet | 1,000 EGP → Emergency Wallet 🛡️"
- Confetti or checkmark animation (subtle, not childish).
- Single CTA: "Great, Got It"

**Step 3: Home Screen Update**
- Return to home screen.
- Emergency Wallet card glows briefly (500ms glow pulse) to draw attention.
- Both wallet balances show updated amounts.

**Step 4: Push Notification (async)**
- Sent via FCM.
- Template: "✅ 1,000 EGP saved to your Emergency Wallet. Your future self will thank you."

---

### 7.2 Error Handling

**Principles:**
1. Errors must explain **what went wrong** AND **how to fix it**.
2. Never show technical error codes to users (no "Error 422" in the UI).
3. Network errors should suggest a retry — not punish the user.
4. Validation errors appear inline (below the field) — never as full-screen errors.

**Error Display Patterns:**

| Error Type | Display Method | Duration |
|---|---|---|
| Field validation | Inline below field (red text + icon) | Until corrected |
| Form submission fail | Inline banner at top of form | Until dismissed or retry |
| Network error | Full-screen empty state with retry CTA | Until resolved |
| Permission denied | Contextual in-flow explanation | Until addressed |
| Emergency cashout blocked | Bottom sheet modal | User-dismissed |

---

### 7.3 Empty States

Every empty state must contain:
1. An illustration (simple, warm, not clipart)
2. A clear headline (what's empty)
3. A brief explanation (why it's empty / what to do)
4. An action CTA (what to do next)

| Screen | Headline (EN) | Headline (AR) | CTA |
|---|---|---|---|
| Transaction History — No transactions | "Nothing logged yet" | "لا يوجد سجل بعد" | "Log Your First Transaction" |
| History — Filter returns empty | "No results found" | "لا توجد نتائج" | "Clear Filters" |
| Emergency Wallet — Locked | "Activate Your Safety Net" | "فعّل شبكة أمانك" | "Set Up Salary Profile" |
| Emergency Wallet — Zero balance | "Start Building Your Safety Net" | "ابدأ بناء طوارئك" | "Log Your Salary" |

---

### 7.4 Locked Feature UX (Non-Salaried Users)

**Philosophy:** Never punish or shame users for not having a stable salary. The locked state should feel like an invitation, not a rejection.

**Emergency Wallet — Locked State Display:**
- Wallet card shows with lock icon (🔒) and desaturated orange color.
- Tapping the card opens an explanation sheet (not an error):

```
Bottom Sheet Content:
Title:   "Unlock Your Emergency Wallet"
Body:    "This feature is designed for users with a stable monthly salary.
          If your situation changes, you can activate it anytime in your profile."
CTA:     "Set Up Salary Profile"
Link:    "I don't have a stable salary right now" (dismisses)
```

- The "I don't have a stable salary" option must always be visible and tappable — no trapping users in an upsell loop.

---

### 7.5 RTL Animation Direction

```
ANIMATION DIRECTION RULES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Screen Navigation Transitions
LTR: New screen slides in from RIGHT  → exits to LEFT
RTL: New screen slides in from LEFT   → exits to RIGHT

// Modal / Overlay Entrances
Bottom Sheet:   Always slides UP regardless of language direction
Alert/Toast:    Slides in from TOP regardless of direction
Snackbar:       Appears at BOTTOM center, no directional slide

// List Item Interactions
LTR: Swipe LEFT to reveal delete/actions
RTL: Swipe RIGHT to reveal delete/actions

// Progress / Loading
LTR: Progress fills LEFT → RIGHT
RTL: Progress fills RIGHT → LEFT

// Toggle/Switch
Both: Thumb moves LEFT (off) → RIGHT (on) in LTR
      Thumb moves RIGHT (off) → LEFT (on) in RTL
      (Follows natural "sliding into active state" direction)

// Auto-save confetti / celebration animation
→ Direction-neutral: particles explode from center outward
→ No directional bias needed

// Shake animation (validation error)
→ Horizontal shake stays horizontal regardless of language
→ Amplitude: ±8px, 3 cycles, 300ms

// Flutter implementation note:
→ Use Directionality.of(context) to check TextDirection
→ Multiply x-axis translation by (isRTL ? -1 : 1)
```

---

## 8. Accessibility

### 8.1 Contrast Requirements

All text must meet **WCAG AA minimum** (4.5:1 for body text, 3:1 for large text/icons).

**Critical financial data must meet WCAG AAA** (7:1) where possible — users need to read balance amounts accurately.

| Text / Background Combination | Contrast Ratio | Passes AA? | Passes AAA? |
|---|---|---|---|
| `ink-900` on `white` | 19.1:1 | ✅ | ✅ |
| `white` on `primary` (#0A6EFF) | 4.7:1 | ✅ | ❌ |
| `white` on `success` (#00C48C) | 3.1:1 | ⚠️ Large text only | ❌ |
| `white` on `emergency` (#FF6B35) | 3.5:1 | ⚠️ Large text only | ❌ |
| `ink-500` on `white` | 5.2:1 | ✅ | ❌ |
| `primary` on `primary-light` | 5.8:1 | ✅ | ❌ |
| `danger` on `danger-light` | 5.1:1 | ✅ | ❌ |

> **Note for Wallet Cards:** White text on colored backgrounds (green, blue, purple, orange) only meets WCAG AA at large text sizes. The balance amount (32px+ bold) qualifies as large text and passes. For any body text on colored card backgrounds, use white with `font-weight: 600` minimum.

---

### 8.2 Touch Targets

```
TOUCH TARGET RULES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Minimum: 44×44px (Apple HIG) / 48×48dp (Material Design)
// Recommended: 48×48px for all interactive elements

// Specific rules:
Primary buttons:      Full width, 56px height               ✅ Passes
Secondary buttons:    Full width, 48px height               ✅ Passes
Icon buttons:         40×40px visual + 8px invisible padding ✅ Passes (48×48 total)
Tab bar items:        Full tab width × 50px height          ✅ Passes
Checkbox/toggle:      48×48px tap zone minimum              ✅ Passes
Transaction list items: Full width × 72px height            ✅ Passes
Category chips:        min 80px wide × 40px height          ✅ Passes
Filter chips:          min 80px wide × 36px height          ⚠️ Borderline — pad to 44px

// RTL note: Touch targets do not change size in RTL.
// Only their position may mirror. Size must remain constant.
```

---

### 8.3 Screen Reader Support

```
SCREEN READER RULES (Flutter Semantics)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

// Wallet Cards
→ Semantics label: "Cash Wallet, balance 1,250 Egyptian Pounds"
→ Arabic: "محفظة الكاش، الرصيد ألف ومئتان وخمسون جنيهاً مصرياً"
→ NEVER read out raw numbers: "1,250" → read as words

// Transaction Items
→ "Cash out, Food and Breakfast, 150 Egyptian Pounds, today at 2:30 PM"
→ Do NOT include GPS coordinates in screen reader output

// Emergency Wallet Locked
→ "Emergency Wallet, locked, tap to learn how to activate"

// Salary Toggle
→ "Salary checkbox, unchecked. Checking this will automatically save 20% to Emergency Wallet"

// Amount Input Field
→ Announce current value + field purpose + constraints
→ "Amount field, currently 500 pounds, enter amount in Egyptian Pounds"

// Error States
→ Always announce errors immediately when they appear
→ Error message must be linked to its field via semanticsLabel
```

---

### 8.4 Arabic Text Readability Specific Rules

- Minimum Arabic body text size: **14px** (as noted in typography section)
- Arabic Tashkeel (diacritical marks) are NOT used in the app — they add visual complexity with no benefit for UI text.
- Line height for Arabic: **1.7** (vs 1.6 for Latin) to prevent character cramping.
- Avoid ALL CAPS for Arabic text — there is no uppercase in Arabic script. UPPERCASE_STYLE should only apply to Latin text.
- Arabic text should never be letter-spaced (`letter-spacing: 0`) — Arabic characters are connected and spacing breaks them.

---

## 9. Microcopy Guidelines (Bilingual)

### 9.1 Tone Principles

| Principle | What it means | Example (Wrong) | Example (Right) |
|---|---|---|---|
| **Clear** | Say exactly what happened | "Transaction processed" | "1,500 EGP added to Cash wallet" |
| **Supportive** | Be on the user's side | "Insufficient funds" | "You need a bit more — current balance is 200 EGP" |
| **Non-judgmental** | Never shame spending | "Excessive spending detected" | "You spent 800 EGP on Food this week" |
| **Human** | Avoid robotic language | "Operation completed successfully" | "Done! Your balance is updated." |
| **Concise** | Fewer words = faster understanding | "Please be advised that your emergency wallet transaction has been blocked" | "Emergency funds are protected right now" |

---

### 9.2 Emergency Wallet Messages

| Situation | English | Arabic |
|---|---|---|
| Auto-save success | "✅ 1,000 EGP moved to your Emergency Wallet." | "✅ تم نقل 1,000 ج.م إلى محفظة الطوارئ." |
| Cashout blocked (funds available) | "You still have 320 EGP in other wallets. Emergency fund stays protected." | "لديك 320 ج.م في محافظك الأخرى. محفظة الطوارئ محمية." |
| Cashout allowed (funds low) | "Your other wallets are nearly empty. You can access emergency funds." | "محافظك الأخرى شبه فارغة. يمكنك الوصول لأموال الطوارئ." |
| Withdrawal confirmed | "Emergency funds used. Rebuild when you're ready 💪" | "تم استخدام أموال الطوارئ. أعد بناءها متى استطعت 💪" |
| Wallet locked (no salary) | "Set up your salary profile to unlock this feature." | "أضف راتبك لتفعيل هذه الميزة." |
| Zero balance prompt | "Start building your safety net — log your salary to begin." | "ابدأ ببناء شبكة أمانك — سجّل راتبك لتبدأ." |
| Confirmation dialog title | "Use Emergency Funds?" | "استخدام أموال الطوارئ؟" |
| Confirmation dialog body | "This withdraws from your savings. Are you sure you need this right now?" | "سيتم خصمه من مدخراتك. هل أنت متأكد أنك تحتاجه الآن؟" |

---

### 9.3 Error Messages

| Error | English | Arabic |
|---|---|---|
| Amount field empty | "Please enter an amount." | "أدخل المبلغ أولاً." |
| Amount = zero | "Amount must be greater than zero." | "المبلغ لازم يكون أكبر من صفر." |
| Wallet not selected | "Select a wallet first." | "اختار المحفظة أولاً." |
| Category not selected | "Pick a spending category." | "اختار فئة الصرف." |
| Network error | "Can't connect right now. Your data is safe — try again." | "مش قادر يتصل دلوقتي. بياناتك بأمان — حاول تاني." |
| Phone number invalid | "Enter a valid Egyptian phone number (e.g., 010 1234 5678)." | "أدخل رقم مصري صحيح (مثلاً: 010 1234 5678)." |
| OTP incorrect | "That code isn't right. Try again or request a new one." | "الكود غلط. حاول تاني أو اطلب كود جديد." |
| OTP expired | "This code has expired. Request a new one." | "الكود انتهت صلاحيته. اطلب كود جديد." |
| Balance goes negative | "This would leave [wallet] at -X EGP. Adjust the amount." | "ده هيخلي المحفظة ناقص X ج.م. عدّل المبلغ." |

---

### 9.4 Notifications (Push Copy)

| Trigger | Title (EN) | Body (EN) | Title (AR) | Body (AR) |
|---|---|---|---|---|
| Auto-save completed | "Emergency fund updated 🛡️" | "[Amount] EGP saved automatically. You're building something real." | "تحديث محفظة الطوارئ 🛡️" | "تم حفظ [المبلغ] ج.م تلقائياً. أنت تبني شيئاً حقيقياً." |
| Emergency fund used | "Emergency funds accessed ⚠️" | "[Amount] EGP withdrawn. Rebuild when you're able." | "تم الوصول لأموال الطوارئ ⚠️" | "تم سحب [المبلغ] ج.م. أعد بناءها متى استطعت." |
| Daily reminder | "Quick check-in 💰" | "Did anything move today? Keep your balances up to date." | "تسجيل سريع 💰" | "في حاجة اتحركت النهارده؟ خلّي رصيدك محدَّث." |
| Low emergency fund | "Safety net getting thin 🔄" | "Your emergency fund is below 500 EGP. Time to rebuild." | "شبكة الأمان بتضعف 🔄" | "محفظة الطوارئ تحت 500 ج.م. حان وقت إعادة البناء." |

---

### 9.5 Empty States

| Screen | Title (EN) | Body (EN) | Title (AR) | Body (AR) |
|---|---|---|---|---|
| No transactions | "Nothing here yet" | "Your first transaction is one tap away." | "لا يوجد سجل بعد" | "معاملتك الأولى على بُعد نقرة واحدة." |
| No filter results | "No matches found" | "Try different filters or date range." | "لا توجد نتائج" | "جرّب فلاتر مختلفة أو نطاق زمني آخر." |
| Emergency wallet — zero | "Your safety net is empty" | "Log your salary to automatically start saving 20%." | "شبكة أمانك فارغة" | "سجّل راتبك لتبدأ في توفير 20% تلقائياً." |
| Locked emergency wallet | "Your Emergency Wallet is waiting" | "Set up your salary profile to activate automatic savings." | "محفظة طوارئك في انتظارك" | "أضف راتبك لتفعيل التوفير التلقائي." |

---

## 10. Edge Cases

### 10.1 Low Balance Scenarios

| Scenario | Balance State | UI Response |
|---|---|---|
| All wallets at zero | Cash=0, Visa=0, Smart=0 | Total shows "0 EGP" in `ink-500` color (not red — zero is neutral, not an error) |
| Single wallet at zero | One wallet = 0 | Card shows "0 EGP" with subtle empty state style (dashed border hint) |
| User tries to cash-out more than available | Amount > wallet balance | Inline error: "Only [X] EGP available in this wallet" + highlight the balance |
| Emergency wallet below 500 EGP | < 500 EGP | Yellow warning badge on Emergency card. Push notification triggered (once per threshold cross). |
| Emergency wallet at zero after withdrawal | = 0 | Empty state on card + encouraging copy to rebuild |

**Rule:** Never show a negative balance in the UI under any circumstances. The Cash-Out form must validate amount ≤ available balance before allowing submission. Error shown inline, not after submission.

---

### 10.2 Emergency Wallet Restrictions

| Scenario | System Behavior | User Sees |
|---|---|---|
| Other wallets total > 50 EGP | Block cashout | Warning bottom sheet, offer to use other wallets |
| Other wallets total ≤ 50 EGP | Allow cashout with confirmation | Confirmation dialog before proceeding |
| Non-salaried user taps Emergency card | Show locked state explanation | Invitation to set up salary profile |
| Salaried user, no salary logged yet | Emergency wallet exists but is 0 EGP | Empty state + "Log your salary to start saving" |
| User tries to manually edit Emergency balance | Block action | No edit UI shown — balance is read-only by design |
| Emergency wallet auto-save would make wallet negative | Block auto-save | Show warning: "Not enough in [wallet] to save 20%. Amount saved: [X] EGP instead." Partial save only. |

**Edge case — Partial Auto-Save:**
If user logs salary of 300 EGP but Cash wallet already has a negative hypothetical scenario (shouldn't happen — see validation rule), the system should:
1. Save what it can (floor to available amount after 20% threshold).
2. Notify user of partial save with explanation.
3. Never leave wallets in an inconsistent state.

---

### 10.3 Missing Permissions (Location)

**Design philosophy:** Location is a feature enhancement, not a requirement. The app must work fully without it.

| State | User Action | App Response |
|---|---|---|
| Location never requested | First transaction log | Show system permission prompt with pre-explanation card |
| Permission denied | Any transaction log | Log transaction without location. No blocking error. Show inline note: "Location not available — transaction logged without it." |
| Permission permanently denied | User returns to app | Never ask again. Silently log without location. Location column shows "—" in history. |
| Location unavailable (GPS off) | Transaction log attempted | Same as denied — log without location, no friction. |

**Pre-explanation card (shown before system permission dialog):**

```
EN: "Add location to your transactions?
     Helps you remember where you spent. Optional and stored only on your device."
     [Allow Location]   [Skip]

AR: "إضافة الموقع لمعاملاتك؟
     يساعدك تتذكر أين صرفت. اختياري ومحفوظ على جهازك فقط."
     [السماح بالموقع]   [تخطي]
```

---

### 10.4 Language Switching Mid-Session

**Behavior Rules:**

| Action | System Response |
|---|---|
| User switches EN → AR in Profile Settings | App relaunches current screen in RTL. No data loss. |
| Language change on form screen | Alert user: "Changing language will reload this screen. Your unsaved entry will be lost." + [Continue] [Cancel] |
| Number/date display after switch | All numbers remain Western numerals regardless of language. Dates update to Arabic month names. |
| Keyboard language | App does not control keyboard language — system keyboard changes by user. App text fields accept both. |
| App restart after language switch | Language preference persisted locally. App opens in last-selected language. |
| RTL layout takes effect | Immediately on switch — no need to restart the full app. Use Flutter's `Directionality` widget at root. |

**Technical Note (Flutter):**
```dart
// Wrap MaterialApp with locale-reactive widget
// Store language preference in SharedPreferences
// Use flutter_localizations package for system strings
// All custom strings via ARB files: app_en.arb + app_ar.arb
// Directionality determined by Locale('ar') → TextDirection.rtl
```

**Language Toggle Location:** Profile/Settings screen → top section. Label: "Language / اللغة" showing both simultaneously so user always knows where to find it regardless of current language.

---

## Appendix A: Flutter Implementation Reference

```dart
// Design Token Usage Examples
// ════════════════════════════════════════

// Colors
Colors — reference ThemeData extension:
AppColors.primary       // #0A6EFF
AppColors.emergency     // #FF6B35
AppColors.walletCash    // #00C48C

// Spacing — use DirectionalEdgeInsets for RTL safety
EdgeInsetsDirectional.only(start: 20, end: 20)  // horizontal padding
EdgeInsetsDirectional.only(start: 16)             // list item start padding

// Typography
AppTextStyles.displayLg   // 36px / w700 / Cairo
AppTextStyles.bodyMd      // 15px / w400 / Cairo  
AppTextStyles.labelMd     // 14px / w500 / Cairo

// RTL Direction Check
bool isRTL = Directionality.of(context) == TextDirection.rtl;

// Mirror animation direction:
SlideTransition(
  position: Tween<Offset>(
    begin: Offset(isRTL ? -1.0 : 1.0, 0),  // Slide from opposite side
    end: Offset.zero,
  ).animate(animation),
  child: child,
)
```

---

## Appendix B: Component Checklist (Engineering Sign-off)

Before any component ships, it must pass these checks:

- [ ] Renders correctly in LTR (English)
- [ ] Renders correctly in RTL (Arabic)
- [ ] All text uses `TextAlign.start` (not `.left`)
- [ ] All spacing uses `EdgeInsetsDirectional` (not `EdgeInsets`)
- [ ] All directional icons flip correctly in RTL
- [ ] Navigation animations reverse direction in RTL
- [ ] Minimum touch target 44×44px met
- [ ] Contrast ratio ≥ 4.5:1 for body text
- [ ] Screen reader semantics label defined
- [ ] Empty state defined
- [ ] Error state defined
- [ ] Loading state defined
- [ ] Bilingual microcopy reviewed and approved

---

*Emergency Cash Design System v1.0 — Prepared by Saramji | Last Updated: MVP Draft*  
*This document is a living specification. Updates will be versioned and communicated to all team members.*
