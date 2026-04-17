@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Set GS03 Full List - Project Leaf Values'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
    serviceQuality: #C,
    sizeCategory: #M,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZRS_SETFULLLIST
  as select from zrs_setheader  as h
  -- Level 1 node directly under root header
    inner join   zrs_setnode    as node1    on  h.Setclass = node1.Setclass
                                            and h.Subclass = node1.Subclass
                                            and h.Setname  = node1.Setname
  -- Level 2 node — subset of Level 1
    inner join   zrs_setnode    as node2    on  node1.Subsetcls  = node2.Setclass
                                            and node1.Subsetscls = node2.Subclass
                                            and node1.Subsetname = node2.Setname
  -- Leaf values under Level 2 (the _PJ sets)
    inner join   zrs_setleaf    as leaf     on  node2.Subsetcls  = leaf.Setclass
                                            and node2.Subsetscls = leaf.Subclass
                                            and node2.Subsetname = leaf.Setname

  -- Leaf values under Level 2 (the _PJ sets)
    inner join   ZRS_SETHEADERT as setDescr on  setDescr.Setclass = h.Setclass
                                            and setDescr.Subclass = h.Subclass
                                            and setDescr.Setname  = h.Setname

{
  key h.Setclass,
  key h.Subclass,
  key h.Setname,

      setDescr.Descript,

      -- Intermediate node context for traceability
      node1.Subsetname          as Node1Subsetname,
      node2.Setname             as Node2Setname,

      -- The _PJ set identity (owner of the leaf)
      leaf.Setname              as LeafSetname,
      leaf.Lineid,
      leaf.Seqnr,
      leaf.Valsign,
      leaf.Valoption,
      leaf.Valfrom,
      ltrim( leaf.Valfrom, '0') as ConvertedVFOUT,
      leaf.Valto
}
where
  leaf.Setname like '%_PJ'
