@AbapCatalog.sqlViewName: 'ZIFINCOSS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COSS Data Extractor View'
@Metadata.ignorePropagatedAnnotations: true
//----------------------------------------------------------------------
//  Object ID           : ENFFIN204                                     *
//  Program Title       : Full and Delta Load for COSS                  *
//  Author              : Jay Nagarajan                                 *
//  Date                : 06/13/2025                                    *
//  SAP Change Request #: E4DK900215                                    *
//----------------------------------------------------------------------*
//  Description         : Custom CDS View                               *
//  Type:               : CDS View                                      *
//  Development Class:  : ZFINV3                                        *
//  Requirement Ref.    : Functional/Technical spec                     *
//                        KieCore_ENFFIN203                             *
//*----------------------------------------------------------------------*
define view ZI_FIN_COSS
  as select
    *
  from // coss
   coss_bak
  where
    (
         wrttp <> '04'
      and wrttp <> '11'
    )
  union select
    *
  from zfin_coss;
