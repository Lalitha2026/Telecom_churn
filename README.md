# Telecom_churn

## 1. Executive Summary

This end-to-end data product addresses customer attrition for a major telecommunications provider. By converting raw, siloed billing and tenure data into actionable insights, the project establishes a proactive retention framework.

* **The Problem:** Universal retention campaigns are financially inefficient, while purely reactive strategies fail to intercept churning accounts before the billing cycle closes. Key high-risk clusters—specifically **Month-to-Month contract subscribers utilizing Fiber Optic internet**—experience disproportionately high turnover.
* **The Solution:** An integrated pipeline that cleans historical customer profiles, maps them into a robust relational database, and leverages a machine learning **Random Forest Classifier** to predict individual churn probabilities.
* **The Impact:** Rather than looking backward, the system introduces a **Decision-Support Dashboard** equipped with **Dynamic Risk Thresholding**. This enables executive leadership to simulate risk mitigation scenarios, optimize marketing incentive allocations, and actively target vulnerable, high-value accounts before they cancel.

---

## 2. Technical Stack & Architecture

```text
[Excel Data Prep] ──> [PostgreSQL Database] / [SQL Database] ──> [Python ML Pipeline] ──> [Tableau/Power BI]

```

* **Data Cleansing & Logic Mapping:** `Excel`
* Resolved data anomalies and empty structures using conditional logic (`IF` tracking) to handle edge cases like zero-month tenure anomalies, establishing an entirely numeric baseline for advanced pipeline scaling.


* **Database Management System (DBMS):** `PostgreSQL` / `pgAdmin 4`
* Designed structured, strictly typed relational schemas to enforce data integrity. Implemented Common Table Expressions (CTEs) and window functions (`DENSE_RANK`) to run optimized cohort and revenue impact analysis.


* **Predictive Modeling Engine:** `Python 3.x`
* *Data Manipulation:* `Pandas`, `NumPy`
* *Machine Learning & Preprocessing:* `Scikit-Learn` (`RandomForestClassifier`, `StandardScaler`, `LabelEncoder`)
* Engineered a classification pipeline splitting data (80/20 stratified split) to output precise, granular individual customer churn risk scores.


* **Business Intelligence & Analytics Canvas:** `Tableau` / `Power BI`
* Developed executive-facing scorecards and risk matrices. Engineered dynamic user parameters to allow interactive, real-time risk-tolerance adjustments.



---

## 3. Strategic Business Recommendations

Based on the cohort metrics uncovered via SQL and the feature dominance patterns highlighted by the machine learning model, the following three strategic initiatives are recommended:

### 1. High-Risk Cohort Intervention (The Fiber Optic Quick-Win)

* **Insight:** The data reveals a massive churn concentration among Month-to-Month subscribers on Fiber Optic lines. This suggests a potential misalignment between premium pricing and perceived service reliability or onboarding expectations.
* **Action:** Launch a targeted, automated migration campaign offering a localized discount (e.g., 10% off for 6 months) if these specific users transition to a stable 1-year or 2-year contract agreement.

### 2. Value-Driven Retention Budget Optimization

* **Insight:** Universal save-offers waste valuable margin on customers who were never going to leave, while missing critical accounts completely.
* **Action:** Integrate the dashboard's **Dynamic Risk Thresholding Slider** into quarterly budget planning. Set the operational retention trigger to a **70% probability threshold** to maximize the ROI of customer care teams—focusing expensive retention incentives exclusively on high-value, high-risk accounts.

### 3. Structural Pricing & Contract Redesign

* **Insight:** Short-term, transactional accounts represent the primary financial leak in recurring revenue streams.
* **Action:** Incentivize the sales pipeline to phase out standard Month-to-Month setups by bundling device credits, streaming add-ons, or installation waivers exclusively into long-term contracts. This lowers short-term attrition and systematically stabilizes the customer lifetime value (LTV).
