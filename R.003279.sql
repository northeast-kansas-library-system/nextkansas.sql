/*
R.003279

----------

Name: GHW - List / virtualshelf report 006 - Export list to spreadsheet
Created by: George Williams

----------

Group: Lists Module
     -

Created on: 2019-11-05 09:28:33
Modified on: 2024-01-17 12:06:21
Date last run: 2025-07-23 09:05:34

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Converts a list into a format that can be downloaded as spreadsheet&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Displays all items currently attached to a list&lt;/li&gt;
&lt;li&gt;at all libraries&lt;/li&gt;
&lt;li&gt;grouped by list number, biblionumber, and item barcode number&lt;/li&gt;
&lt;li&gt;sorted by home library, shelving location, item type, collection code, call number, author, and title&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Replaces report:&lt;/p&gt;
&lt;ul&gt;
&lt;li&gt;1746 - Shelf List from a Private List&lt;/li&gt;
&lt;li&gt;3021 - GHW - Print a list - variant&lt;/li&gt;
&lt;li&gt;3063 - GHW - Print list by ID number&lt;/li&gt;
&lt;/ul&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;A list's ID number will be the last 4 digits of the list's URL.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Items listed as "Unavailable" are either checked out or have a status of "Not for loan," one of the "Lost" statuses, one of the "Damaged" statuses, or a &lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Once the report has been run, click on the "Download" button and select "Comma separated text (.csv)" to download the results to your computer where the sheet can be opened in Excel and modified as you see fit.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3279&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  virtualshelves.shelfname,
  items.homebranch,
  locations.lib AS location,
  itypes.description AS item_type,
  ccodes.lib AS collection_code,
  items.itemcallnumber,
  biblio.author,
  REGEXP_REPLACE(
    Concat_Ws(" ",
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]')
    ), 
    '[[:space:]]+', 
    ' '
  ) AS FULL_TITLE,
  Concat("-", items.barcode, "-") AS barcode,
  If(
    (
      Coalesce(items.notforloan, 0) +
      Coalesce(items.damaged, 0) +
      Coalesce(items.itemlost, 0) +
      Coalesce(items.withdrawn, 0) +
      If(items.onloan IS NOT NULL, "1", "0")
    ) = 0, 
    "", 
    "Unavailable"
  ) AS AVAILABLE
FROM
  virtualshelfcontents
  JOIN biblio
    ON biblio.biblionumber = virtualshelfcontents.biblionumber
  JOIN items
    ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itypes
    ON itypes.itemtype = items.itype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) locations
    ON locations.authorised_value = items.location
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes
    ON ccodes.authorised_value = items.ccode
  JOIN biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN virtualshelves
    ON virtualshelfcontents.shelfnumber = virtualshelves.shelfnumber
WHERE
  virtualshelfcontents.shelfnumber = &lt;&gt; AND
  items.homebranch LIKE Concat("%", &lt;&gt;,"%")
GROUP BY
  items.barcode,
  virtualshelfcontents.shelfnumber,
  biblio.biblionumber
ORDER BY
  items.homebranch,
  location,
  item_type,
  collection_code,
  items.itemcallnumber,
  biblio.author,
  biblio.title

























