/*
R.003279

----------

Name: GHW - List / virtualshelf report 006 - Export list to spreadsheet
Created by: George H Williams

----------

Group: Lists Module
     -

Created on: 2019-11-05 09:28:33
Modified on: 2019-11-07 14:19:49
Date last run: 2022-10-20 15:12:37

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class='noprint'>
<p>Converts a list into a format that can be downloaded as spreadsheet</p>
<ul><li>Displays all items currently attached to a list</li>
<li>at all libraries</li>
<li>grouped by list number, biblionumber, and item barcode number</li>
<li>sorted by home library, shelving location, item type, collection code, call number, author, and title</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces report:</p>
<ul>
<li>1746 - Shelf List from a Private List</li>
<li>3021 - GHW - Print a list - variant</li>
<li>3063 - GHW - Print list by ID number</li>
</ul>
<p></p>
<p>A list's ID number will be the last 4 digits of the list's URL.</p>
<p></p>
<p>Items listed as "Unavailable" are either checked out or have a status of "Not for loan," one of the "Lost" statuses, one of the "Damaged" statuses, or a </p>
<p></p>
<p>Once the report has been run, click on the "Download" button and select "Comma separated text (.csv)" to download the results to your computer where the sheet can be opened in Excel and modified as you see fit.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3279&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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
  virtualshelfcontents.shelfnumber = <<Enter list number>> AND
  items.homebranch LIKE Concat("%", <<Choose your library|LBRANCH>>,"%")
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

























