@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS Financial Dashboard Query'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #CONSUMPTION
@Analytics.query: true
@Analytics.technicalName: 'ZRS_ORS_QUERY'
@UI.presentationVariant: [{
    sortOrder: [{ by: 'Project', direction: #ASC }]
}]
@OData.publish: true
define view entity ZRS_ORS_QUERY
  with parameters

    @Consumption.defaultValue: '2025'
    p_gjahr   : gjahr,

    @Consumption.defaultValue: 'Z02'
    p_versn   : versn,

    @Consumption.defaultValue: '02'
    @EndUserText: {
    label: 'Period',
    quickInfo: 'Fiscal Period (01-12)'
    }
    p_period  : numc2,

    @Consumption.defaultValue: '20250101'
    @EndUserText: {
    label: 'Date From',
    quickInfo: 'Project Planned End Date From'
    }
    p_fdate   : dats,

    @Consumption.defaultValue: '20251231'
    @EndUserText: {
    label: 'Date To',
    quickInfo: 'Project Planned End Date To'
    }
    p_tdate   : dats,

    @EndUserText.label: 'District ID'
    @Consumption.defaultValue: 'SE1000'
    p_setname : setname

  as select from ZRS_ORS_FINANCIALS_CUBE(
                   p_gjahr  : $parameters.p_gjahr,
                   p_versn  : $parameters.p_versn,
                   p_period : $parameters.p_period,
                   p_fdate  : $parameters.p_fdate,
                   p_tdate  : $parameters.p_tdate,
                   p_setname : $parameters.p_setname )
{
      -- ── DIMENSIONS ──────────────────────────────────────────

      @AnalyticsDetails.query.display: #KEY_TEXT
      @EndUserText.label: 'Project'
      @AnalyticsDetails.query.axis: #ROWS
  key Project,

      @EndUserText.label: 'Project Description'
      @AnalyticsDetails.query.axis: #ROWS
      ProjectDescription,

      @EndUserText.label: 'Set Name'
      @AnalyticsDetails.query.axis: #ROWS
      LeafSetname,

      @EndUserText.label: 'Set Class'
      @AnalyticsDetails.query.axis: #ROWS
      Setclass,

      @EndUserText.label: 'Set'
      @AnalyticsDetails.query.axis: #ROWS
      Setname,

      @EndUserText.label: 'District'
      @AnalyticsDetails.query.axis: #ROWS
      DistrictDisplay,

      @EndUserText.label: 'District Set Name'
      @AnalyticsDetails.query.axis: #ROWS
      DistrictSetName,

      @EndUserText.label: 'District Description'
      @AnalyticsDetails.query.axis: #ROWS
      DistrictDescription,

      @EndUserText.label: 'Project Display'
      @AnalyticsDetails.query.axis: #ROWS
      ProjectDisplay,

      @EndUserText.label: 'WBS Element'
      @AnalyticsDetails.query.axis: #ROWS
      WBSElement,

      @EndUserText.label: 'WBS Description'
      @AnalyticsDetails.query.axis: #ROWS
      WBSDescription,

      @EndUserText.label: 'Account Code'
      @AnalyticsDetails.query.axis: #ROWS
      AcctCode,

      @EndUserText.label: 'Account Description'
      @AnalyticsDetails.query.axis: #ROWS
      AcctCodeDesc,

      @EndUserText.label: 'Account Category'
      @AnalyticsDetails.query.axis: #ROWS
      AcctCategory,

      @EndUserText.label: 'Value Type'
      @AnalyticsDetails.query.axis: #ROWS
      wrttp,

      //  @EndUserText.label: 'Version'
      //  @AnalyticsDetails.query.axis: #ROWS
      //  versn,

      @EndUserText.label: 'Company Code'
      @AnalyticsDetails.query.axis: #ROWS
      CompanyCode,

      @EndUserText.label: 'Controlling Area'
      @AnalyticsDetails.query.axis: #ROWS
      ControllingArea,

      @EndUserText.label: 'Profit Center'
      @AnalyticsDetails.query.axis: #ROWS
      ProfitCenter,

      @EndUserText.label: 'Currency'
      Currency,

      -- ── DL MEASURES ─────────────────────────────────────────

      @EndUserText.label: 'DL Plan (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_PlanMon,

      @EndUserText.label: 'DL Actual (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_CostMon,

      @EndUserText.label: 'DL Over/Under (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_PlanMon - DL_CostMon                          as DL_OverUnderMon,

      @EndUserText.label: 'DL Plan YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_PlanYTD,

      @EndUserText.label: 'DL Actual YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_CostYTD,

      @EndUserText.label: 'DL Over/Under YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      DL_PlanYTD - DL_CostYTD                          as DL_OverUnderYTD,

      -- ── BE MEASURES ─────────────────────────────────────────

      @EndUserText.label: 'BE Plan (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_PlanMon,

      @EndUserText.label: 'BE Actual (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_CostMon,

      @EndUserText.label: 'BE Over/Under (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_PlanMon - BE_CostMon                          as BE_OverUnderMon,

      @EndUserText.label: 'BE Plan YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_PlanYTD,

      @EndUserText.label: 'BE Actual YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_CostYTD,

      @EndUserText.label: 'BE Over/Under YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BE_PlanYTD - BE_CostYTD                          as BE_OverUnderYTD,

      -- ── GA MEASURES ─────────────────────────────────────────

      @EndUserText.label: 'GA Plan (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_PlanMon,

      @EndUserText.label: 'GA Actual (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_CostMon,

      @EndUserText.label: 'GA Over/Under (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_PlanMon - GA_CostMon                          as GA_OverUnderMon,

      @EndUserText.label: 'GA Plan YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_PlanYTD,

      @EndUserText.label: 'GA Actual YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_CostYTD,

      @EndUserText.label: 'GA Over/Under YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      GA_PlanYTD - GA_CostYTD                          as GA_OverUnderYTD,

      -- ── CO MEASURES ─────────────────────────────────────────

      @EndUserText.label: 'CO Plan (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_PlanMon,

      @EndUserText.label: 'CO Actual (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_CostMon,

      @EndUserText.label: 'CO Over/Under (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_PlanMon - CO_CostMon                          as CO_OverUnderMon,

      @EndUserText.label: 'CO Plan YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_PlanYTD,

      @EndUserText.label: 'CO Actual YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_CostYTD,

      @EndUserText.label: 'CO Over/Under YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      CO_PlanYTD - CO_CostYTD                          as CO_OverUnderYTD,

      -- ── BD MEASURES (Budget Total) ───────────────────────────

      @EndUserText.label: 'Total Plan (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_PlanMon,

      @EndUserText.label: 'Total Actual (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_CostMon,

      @EndUserText.label: 'Total Over/Under (Month $K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_PlanMon - BD_CostMon                          as BD_OverUnderMon,

      @EndUserText.label: 'Total Plan YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_PlanYTD,

      @EndUserText.label: 'Total Actual YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_CostYTD,

      @EndUserText.label: 'Total Over/Under YTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #FORMULA
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      BD_PlanYTD - BD_CostYTD                          as BD_OverUnderYTD,

      -- ── UN MEASURE ───────────────────────────────────────────

      @EndUserText.label: 'Unclassified JTD ($K)'
      @Semantics.amount.currencyCode: 'Currency'
      @Aggregation.default: #SUM
      @UI.dataPoint.valueFormat: { scaleFactor: 1000, numberOfFractionalDigits: 1 }
      UN_CostJTD

}
