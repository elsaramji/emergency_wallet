# **📄Emergency Cash (PRD)**

## **Emergency Cash — MVP v1.0**

**Document Version:** 1.0 **Status:** Draft **Prepared by:** Saramji — Junior Product Owner  
---

## **1\. Product Overview**

### **1.1 Brief Description**

**Emergency Cash** is a personal finance mobile application designed to help users track their money across multiple wallet types (Cash, Visa, Smart Wallet), and automatically enforce an **emergency savings rule** to ensure financial resilience during unexpected life events.  
The app is **not** a bank. It is a **smart money awareness tool** with a built-in behavioral savings mechanism.

### **1.2 Target Users**

| Segment | Description |
| ----- | ----- |
| **Primary** | Salaried employees (stable monthly income) aged 22–45 |
| **Secondary** | Freelancers or irregular-income users (limited feature access) |
| **Geography** | MENA region — Egypt focus for MVP |

### **1.3 Core Problem Being Solved**

**"Most people don't fail to earn money — they fail to protect it when it matters most."**  
Users currently have **no single place** to:

* See their total liquid money across all wallet types  
* Enforce a savings habit automatically  
* Access emergency funds with clear, rule-based logic

Existing apps (like Mint or MoneyFellows) either lack multi-wallet tracking, don't have an emergency layer, or are too complex for daily use.  
---

## **2\. Goals & Objectives**

### **2.1 Business Goals**

* Achieve **1,000 active users** within 60 days post-launch (MVP validation metric)  
* Validate that users **consistently log transactions** (retention \> 3 sessions/week)  
* Confirm that the **Emergency Wallet feature** is the primary reason users stay (via in-app survey)

### **2.2 User Goals**

* Know **exactly how much money they have** across all wallets at any moment  
* Have a **"do not touch" emergency fund** that builds automatically  
* Understand **where their money is going** through categorized spending

### **2.3 MVP Success Criteria**

| Metric | Target |
| ----- | ----- |
| Daily Active Log Rate | ≥ 60% of registered users log at least 1 transaction/day |
| Emergency Wallet Activation | ≥ 70% of salaried users activate emergency wallet |
| 30-Day Retention | ≥ 40% |
| Emergency Cashout Usage | At least 1 real cashout event logged within 30 days |

---

## **3\. Core Features (MVP Only)**

---

### **Feature 1: User Registration & Financial Profile Setup**

**Description:** During onboarding, the system collects the minimum required data to configure the user's financial behavior — specifically whether they have a **stable salary**, which determines Emergency Wallet eligibility.  
**User Stories:**

* *As a new user, I want to register quickly with minimal steps, so that I can start using the app without friction.*  
* *As a new user, I want to declare whether I have a stable monthly salary, so that the app can decide if I qualify for the Emergency Wallet feature.*  
* *As a salaried user, I want to input my monthly salary amount, so that the system can automatically calculate my emergency savings target (20%).*

**Acceptance Criteria:**

* Registration requires: Name, Phone Number, Password  
* Onboarding step asks: "Do you have a stable monthly salary? Yes / No"  
* If YES → user enters salary amount → Emergency Wallet is activated  
* If NO → Emergency Wallet is hidden/locked with explanation message

---

### **Feature 2: Multi-Wallet Balance Management**

**Description:** Users can manually set and update their current balance across three wallet types: **Cash**, **Visa (Bank Card)**, and **Smart Wallet (Mobile Wallet e.g. Vodafone Cash, Fawry)**. This gives a unified view of total liquidity.  
**User Stories:**

* *As a user, I want to see my total available money across all wallets in one screen, so that I know my real financial position at a glance.*  
* *As a user, I want to set an initial balance for each wallet type during setup, so that the app reflects my actual current state.*  
* *As a user, I want to see my Emergency Wallet balance separately, so that I'm always aware of how much protected savings I have.*

**Acceptance Criteria:**

* 4 wallet cards displayed: Cash / Visa / Smart Wallet / Emergency Wallet  
* Each wallet shows current balance  
* Total balance \= Cash \+ Visa \+ Smart Wallet (Emergency Wallet excluded from total by design)  
* Emergency Wallet balance is read-only (cannot be manually edited)

---

### **Feature 3: Cash-In (Income Logging)**

**Description:** Users log any incoming money by specifying the destination wallet. The system auto-captures timestamp and location metadata. Notes are optional.  
**User Stories:**

* *As a user, I want to log any money I receive and assign it to the correct wallet, so that my balances stay accurate.*  
* *As a user, I want the system to automatically record when and where I logged a transaction, so that I have context without extra effort.*  
* *As a user, I want to optionally add a note to a cash-in entry, so that I can remember the source of the income later.*

**Acceptance Criteria:**

* Required fields: Amount \+ Wallet (Cash / Visa / Smart Wallet)  
* Auto-captured: Timestamp, GPS Location (with permission)  
* Optional field: Notes (free text, max 100 chars)  
* Selected wallet balance updates immediately after logging  
* **If wallet \= Cash AND user has stable salary AND it's salary day logic → trigger Emergency Wallet auto-deduction of 20%** *(see Feature 5\)*

---

### **Feature 4: Cash-Out (Expense Logging)**

**Description:** Users log any outgoing money by specifying the source wallet and selecting a spending category. Emergency Wallet cashout follows a separate, restricted flow.  
**User Stories:**

* *As a user, I want to log an expense and assign it to a spending category, so that I can track where my money goes.*  
* *As a user, I want to select which wallet the money is coming from, so that my individual wallet balances stay accurate.*  
* *As a user, I want to optionally add a note to an expense, so that I can remember what the spending was for.*  
* *As a user trying to use my Emergency Wallet, I want the app to verify that my other wallets are empty or near zero, so that the emergency fund is only accessed when truly needed.*

**Acceptance Criteria:**

* Required fields: Amount \+ Source Wallet \+ Category  
* Categories (MVP set): Basics, Food & Breakfast, Supermarket, Transportation, Entertainment, Health, Bills, Other  
* Auto-captured: Timestamp, GPS Location  
* Optional: Notes  
* **Emergency Wallet cashout rule:** System checks Cash \+ Visa \+ Smart Wallet total → if total \> defined threshold (configurable, default: 50 EGP), cashout from Emergency Wallet is **blocked with explanation**  
* Emergency cashout requires user confirmation dialog: *"This will withdraw from your emergency savings. Are you sure?"*

---

### **Feature 5: Emergency Wallet — Auto-Save Engine**

**Description:** The core differentiating feature. When a salaried user logs a Cash-In that represents their salary (or any income), the system **automatically deducts 20%** and moves it to the Emergency Wallet — enforcing the savings rule without requiring willpower.  
**User Stories:**

* *As a salaried user, I want 20% of my salary to be automatically saved to my Emergency Wallet when I log my income, so that I don't have to remember to save manually.*  
* *As a user, I want to see a clear notification when money is moved to my Emergency Wallet, so that I'm aware of what happened.*  
* *As a user without a stable salary, I want to understand why the Emergency Wallet is unavailable to me, so that I'm not confused.*

**Acceptance Criteria:**

* Auto-deduction triggers when user logs a Cash-In and manually marks it as "Salary" (checkbox or toggle on Cash-In screen)  
* 20% is calculated and subtracted from the logged wallet → added to Emergency Wallet  
* Push notification sent: *"✅ 20% saved to Emergency Wallet — \[Amount\] EGP protected."*  
* Emergency Wallet balance is **never included** in "Available Total" display  
* Users with no stable salary see Emergency Wallet as locked with message: *"Activate by setting up your salary profile"*

---

### **Feature 6: Transaction History**

**Description:** A chronological log of all Cash-In and Cash-Out transactions, filterable by wallet type and date range.  
**User Stories:**

* *As a user, I want to view all my past transactions in one place, so that I can review my financial activity.*  
* *As a user, I want to filter transactions by wallet or date, so that I can find specific entries quickly.*

**Acceptance Criteria:**

* Full transaction list sorted by date (newest first)  
* Each entry shows: Type (In/Out), Amount, Wallet, Category (if out), Date/Time, Location (if captured)  
* Filter options: By Wallet Type / By Date Range  
* MVP: No charts or analytics (Out of Scope)

---

## **4\. Out of Scope (MVP)**

| Feature | Reason Excluded |
| ----- | ----- |
| Charts & Analytics Dashboard | Complexity without proven retention |
| Budget Planning / Forecasting | Second phase — needs more user data first |
| Bank/Wallet API Integration (Open Banking) | Regulatory complexity \+ high cost |
| Shared wallets / Family accounts | Different product scope |
| Bill reminders / recurring payments | Phase 2 feature |
| Export to PDF/Excel | Nice-to-have, not core |
| AI spending insights | Requires data history first |
| Dark mode / Themes | UI concern, not MVP |
| Multi-currency support | MENA MVP is single currency |
| Social / Gamification features | Phase 2 engagement layer |

---

## **5\. Key Risks & Assumptions**

| Risk | Mitigation |
| ----- | ----- |
| Users don't log transactions consistently | Onboarding habit-setting \+ push notification reminders |
| 20% rule feels "too strict" for some users | Make the % editable in settings (Phase 1.1) |
| Location permission denied by users | Make location optional, not blocking |
| Users misunderstand Emergency Wallet lock | Clear UX copy \+ tooltip explanation |

---

## **6\. MVP Tech Notes (For Engineering Handoff)**

*(This section is for dev alignment — not design spec)*

* **Platform:** Mobile-first (Flutter recommended for cross-platform MVP speed)  
* **Auth:** Phone number \+ OTP (simple, no email friction)  
* **Storage:** Local-first with optional cloud sync (reduces backend complexity at MVP)  
* **Location:** Device GPS — request permission on first transaction log  
* **Notifications:** Firebase Cloud Messaging (FCM)  
* **No external financial API integrations in MVP**

