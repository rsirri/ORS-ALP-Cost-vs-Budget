@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS COSP Base - Plan and Actuals'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
@Analytics.dataCategory: #FACT
define view entity ZRS_COSP_BASE
  as select from ZRS_COSP_ENTITY
{
  key objnr,
  key gjahr,
  key wrttp,
  key versn,
  key kstar,

  key twaer,

      -- Period amounts (object currency)
      @Semantics.amount.currencyCode: 'twaer'
      wog001,
      @Semantics.amount.currencyCode: 'twaer'
      wog002,
      @Semantics.amount.currencyCode: 'twaer'
      wog003,
      @Semantics.amount.currencyCode: 'twaer'
      wog004,
      @Semantics.amount.currencyCode: 'twaer'
      wog005,
      @Semantics.amount.currencyCode: 'twaer'
      wog006,
      @Semantics.amount.currencyCode: 'twaer'
      wog007,
      @Semantics.amount.currencyCode: 'twaer'
      wog008,
      @Semantics.amount.currencyCode: 'twaer'
      wog009,
      @Semantics.amount.currencyCode: 'twaer'
      wog010,
      @Semantics.amount.currencyCode: 'twaer'
      wog011,
      @Semantics.amount.currencyCode: 'twaer'
      wog012,
      @Semantics.amount.currencyCode: 'twaer'
      wog013,
      @Semantics.amount.currencyCode: 'twaer'
      wog014,
      @Semantics.amount.currencyCode: 'twaer'
      wog015,
      @Semantics.amount.currencyCode: 'twaer'
      wog016,

      -- Total across all periods (useful for summary)
      @Semantics.amount.currencyCode: 'twaer'
      ( wog001 + wog002 + wog003 + wog004 +
        wog005 + wog006 + wog007 + wog008 +
        wog009 + wog010 + wog011 + wog012 +
        wog013 + wog014 + wog015 + wog016 ) as TotalAmount,

      bukrs,
      fkber
}
where
     wrttp = '01'
  or wrttp = '04'
