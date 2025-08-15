/*
R.003898

----------

Name: GHW - frameworks  - 020 - 022 - 024
Created by: George Williams

----------

Group: -
     -

Created on: 2025-07-21 23:27:13
Modified on: 2025-07-21 23:44:32
Date last run: 2025-08-12 10:22:55

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  biblio.biblionumber,
  biblio.frameworkcode,
  bib_loc.lib As LOCATION,
  bib_itype.description As ITYPE,
  bib_ccode.lib As CCODE,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="h"]'
    ),
    ExtractValue(
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="b"]'
    ),
    ExtractValue(
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="n"]'
    ),
    ExtractValue(
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="p"]'
    )
  ) As FULL_TITLE,
  Group_Concat(Distinct 
    items.homebranch 
    ORDER BY items.homebranch 
    SEPARATOR ' / '
  ) As Group_Concat_homebranch
From
  biblio Join
  biblio_metadata 
    On biblio_metadata.biblionumber = biblio.biblionumber Join
  biblioitems 
    On biblioitems.biblionumber = biblio.biblionumber Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'LOC'
    Group By
      authorised_values.authorised_value
  ) bib_loc 
    On bib_loc.authorised_value = biblioitems.agerestriction Left Join
  (
    Select
      itemtypes.itemtype,
      itemtypes.description
    From
      itemtypes
    Group By
      itemtypes.itemtype
  ) bib_itype 
    On bib_itype.itemtype = biblioitems.itemtype Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'CCODE'
    Group By
      authorised_values.authorised_value
  ) bib_ccode 
    On bib_ccode.authorised_value = biblioitems.cn_class Join
  items 
    On items.biblionumber = biblio.biblionumber
WHERE 
  biblio.frameworkcode LIKE '%'
Group By
  biblio.biblionumber
ORDER BY
  LOCATION,
  ITYPE,
  CCODE,
  biblio.author,
  FULL_TITLE

























