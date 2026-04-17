@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COSP Financial Data Wrapper'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #FACT
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define view entity ZRS_COSP_ENTITY
  as select from ZI_FIN_COSP
{
  key objnr,
  key gjahr,
  key wrttp,
  key versn,
  key kstar,
  key twaer,
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
      bukrs,
      fkber
}
where
     wrttp = '01'
  or wrttp = '04'
