@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS Financial Dashboard Cube'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #CUBE
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #MIXED
}
define view entity ZRS_ORS_FINANCIALS_CUBE
  with parameters
    p_gjahr   : gjahr,
    p_versn   : versn,
    p_period  : numc2,
    p_fdate   : abap.dats,
    p_tdate   : abap.dats,
    p_setname : setname
  as select from ZRS_ORS_ACCTCAT(
                   p_gjahr  : $parameters.p_gjahr,
                   p_versn  : $parameters.p_versn,
                   p_period : $parameters.p_period ) as cat
    inner join   ZRS_PROJECT_SET(
                   p_fdate : $parameters.p_fdate,
                   p_tdate : $parameters.p_tdate )   as proj on  proj.ProjectInternalID = cat.ProjectInternalID
                                                             and proj.Setclass          = '0106'
                                                             and proj.Subclass          = '1000'
                                                             and proj.Setname           = $parameters.p_setname
{
      -- Keys / Dimensions
  key cat.WBSElementInternalID,
  key cat.AcctCategory,
  key cat.wrttp,
      proj.DistrictSetName,
      proj.DistrictDescription,
      proj.DistrictDisplay,
      proj.ProjectDisplay,
      //  key cat.versn,

      -- WBS Dimensions
      cast( cat.WBSElement as abap.char(24) ) as WBSElement,
      cat.WBSDescription,
      cat.AcctCode,
      cat.AcctCodeDesc,
      cat.Currency,

      -- Project Dimensions
      proj.Project,
      proj.ProjectDescription,
      proj.LeafSetname,
      proj.CompanyCode,
      proj.ControllingArea,
      proj.ProfitCenter,
      proj.Setclass,
      proj.Setname,

      -- DL Measures
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'DL' then cat.PlanCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as DL_PlanMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'DL' then cat.ActualCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as DL_CostMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'DL' then cat.PlanYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as DL_PlanYTD,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'DL' then cat.ActualYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as DL_CostYTD,

      -- BE Measures
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'BE' then cat.PlanCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as BE_PlanMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'BE' then cat.ActualCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as BE_CostMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'BE' then cat.PlanYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as BE_PlanYTD,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'BE' then cat.ActualYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as BE_CostYTD,

      -- GA Measures
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'GA' then cat.PlanCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as GA_PlanMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'GA' then cat.ActualCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as GA_CostMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'GA' then cat.PlanYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as GA_PlanYTD,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'GA' then cat.ActualYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as GA_CostYTD,

      -- CO Measures
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'CO' then cat.PlanCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as CO_PlanMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'CO' then cat.ActualCurrentMonth
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as CO_CostMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'CO' then cat.PlanYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as CO_PlanYTD,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'CO' then cat.ActualYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as CO_CostYTD,

      -- BD = DL + BE + GA + CO (Budget Total)
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'UN' then cast( 0 as abap.dec(23,2) )
          else cat.PlanCurrentMonth
        end
      as abap.dec(23,2) )                     as BD_PlanMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'UN' then cast( 0 as abap.dec(23,2) )
          else cat.ActualCurrentMonth
        end
      as abap.dec(23,2) )                     as BD_CostMon,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'UN' then cast( 0 as abap.dec(23,2) )
          else cat.PlanYTD
        end
      as abap.dec(23,2) )                     as BD_PlanYTD,

      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'UN' then cast( 0 as abap.dec(23,2) )
          else cat.ActualYTD
        end
      as abap.dec(23,2) )                     as BD_CostYTD,

      -- UN Measure (Unclassified JTD)
      @Aggregation.default: #SUM
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cat.AcctCategory
          when 'UN' then
            cat.ActualCurrentMonth + cat.ActualYTD +
            cat.PlanCurrentMonth   + cat.PlanYTD
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as UN_CostJTD

}
