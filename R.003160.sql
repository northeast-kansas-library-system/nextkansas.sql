/*
R.003160

----------

Name: GHW - Materials added in the previous calendar month
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-01-27 22:47:48
Modified on: 2023-02-10 16:22:53
Date last run: 2023-04-10 12:43:11

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of items added in the previous calendar month</p>
<ul><li>Only shows items added in the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped by biblio number and item number</li>
<li>sorted by home branch, shelving location, item type, collection code, call number, author, and title</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Partially replaces report 536</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3160&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



Select
  Concat(
    '<a ',
    'class="btn btn-success noprint" ',
    'style="color: white;" '
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">',
    items.biblionumber, 
    '</a>'
  ) As 'Link to title',
  Concat(
    "-", 
    Coalesce(items.barcode, "-"), 
    "-"
  ) As "Item barcode",
  branches.branchname As 'LIbrary',
  perm_locs.lib As 'Permanent location',
  If(
    locs.lib = perm_locs.lib, 
    '', 
    locs.lib
  ) As 'Current location',
  itemtypes.description As 'Item type',
  ccodes.lib As 'Collection code',
  items.itemcallnumber As 'Call number',
  biblio.author As 'Author',
  Concat_Ws(
    " ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) As 'Full title',
  items.dateaccessioned As 'Date added',
  items.price As 'Normal purchase price',
  items.replacementprice As 'Replacement price',
  items.timestamp As 'Last updated on'
From
  items Join
  biblio 
    On biblio.biblionumber = items.biblionumber Join 
  biblio_metadata 
    On biblio_metadata.biblionumber = biblio.biblionumber Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    From
      authorised_values
    Where
      authorised_values.category = 'CCODE'
  ) ccodes 
    On ccodes.authorised_value = items.ccode Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    From
      authorised_values
    Where
      authorised_values.category = 'LOC'
  ) locs 
    On locs.authorised_value = items.location 
  Left Join itemtypes 
    On itemtypes.itemtype = items.itype 
  Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    From
      authorised_values
    Where
      authorised_values.category = 'LOC'
  ) perm_locs 
    On perm_locs.authorised_value = items.permanent_location 
  Join branches 
    On items.holdingbranch = branches.branchcode 
    And items.homebranch = branches.branchcode
Where
  items.homebranch Like <<Choose your library|LBRANCH>> And
  Month(items.dateaccessioned) = Month(Now() - Interval 1 Month) And
  Year(items.dateaccessioned) = Year(Now() - Interval 1 Month)
Group By
  items.biblionumber,
  items.itemnumber
Order By
  'LIbrary',
  'Permanent location',
  'Item type',
  'Collection code',
  'Call number',
  'Author',
  'Full title'

























