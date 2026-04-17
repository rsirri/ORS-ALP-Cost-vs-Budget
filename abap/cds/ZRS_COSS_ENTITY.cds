@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COSS Financial Data Wrapper'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@Analytics.dataCategory: #FACT
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #XL,
    dataClass: #TRANSACTIONAL
}
define view entity ZRS_COSS_ENTITY
  as select from ZI_FIN_COSS
{
  key OBJNR,
  key GJAHR,
  key WRTTP,
  key VERSN,
  key KSTAR,
  key TWAER,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG001,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG002,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG003,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG004,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG005,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG006,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG007,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG008,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG009,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG010,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG011,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG012,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG013,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG014,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG015,
      @Semantics.amount.currencyCode: 'TWAER'
      WOG016,
      BUKRS,
      FKBER
}
where
     WRTTP = '01'
  or WRTTP = '04'
