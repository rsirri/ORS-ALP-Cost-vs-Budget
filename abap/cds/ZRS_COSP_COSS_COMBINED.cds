@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS COSP+COSS Raw Union'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@Analytics.dataCategory: #FACT
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define view entity ZRS_COSP_COSS_COMBINED
  with parameters
    p_gjahr : gjahr,
    p_versn : versn
  as select from ZRS_COSP_BASE as cost
{
  key cost.objnr,
  key cost.gjahr,
  key cost.wrttp,
  key versn,
      cost.twaer                            as Currency,

      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog001 as abap.dec(23,2) ) as wog001,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog002 as abap.dec(23,2) ) as wog002,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog003 as abap.dec(23,2) ) as wog003,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog004 as abap.dec(23,2) ) as wog004,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog005 as abap.dec(23,2) ) as wog005,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog006 as abap.dec(23,2) ) as wog006,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog007 as abap.dec(23,2) ) as wog007,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog008 as abap.dec(23,2) ) as wog008,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog009 as abap.dec(23,2) ) as wog009,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog010 as abap.dec(23,2) ) as wog010,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog011 as abap.dec(23,2) ) as wog011,
      @Semantics.amount.currencyCode: 'Currency'
      cast( cost.wog012 as abap.dec(23,2) ) as wog012
}
where
           cost.gjahr          = $parameters.p_gjahr
  and(
    (
           cost.wrttp          = '01'
      and(
           cost.versn          = $parameters.p_versn
        or $parameters.p_versn = ''
      )
    )
    or(
           cost.wrttp          = '04'
    )
  )

union all select from ZRS_COSS_BASE as cost
{
  key cost.OBJNR,
  key cost.GJAHR,
  key cost.WRTTP,
  key VERSN,
      cost.TWAER                            as Currency,


      cast( cost.WOG001 as abap.dec(23,2) ) as wog001,

      cast( cost.WOG002 as abap.dec(23,2) ) as wog002,

      cast( cost.WOG003 as abap.dec(23,2) ) as wog003,

      cast( cost.WOG004 as abap.dec(23,2) ) as wog004,

      cast( cost.WOG005 as abap.dec(23,2) ) as wog005,

      cast( cost.WOG006 as abap.dec(23,2) ) as wog006,

      cast( cost.WOG007 as abap.dec(23,2) ) as wog007,

      cast( cost.WOG008 as abap.dec(23,2) ) as wog008,

      cast( cost.WOG009 as abap.dec(23,2) ) as wog009,

      cast( cost.WOG010 as abap.dec(23,2) ) as wog010,

      cast( cost.WOG011 as abap.dec(23,2) ) as wog011,

      cast( cost.WOG012 as abap.dec(23,2) ) as wog012
}
where
           cost.GJAHR          = $parameters.p_gjahr
  and(
    (
           cost.WRTTP          = '01'
      and(
           cost.VERSN          = $parameters.p_versn
        or $parameters.p_versn = ''
      )
    )
    or(
           cost.WRTTP          = '04'
    )
  )
