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
Date last run: 2026-01-16 15:46:58

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of items added in the previous calendar month&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Only shows items added in the previous calendar month&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by biblio number and item number&lt;/li&gt;
&lt;li&gt;sorted by home branch, shelving location, item type, collection code, call number, author, and title&lt;/li&gt;
&lt;li&gt;contains links to the item's bibliographic record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Partially replaces report 536&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Updated on 2023.07.21 to fix a home library/holding library issue&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3160&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT 
  Concat( 
    '', 
    items.biblionumber, 
    '' 
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
  items.homebranch Like &lt;&gt; And 
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

























