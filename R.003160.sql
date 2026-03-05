/*
R.003160

----------

Name: GHW - Materials added in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2019-01-27 22:47:48
Modified on: 2024-01-17 12:11:47
Date last run: 2026-02-20 12:37:27

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
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
<p>Updated on 2023.07.21 to fix a home library/holding library issue</p>
<p></p>
<p id="rquickopen"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3160&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT 
  Concat( 
    '<a ', 
    'class="btn btn-success noprint" ', 
    'style="color: white;" ', 
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>' 
  ) AS 'Link to title', 
  Concat("-", Coalesce(items.barcode, "-"), "-") AS "Item barcode", 
  branches.branchname AS 'Library', 
  perm_locs.lib AS 'Permanent location', 
  If(locs.lib = perm_locs.lib, '', locs.lib) AS 'Current location', 
  itemtypes.description AS 'Item type', 
  ccodes.lib AS 'Collection code', 
  items.itemcallnumber AS 'Call number', 
  biblio.author AS 'Author', 
  Concat_Ws( 
    " ", 
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
      '//datafield[@tag="245"]/subfield[@code="p"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="n"]' 
    ) 
  ) AS 'Full title', 
  items.dateaccessioned AS 'Date added', 
  items.price AS 'Normal purchase price', 
  items.replacementprice AS 'Replacement price', 
  items.timestamp AS 'Last updated on' 
FROM items 
  JOIN biblio ON biblio.biblionumber = items.biblionumber 
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'CCODE' 
  ) ccodes ON ccodes.authorised_value = items.ccode 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) locs ON locs.authorised_value = items.location 
  LEFT JOIN itemtypes ON itemtypes.itemtype = items.itype 
  LEFT JOIN ( 
    SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib 
    FROM authorised_values 
    WHERE authorised_values.category = 'LOC' 
  ) perm_locs ON perm_locs.authorised_value = items.permanent_location 
  JOIN branches ON items.homebranch = branches.branchcode 
WHERE 
  items.homebranch Like <<Choose your library|LBRANCH>> And 
  Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) AND 
  Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
GROUP BY 
  items.biblionumber, 
  items.itemnumber 
ORDER BY 
  'Library', 
  'Permanent location', 
  'Item type', 
  'Collection code', 
  'Call number', 
  'Author', 
  'Full title' 

























