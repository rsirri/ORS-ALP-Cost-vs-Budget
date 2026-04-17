@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS Account Code Category'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #MIXED
}
@Analytics.dataCategory: #FACT
define view entity ZRS_ORS_ACCTCAT
  with parameters
    p_gjahr  : gjahr,
    p_versn  : versn,
    p_period : numc2
  as select from ZRS_ORS_WBSELEMENT                as wbs
    inner join   ZRS_COSP_COSS_COMBINED(
                   p_gjahr : $parameters.p_gjahr,
                   p_versn : $parameters.p_versn ) as cost on cost.objnr = wbs.WBSElementObject
{
  key wbs.WBSElementInternalID,
  key wbs.ProjectInternalID,
  key cost.wrttp,

      cast( wbs.WBSElement as abap.char(24) ) as WBSElement,
      wbs.WBSDescription,
      wbs.AcctCode,
      wbs.AcctCodeDesc,
      cost.Currency,

      -- Account Category CASE (same as before)
      case
        when wbs.AcctCode = ' ' or wbs.AcctCode = '' then 'UN'
        when substring( wbs.AcctCode, 1, 5 ) = '30.12' then 'XX'
        when substring( wbs.AcctCode, 1, 5 ) = '99.09' then 'XX'
        when substring( wbs.AcctCode, 1, 2 ) = '40'    then 'XX'
        when substring( wbs.AcctCode, 1, 2 ) = '50' or
             substring( wbs.AcctCode, 1, 2 ) = '51' or
             substring( wbs.AcctCode, 1, 2 ) = '52' or
             substring( wbs.AcctCode, 1, 2 ) = '53' or
             substring( wbs.AcctCode, 1, 2 ) = '54' or
             substring( wbs.AcctCode, 1, 2 ) = '55' or
             substring( wbs.AcctCode, 1, 2 ) = '56' or
             substring( wbs.AcctCode, 1, 2 ) = '58' or
             substring( wbs.AcctCode, 1, 2 ) = '60' or
             substring( wbs.AcctCode, 1, 2 ) = '61' or
             substring( wbs.AcctCode, 1, 2 ) = '62' or
             substring( wbs.AcctCode, 1, 2 ) = '70' or
             substring( wbs.AcctCode, 1, 2 ) = '71' or
             substring( wbs.AcctCode, 1, 2 ) = '72' or
             substring( wbs.AcctCode, 1, 2 ) = '73' or
             substring( wbs.AcctCode, 1, 2 ) = '74' or
             substring( wbs.AcctCode, 1, 2 ) = '80' or
             substring( wbs.AcctCode, 1, 2 ) = '81' or
             substring( wbs.AcctCode, 1, 2 ) = '82' or
             substring( wbs.AcctCode, 1, 2 ) = '83' or
             substring( wbs.AcctCode, 1, 2 ) = '84' or
             substring( wbs.AcctCode, 1, 2 ) = '85' or
             substring( wbs.AcctCode, 1, 2 ) = '86' or
             substring( wbs.AcctCode, 1, 2 ) = '87' or
             substring( wbs.AcctCode, 1, 2 ) = '90' or
             substring( wbs.AcctCode, 1, 2 ) = '91' or
             substring( wbs.AcctCode, 1, 2 ) = '92'
             then 'DL'
        when substring( wbs.AcctCode, 1, 2 ) = '88' or
             substring( wbs.AcctCode, 1, 2 ) = '93' or
             substring( wbs.AcctCode, 1, 2 ) = '94' or
             substring( wbs.AcctCode, 1, 2 ) = '95'
             then 'BE'
        when substring( wbs.AcctCode, 1, 2 ) = '99' then 'CO'
        when substring( wbs.AcctCode, 1, 2 ) = '00' or
             substring( wbs.AcctCode, 1, 2 ) = '10' or
             substring( wbs.AcctCode, 1, 2 ) = '20' or
             substring( wbs.AcctCode, 1, 2 ) = '30'
             then 'GA'
        else 'XX'
      end                                     as AcctCategory,

      -- Current Month
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cost.wrttp
          when '01' then
            cast(
              case $parameters.p_period
                when '01' then cast( cost.wog001 as abap.dec(23,2) )
                when '02' then cast( cost.wog002 as abap.dec(23,2) )
                when '03' then cast( cost.wog003 as abap.dec(23,2) )
                when '04' then cast( cost.wog004 as abap.dec(23,2) )
                when '05' then cast( cost.wog005 as abap.dec(23,2) )
                when '06' then cast( cost.wog006 as abap.dec(23,2) )
                when '07' then cast( cost.wog007 as abap.dec(23,2) )
                when '08' then cast( cost.wog008 as abap.dec(23,2) )
                when '09' then cast( cost.wog009 as abap.dec(23,2) )
                when '10' then cast( cost.wog010 as abap.dec(23,2) )
                when '11' then cast( cost.wog011 as abap.dec(23,2) )
                when '12' then cast( cost.wog012 as abap.dec(23,2) )
                else cast( 0 as abap.dec(23,2) )
              end
            as abap.dec(23,2) )
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as PlanCurrentMonth,

      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cost.wrttp
          when '04' then
            cast(
              case $parameters.p_period
                when '01' then cast( cost.wog001 as abap.dec(23,2) )
                when '02' then cast( cost.wog002 as abap.dec(23,2) )
                when '03' then cast( cost.wog003 as abap.dec(23,2) )
                when '04' then cast( cost.wog004 as abap.dec(23,2) )
                when '05' then cast( cost.wog005 as abap.dec(23,2) )
                when '06' then cast( cost.wog006 as abap.dec(23,2) )
                when '07' then cast( cost.wog007 as abap.dec(23,2) )
                when '08' then cast( cost.wog008 as abap.dec(23,2) )
                when '09' then cast( cost.wog009 as abap.dec(23,2) )
                when '10' then cast( cost.wog010 as abap.dec(23,2) )
                when '11' then cast( cost.wog011 as abap.dec(23,2) )
                when '12' then cast( cost.wog012 as abap.dec(23,2) )
                else cast( 0 as abap.dec(23,2) )
              end
            as abap.dec(23,2) )
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as ActualCurrentMonth,

      -- Plan YTD
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cost.wrttp
          when '01' then
            cast(
              case $parameters.p_period
                when '01' then cast( cost.wog001 as abap.dec(23,2) )
                when '02' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) )
                when '03' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) )
                when '04' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) )
                when '05' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) )
                when '06' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) )
                when '07' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) )
                when '08' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) )
                when '09' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) )
                when '10' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) )
                when '11' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) ) + cast( cost.wog011 as abap.dec(23,2) )
                when '12' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) ) + cast( cost.wog011 as abap.dec(23,2) ) + cast( cost.wog012 as abap.dec(23,2) )
                else cast( 0 as abap.dec(23,2) )
              end
            as abap.dec(23,2) )
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as PlanYTD,

      -- Actual YTD
      @Semantics.amount.currencyCode: 'Currency'
      cast(
        case cost.wrttp
          when '04' then
            cast(
              case $parameters.p_period
                when '01' then cast( cost.wog001 as abap.dec(23,2) )
                when '02' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) )
                when '03' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) )
                when '04' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) )
                when '05' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) )
                when '06' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) )
                when '07' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) )
                when '08' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) )
                when '09' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) )
                when '10' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) )
                when '11' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) ) + cast( cost.wog011 as abap.dec(23,2) )
                when '12' then cast( cost.wog001 as abap.dec(23,2) ) + cast( cost.wog002 as abap.dec(23,2) ) + cast( cost.wog003 as abap.dec(23,2) ) + cast( cost.wog004 as abap.dec(23,2) ) + cast( cost.wog005 as abap.dec(23,2) ) + cast( cost.wog006 as abap.dec(23,2) ) + cast( cost.wog007 as abap.dec(23,2) ) + cast( cost.wog008 as abap.dec(23,2) ) + cast( cost.wog009 as abap.dec(23,2) ) + cast( cost.wog010 as abap.dec(23,2) ) + cast( cost.wog011 as abap.dec(23,2) ) + cast( cost.wog012 as abap.dec(23,2) )
                else cast( 0 as abap.dec(23,2) )
              end
            as abap.dec(23,2) )
          else cast( 0 as abap.dec(23,2) )
        end
      as abap.dec(23,2) )                     as ActualYTD
}
where
      substring( wbs.AcctCode, 1, 2 ) <> '40'
  and substring( wbs.AcctCode, 1, 5 ) <> '30.12'
  and substring( wbs.AcctCode, 1, 5 ) <> '99.09'
