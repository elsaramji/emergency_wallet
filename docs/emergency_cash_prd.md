# Product Requirements Document: Emergency Cash

**Product Name:** Emergency Cash  
**Status:** Active MVP (Phase 1.0 Completed)  
**Version:** 1.1  
**Target Platform:** Mobile-First (iOS & Android)  

---

## 1. Product Overview

### 1.1 Brief Description
**Emergency Cash** is a personal finance companion app designed to build financial resilience. It lets users track cash flow across three common wallet types (Cash, Visa, and Smart Wallets) and automatically enforces an **automated savings rule** on stable salary income. The app does not handle real custody of funds. Instead, it serves as a smart financial guardrail and tracking tool, keeping emergency savings isolated and locked behind logical barriers to prevent impulse spending.

### 1.2 Target Audience
* **Primary (Salaried Employees):** Stable monthly income earners who struggle to build a consistent savings buffer. They require an automated, hands-off mechanism to secure their savings before they spend it.
* **Secondary (Freelancers & Gig Workers):** Irregular income earners who need a multi-wallet tracking system to view their total liquidity, even if the automatic saving rules are locked or configured differently.

### 1.3 Core Philosophy & Design Principles
1. **Friction by Design:** Impulse buying thrives on convenience. By placing the emergency fund behind verification checks (restricting access unless other active balances are depleted), we introduce deliberate friction that shields users from their own spending habits.
2. **Untouchable Status:** The Emergency Wallet balance is excluded from all "Total Balance" summaries on the dashboard to build a mental model that this money is not part of disposable income.
3. **Simplicity Over Complexity:** Focus on high-frequency manual logs rather than heavy automated bank sync integrations. The tracking must feel as fast and simple as a notebook.

---

## 2. Onboarding & Dynamic Profile Setup

### 2.1 First-Launch Language Selection
To cater to the regional focus (primarily Egypt and the MENA region), the first screen a user sees on cold launch is a **Language Selection Slide** offering:
* **English (LTR)**
* **Arabic (RTL)**

This choice dynamically updates the interface layout and typography before onboarding slide presentation.

### 2.2 Onboarding Slide Deck
Following language selection, a swipeable three-slide onboarding flow outlines the key pillars of the application:
1. **Track Your Money:** View all Cash, Visa, and Smart Wallet balances in a single unified place.
2. **Emergency Auto-Save:** Automatically save a customizable percentage of your stable salary directly to a locked Emergency Wallet.
3. **Financial Resilience:** Build a dedicated, secure financial buffer for unexpected life events.

Once viewed, this state is saved locally via `AppCubit` so returning users bypass this flow directly to login.

### 2.3 Interactive Welcome survey (Stepper)
Upon successful registration, the user is guided through an interactive setup stepper to configure their financial profile. The stepper adapts dynamically:

```
[Start Setup] -> Choose Employment Status
                         |
             Do you have a stable monthly salary?
              /                             \
          [Yes]                             [No]
           /                                   \
1. Input Salary Amount                   1. Read info about disabled auto-save
2. Configure Savings Rate                2. Proceed directly to starting balances
   (Select or set custom percentage)     3. Complete setup
3. Opt-in/Activate Emergency Wallet
4. Success Activation
5. Set Starting Balances
```

#### Salaried Path (6 steps)
1. **Employment Type:** Choose primary occupation (Employee, Freelancer, Student).
2. **Stable Salary:** Select "Yes, I do" (declaring stable monthly income).
3. **Salary Input:** Input monthly salary in EGP.
4. **Savings Configuration & Activation:** Choose the emergency savings rate. The user can select from predefined values (10%, 15%, 20% [Default/Recommended], 25%) or enter a custom saving value (e.g., 5% to 50%). Details opt-in and auto-deduction behavior.
5. **Success Activation:** Visual lock screen confirmation ("Emergency Wallet Ready").
6. **Starting Balances:** Enters initial balances for Cash, Visa, and Smart Wallet.

#### Non-Salaried Path (4 steps)
1. **Employment Type:** Choose primary occupation (Freelancer or Student).
2. **Stable Salary:** Select "No, my income varies".
3. **Activation Feedback:** Educational step detailing why the automated savings engine is disabled, along with guidance that they can manually toggle this later in their profile settings.
4. **Starting Balances:** Enters starting balances for Cash, Visa, and Smart Wallet.

---

## 3. Core Features

### 3.1 User Authentication & Security
To protect user financial data, authentication is mandatory before accessing dashboard functions:
* **Registration & Credentials:** Users can register using full name, email, and password. Validation enforces secure password constraints (at least 6 characters) and email formatting.
* **Social Authentication:** Integrates Google Social Authentication for quick, low-friction access.
* **Forgot Password Flow:** A self-service recovery page where users enter their registered email to receive a password reset link.
* **Session Persistence:** Authenticated sessions are securely persisted. Users are not prompted to log in on subsequent launches unless they explicitly log out.

### 3.2 Multi-Wallet Dashboard
The home screen serves as the user's primary workspace, tracking four distinct wallet categories:
1. **Cash:** Physical cash in hand.
2. **Visa:** Bank card accounts.
3. **Smart Wallet:** Mobile wallets (e.g., Vodafone Cash, Fawry).
4. **Emergency Wallet:** Locked savings (read-only balance, managed via transactions).

* **Dashboard Features:**
  * **Balance Privacy Toggle:** An eye icon in the header allows users to hide/reveal all wallet balances on the screen instantly, preventing prying eyes in public spaces.
  * **Total Balance Calculation:** Formulated as `Total Balance = Cash + Visa + Smart Wallet`. The Emergency Wallet balance is deliberately excluded from this sum.

### 3.3 Selectable & Customizable Auto-Save Engine
* **The Logic:** When a salaried user logs an incoming cash-in transaction and flags it as salary (via the "This is my salary" checkbox), the auto-save engine applies the user's configured savings rate.
* **Selectable Savings Rate:**
  * **Predefined Options:** Users can easily select a standard savings rate (10%, 15%, 20% [Default/Recommended], or 25%).
  * **Custom Value Option:** Users can set a custom saving value (e.g., any value from 5% to 50%) to suit their specific budget bounds.
* **Management:** The savings percentage can be adjusted at any time in the **Profile Settings** under "Emergency Rule."
* **Flow:** The system deducts the selected saving value from the logged amount, adding the remainder to the target wallet, and moves the saved amount directly into the Emergency Wallet, showing a confirmation notification.

### 3.4 Unified Transaction Logging
Transactions are logged via a single, interactive modal bottom sheet rather than separate pages:
* **Inputs:** Amount (EGP), destination/source Wallet, and optional notes (up to 100 characters).
* **Category Chips:** Dynamic lists of category options based on transaction type:
  * **Cash-In (Income):** Salary, Deposit, Debts, Fees, KPIs, Others.
  * **Cash-Out (Expenses):** Food, Transport, Shopping, Health, Entertainment, Credits, Debts, Fees, Others.

### 3.5 Emergency Wallet Access & "Crisis Rule"
* **The Constraint:** Users cannot freely withdraw funds from the Emergency Wallet. A validation rule checks if the user is in a genuine cash crunch.
* **The Rule:** Cash-outs from the Emergency Wallet are blocked if the combined total of the user's active wallets (Cash + Visa + Smart Wallet) is **equal to or greater than 50 EGP**.
* **UI Feedback:** Tapping the Emergency Wallet chip when active balances are above 50 EGP displays a warning message: *"Emergency Wallet cash out is only available when other balances are below 50 EGP."*
* **Developer Simulator:** A developer tool toggle—**"Simulate Low Balance (< 50 EGP)"**—is built directly into the transaction form dialog. This overrides the real wallet state with mock low balances (e.g., 15 EGP Cash, 15 EGP Visa, 10 EGP Smart Wallet) to facilitate testing of the Emergency Wallet cashout flow.

### 3.6 Calendar-Based History View
Provides an aggregate monthly overview of user transactions organized in a grid layout:
* **Year Selector:** Header buttons to navigate between calendar years.
* **Month Grid:** A 12-month calendar grid showing month cards categorized as:
  * **Active:** Shows the number of recorded logs (e.g., "5 operations"). Selectable by the user.
  * **Inactive:** Displays "No activity". Disabled.
  * **Upcoming:** Future months relative to the current calendar time (mocked to May 2026). Disabled.
* **Transaction Bottom Sheet:** Selecting an active month opens a sliding sheet listing all transactions for that month sorted by date (newest first). Each entry displays the transaction type, category badge, amount, source wallet, and notes.

### 3.7 Financial Insights
Provides immediate feedback on monthly cash flow and saving performance:
* **Locked Emergency Status Card:** Highlighting the current total saved and auto-save active state.
* **Categorized Spending Breakdown:** Shows expense weight percentages via visual progress bars.
* **MoM KPI Comparison:** Illustrates savings rate changes relative to the prior month (e.g. *"Savings Rate: You saved 12% more than last month"*).

---

## 4. Technical Architecture & Handoff Notes

### 4.1 System Architecture
The application is built using a highly modular, decoupled structure:
* **Clean Architecture Layers:** Strictly isolated into `domain` (contracts & entities), `data` (mappers, schemas, and remote source integrations), and `presentation` (widgets and states).
* **State Management:** Powered by `flutter_bloc` using Cubits (e.g., `WelcomeCubit`, `DashboardCubit`, `HistoryCubit`, and `AppCubit`).
* **Dependency Injection:** Configured via `get_it` and annotation-driven class registration (`injectable`), initializing services during app launch before `runApp()`.
* **Responsive Layout:** Responsive dimensions use `.w`, `.h`, `.r`, and `.sp` extensions from `flutter_screenutil`.
* **Bilingual Localization:** Fully localized via `.arb` asset catalogs, with localized strings accessed through the context extension `context.local.[key]`.

### 4.2 Data Storage & Firebase Integration
* **Authentication:** Integrates email/password credentials alongside Google Social Authentication.
* **Firestore Schema:** Designed around a twin-structure storage pattern:
  * A flat `transactions` subcollection under the user document for fast recent reads and real-time logs.
  * A month-bucketed `transactionHistory` collection (e.g., `/users/{uid}/transactionHistory/2026-05/entries`) for performant calendar grids and aggregated monthly analytics without querying all historical logs.
  * Writes to both collections are bundled in a atomic batch operation to ensure consistency.

For detailed schema designs, refer to the [Go To Project Wiki](https://github.com/elsaramji/emergency_wallet/wiki)

---

## 5. Excluded / Out-of-Scope (MVP Phase)
To optimize delivery speed, the following items are excluded from the MVP scope:
1. **Open Banking / Automated Financial APIs:** No sync connections to physical bank accounts or digital services (e.g., InstaPay); all logs are entered manually.
2. **Advanced Budget Planning:** Goal tracking or category-specific spending caps.
3. **Data Portability:** Export options to CSV or PDF formats.
