@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORS Project Set - Active Projects'
@Metadata.ignorePropagatedAnnotations: true
@VDM.viewType: #COMPOSITE
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #M,
    dataClass: #MIXED
}
@Analytics.dataCategory: #DIMENSION
define view entity ZRS_PROJECT_SET
  with parameters
    p_fdate : abap.dats,
    p_tdate : abap.dats
  as select from ZRS_SETFULLLIST as sets
    inner join   I_ProjectData_2 as proj on proj.Project = sets.ConvertedVFOUT
{
  key sets.Setclass,
  key sets.Subclass,
  key sets.Setname,
  key proj.ProjectInternalID,


      -- District fields ← ADD THESE
      sets.Setname                      as DistrictSetName,
      sets.Descript                     as DistrictDescription,

      -- Combined display: 'SE2011 - TIC Southern'
      concat( concat( sets.Setname, ' - ' ),
              sets.Descript )           as DistrictDisplay,

      -- Set context
      sets.Valfrom                      as ProjectID,
      sets.LeafSetname,
      sets.Node1Subsetname,
      sets.ConvertedVFOUT               as ProjectIDExternal,

      -- Project display: '00102471-JV Sutton...'
      concat( concat( proj.Project, '-' ),
              proj.ProjectDescription ) as ProjectDisplay,

      -- Project master fields
      proj.Project,
      proj.ProjectDescription,
      proj.CompanyCode,
      proj.ControllingArea,
      proj.ProfitCenter,
      proj.BusinessArea,
      proj.FunctionalArea,
      proj.ResponsiblePersonName,
      proj.StatusCombinationCode,
      proj.IsMarkedForDeletion,
      proj.BudgetProfile,
      proj.PlanningProfile,
      proj.PlannedStartDate,
      proj.PlannedEndDate,

      -- Associations
      proj._WBSElement,
      proj._CompanyCode,
      proj._ControllingArea,
      proj._ProfitCenter

      //      -- Set context
      //      sets.Valfrom as ProjectID,
      //      sets.LeafSetname,
      //
      //      -- Project master fields
      //      proj.Project,
      //      proj.ProjectDescription,
      //      proj.CompanyCode,
      //      proj.ControllingArea,
      //      proj.ProfitCenter,
      //      proj.BusinessArea,
      //      proj.FunctionalArea,
      //      proj.ResponsiblePersonName,
      //      proj.StatusCombinationCode,
      //      proj.IsMarkedForDeletion,
      //      proj.BudgetProfile,
      //      proj.PlanningProfile,
      //
      //      -- Associations passthrough for further joins
      //      proj._WBSElement,
      //      proj._CompanyCode,
      //      proj._ControllingArea,
      //      proj._ProfitCenter
}
where
      proj.IsMarkedForDeletion = ''
  and proj.PlannedEndDate      between $parameters.p_fdate and $parameters.p_tdate
