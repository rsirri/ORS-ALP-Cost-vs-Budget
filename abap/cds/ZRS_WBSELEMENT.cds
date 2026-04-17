@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WBS Element with Custom Account Code'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #BASIC
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #L,
    dataClass: #MASTER
}
@Analytics.dataCategory: #DIMENSION
define view entity ZRS_WBSELEMENT
  as select from prps
{
  key pspnr         as WBSElementInternalID,
      psphi         as ProjectInternalID,
      posid         as WBSElement,
      objnr         as WBSElementObject,
      post1         as WBSDescription,
      stufe         as WBSHierarchyLevel,
      prart         as WBSElementType,

      -- Org fields (PRPS uses p-prefix)
      pbukr         as CompanyCode,
      pkokr         as ControllingArea,
      prctr         as ProfitCenter,

      -- Status
      loevm         as IsMarkedForDeletion,

      -- CI_PRPS Append fields (Hardolar custom)
      /hardolar/ac  as AcctCode,
      /hardolar/acd as AcctCodeDesc
}
