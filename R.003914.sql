/*
R.003914

----------

Name: Koha-us test
Created by: George Williams

----------

Group: -
     -

Created on: 2025-09-05 08:26:06
Modified on: 2025-09-05 11:55:34
Date last run: 2026-01-29 18:42:46

----------

Public: 0
Expiry: 300

----------



----------
*/



Select
  Concat_WS('', 
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    items.biblionumber,
    '\" target="_blank">Go to title</a>',
    '<br>&nbsp;<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/catalogue/moredetail.pl?biblionumber=',
    items.biblionumber,
    '&itemnumber=',
    items.itemnumber,
    '#item',
    items.itemnumber,
    '" target="_blank">Go to item</a>',
    '<br>&nbsp;<br>',
    '<a class="btn btn-default noprint" ',
    'href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    issues.borrowernumber,
    '" target="_blank">Go to borrower</a>'
    
  ) as LINKS,
  Concat_WS('', 
    '-',
    borrowers.cardnumber,
    '-'
  ) AS LIBRARY_CARD,
  borrowers.surname,
  categoriess.description,
  branchess.branchname As CHECKED_OUT_AT,
    Concat_WS('', 
    '-',
    items.barcode,
    '-'
  ) AS ITEM_BARCODE
  biblio.author,
  biblio.title,
  permanent_locs.lib As PERMANENT_LOCATION,
  locs.lib As SHELVING_LOCATION,
  itypes.description As ITME_TYPE,
  ccodes.lib As COLLECTION_CODE
From
  issues Join
  borrowers On issues.borrowernumber = borrowers.borrowernumber Left Join
  (Select
      categories.categorycode,
      categories.description
    From
      categories) categoriess On categoriess.categorycode = borrowers.categorycode Left Join
  (Select
      branches.branchcode,
      branches.branchname
    From
      branches) branchess On branchess.branchcode = issues.branchcode Inner Join
  items On issues.itemnumber = items.itemnumber Left Join
  biblio On items.biblionumber = biblio.biblionumber Left Join
  (Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'LOC') permanent_locs On permanent_locs.authorised_value = items.permanent_location
  Left Join
  (Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'LOC') locs On locs.authorised_value = items.location Left Join
  (Select
      itemtypes.itemtype,
      itemtypes.description
    From
      itemtypes) itypes On itypes.itemtype = items.itype Left Join
  (Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'CCODE') ccodes On ccodes.authorised_value = items.ccode
Where
  issues.branchcode IN <<Choose check-out branch|branches:in>> And
  borrowers.categorycode IN <<Choose borrower category|categorycode:in>> And
  items.permanent_location IN <<Choose item permanent shelving location|LOC:in>> And 
  items.location IN <<Choose item shelving location|LOC:in>> And 
  items.itype IN <<Choose item type|itemtypes:in>> And 
  items.ccode IN <<Choose item collection code|CCODE:in>>
Group By
  issues.issue_id

























