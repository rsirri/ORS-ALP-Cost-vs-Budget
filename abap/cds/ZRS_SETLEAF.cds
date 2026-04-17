@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Set Leaf'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity zrs_setleaf
  as select from setleaf
{
  key setclass  as Setclass,
  key subclass  as Subclass,
  key setname   as Setname,
  key lineid    as Lineid,
      valsign   as Valsign,
      valoption as Valoption,
      valfrom   as Valfrom,
      valto     as Valto,
      seqnr     as Seqnr
}
