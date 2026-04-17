@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WBS with Project and Account Code'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #M,
    dataClass: #MIXED
}
@Analytics.dataCategory: #DIMENSION
define view entity ZRS_ORS_WBSELEMENT
  as select from ZRS_WBSELEMENT  as wbs
    inner join   I_ProjectData_2 as proj on proj.ProjectInternalID = wbs.ProjectInternalID
{
  key wbs.WBSElementInternalID,
  key wbs.ProjectInternalID,

      -- From PRPS (via ZRS_WBSELEMENT)
      wbs.WBSElement,
      wbs.WBSElementObject,
      wbs.WBSDescription,
      wbs.WBSHierarchyLevel,
      wbs.CompanyCode,
      wbs.ControllingArea,
      wbs.ProfitCenter,
      wbs.IsMarkedForDeletion,

      -- Custom append fields
      wbs.AcctCode,
      wbs.AcctCodeDesc,

      -- From PROJ (via I_ProjectData_2)
      proj.ProjectInternalID as ProjInternalID,
      proj.Project,
      proj.ProjectDescription,
      proj.StatusCombinationCode,
      proj.BudgetProfile,
      proj.PlanningProfile
}
where
  wbs.IsMarkedForDeletion = ''
