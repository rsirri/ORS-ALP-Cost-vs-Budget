# ORS Actual vs Budget by District

Fiori Elements Analytical List Page (ALP) app built on S/4HANA 2023.

## Tech Stack
- OData V2 via @OData.publish:true on CDS Query view
- Fiori Elements ALP (sap.suite.ui.generic.template)
- UI5 version 1.120.23

## CDS Stack
- ZRS_SETFULLLIST → ZRS_PROJECT_SET (District/Project hierarchy)
- ZRS_ORS_WBSELEMENT (WBS elements)
- ZRS_COSP_COSS_COMBINED (Cost data - COSP + COSS union)
- ZRS_ORS_ACCTCAT (Account categorization - DL/BE/GA/CO/UN)
- ZRS_ORS_FINANCIALS_CUBE (@Analytics.dataCategory:#CUBE)
- ZRS_ORS_QUERY (@Analytics.query:true, @OData.publish:true)

## Parameters
- p_gjahr : Fiscal Year
- p_versn : Version
- p_period: Period
- p_fdate : Date From
- p_tdate : Date To
- p_setname: District Set Name (Setclass=0106, Subclass=1000)

## Deployment
- BSP: ZORS_ACT_BUDGET
- Client 100 (dev) → deploy
- Client 200 (data) → access with ?sap-client=200

## Features
- Analytical table with Plan vs Actual vs Variance
- Bar chart: Plan vs Actual by Category
- Visual Filter: Actual by Category (Donut)
- Totals row at bottom
- Parameters exposed as filter bar fields

## Known Limitations
- KPI tiles: parked (OData V2 parameterized query limitation)
- Criticality coloring: parked (analytics query CASE restrictions)
