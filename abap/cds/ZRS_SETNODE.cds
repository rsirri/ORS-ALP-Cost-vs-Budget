@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Set Node'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity zrs_setnode
  as select from setnode
{
  key setclass   as Setclass,
  key subclass   as Subclass,
  key setname    as Setname,
  key lineid     as Lineid,
      subsetcls  as Subsetcls,
      subsetscls as Subsetscls,
      subsetname as Subsetname,
      seqnr      as Seqnr
}
