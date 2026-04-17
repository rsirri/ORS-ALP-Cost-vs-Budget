@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS COSS Base - Plan and Actuals'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
@Analytics.dataCategory: #FACT
define view entity ZRS_COSS_BASE
  as select from ZRS_COSS_ENTITY
{
  key OBJNR,
  key GJAHR,
  key WRTTP,
  key VERSN,
  key KSTAR,
  key TWAER,

      -- Period amounts (object currency)
      @Semantics.amount.currencyCode: 'twaer'
      WOG001,
      @Semantics.amount.currencyCode: 'twaer'
      WOG002,
      @Semantics.amount.currencyCode: 'twaer'
      WOG003,
      @Semantics.amount.currencyCode: 'twaer'
      WOG004,
      @Semantics.amount.currencyCode: 'twaer'
      WOG005,
      @Semantics.amount.currencyCode: 'twaer'
      WOG006,
      @Semantics.amount.currencyCode: 'twaer'
      WOG007,
      @Semantics.amount.currencyCode: 'twaer'
      WOG008,
      @Semantics.amount.currencyCode: 'twaer'
      WOG009,
      @Semantics.amount.currencyCode: 'twaer'
      WOG010,
      @Semantics.amount.currencyCode: 'twaer'
      WOG011,
      @Semantics.amount.currencyCode: 'twaer'
      WOG012,
      @Semantics.amount.currencyCode: 'twaer'
      WOG013,
      @Semantics.amount.currencyCode: 'twaer'
      WOG014,
      @Semantics.amount.currencyCode: 'twaer'
      WOG015,
      @Semantics.amount.currencyCode: 'twaer'
      WOG016,

      @Semantics.amount.currencyCode: 'twaer'
      ( WOG001 + WOG002 + WOG003 + WOG004 +
        WOG005 + WOG006 + WOG007 + WOG008 +
        WOG009 + WOG010 + WOG011 + WOG012 +
        WOG013 + WOG014 + WOG015 + WOG016 ) as TotalAmount,

      BUKRS,
      FKBER
}
where
     WRTTP = '01'
  or WRTTP = '04'
