/*
R.003366

----------

Name: GHW - 942 sandbox
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-10 21:54:25
Modified on: 2020-11-10 21:54:25
Date last run: 2020-11-10 22:25:22

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
    biblio_metadata.biblionumber,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') As LOCATION,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') As ITYPE,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') As CCODE,
    ITEMS_INFOS.Group_Concat_permanent_location,
    ITEMS_INFOS.Group_Concat_location,
    ITEMS_INFOS.Group_Concat_itype,
    ITEMS_INFOS.Group_Concat_ccode
From
    biblio_metadata Join
    (Select
         items.biblionumber,
         Group_Concat(Distinct items.permanent_location Order By items.permanent_location) As
         Group_Concat_permanent_location,
         Group_Concat(Distinct items.location Order By items.location) As Group_Concat_location,
         Group_Concat(Distinct items.itype Order By items.itype) As Group_Concat_itype,
         Group_Concat(Distinct items.ccode Order By items.ccode) As Group_Concat_ccode
     From
         items
     Group By
         items.biblionumber) ITEMS_INFOS On ITEMS_INFOS.biblionumber = biblio_metadata.biblionumber
Where
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') <> 'FICTION' And
    ITEMS_INFOS.Group_Concat_ccode = 'FICTION'
Group By
    biblio_metadata.biblionumber
LIMIT 500



