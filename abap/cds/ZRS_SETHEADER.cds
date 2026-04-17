@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Set Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #M,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity zrs_setheader
  as select from setheader
{
  key setclass     as Setclass,
  key subclass     as Subclass,
  key setname      as Setname,
      settype      as Settype,
      xdynamic     as Xdynamic,
      authgr       as Authgr,
      xuniq        as Xuniq,
      rvalue       as Rvalue,
      creuser      as Creuser,
      credate      as Credate,
      cretime      as Cretime,
      upduser      as Upduser,
      upddate      as Upddate,
      updtime      as Updtime,
      saprl        as Saprl,
      tabname      as Tabname,
      fieldname    as Fieldname,
      rollname     as Rollname,
      set_olangu   as SetOlangu,
      no_rwsheader as NoRwsheader,
      no_rwsline   as NoRwsline,
      no_setlinet  as NoSetlinet
}
