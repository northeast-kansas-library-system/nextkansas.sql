/*
R.003363

----------

Name: Sandbox - ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-11-09 22:24:51
Modified on: 2020-11-09 22:25:03
Date last run: 2020-11-11 16:58:47

----------

Public: 0
Expiry: 300

----------



----------
*/

Select
    biblio.biblionumber,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="e"]') As LOCATION,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') As ITYPE,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') As CCODE,
    ITEMCCODES.Group_Concat_ccode,
    ITEMLOCS.PERM,
    ICOUNT.Count_itemnumber
From
    biblio Join
    biblio_metadata On biblio_metadata.biblionumber = biblio.biblionumber Inner Join
    (Select
         items.biblionumber,
         Group_Concat(Distinct items.ccode Order By items.ccode) As Group_Concat_ccode
     From
         items
     Group By
         items.biblionumber
     Having
         Group_Concat(Distinct items.ccode Order By items.ccode) Like 'FICTION') ITEMCCODES On ITEMCCODES.biblionumber =
            biblio.biblionumber Inner Join
    (Select
         items.biblionumber,
         Count(Distinct items.itemnumber) As Count_itemnumber
     From
         items
     Group By
         items.biblionumber) ICOUNT On ICOUNT.biblionumber = biblio.biblionumber Inner Join
    (Select
         items.biblionumber,
         Group_Concat(Distinct Coalesce(items.permanent_location, 'ZBLANK') Order By Coalesce(items.permanent_location,
         'ZBLANK')) As PERM
     From
         items
     Group By
         items.biblionumber) ITEMLOCS On ITEMLOCS.biblionumber = biblio.biblionumber
Where
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="c"]') = 'BOOK' And
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="942"]/subfield[@code="h"]') = ''
Group By
    biblio.biblionumber,
    ITEMCCODES.Group_Concat_ccode,
    ITEMLOCS.PERM,
    ICOUNT.Count_itemnumber
LIMIT 500



