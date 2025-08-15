/*
R.003771

----------

Name: GHW ADMINREPORT Blank 942 fields
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-15 21:25:02
Modified on: 2023-10-15 21:34:39
Date last run: 2023-10-15 21:37:05

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  branches.branchname As LIBRARY,
  locationss.lib As SHELVING_LOCATION,
  itemtypes.description As ITEM_TYPE,
  ccodes.lib As COLLECTION_CODE,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]')) As TITLE,
  Concat('', 'Go to biblio') As LINK
From
  action_logs Join
  borrowers On borrowers.borrowernumber = action_logs.user Join
  biblio On biblio.biblionumber = action_logs.object Join
  biblioitems On biblioitems.biblionumber = biblio.biblionumber Left Join
  (Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'LOC') locationss On locationss.authorised_value = biblioitems.agerestriction Join
  branches On branches.branchcode = borrowers.branchcode Left Join
  itemtypes On itemtypes.itemtype = biblioitems.itemtype Left Join
  (Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'CCODE') ccodes On ccodes.authorised_value = biblioitems.cn_class Join
  biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber
Where
  action_logs.module = 'CATALOGUING' And
  action_logs.action = 'ADD' And
  Year(action_logs.timestamp) = Year(Now() - Interval 1 Month) And
  Month(action_logs.timestamp) = Month(Now() - Interval 1 Month) And
  action_logs.info = 'biblio' And
  borrowers.branchcode Like '%' And
  (biblioitems.agerestriction Like '' OR
  biblioitems.agerestriction IS NULL OR
  biblioitems.itemtype Like '' OR
  biblioitems.itemtype IS NULL OR
  biblioitems.cn_class Like '' or
  biblioitems.cn_class IS NULL)
Order By
  LIBRARY,
  SHELVING_LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE

























