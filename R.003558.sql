/*
R.003558

----------

Name: GHW - Count of items by barcode number length
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-08 16:19:14
Modified on: 2021-09-08 17:52:29
Date last run: 2021-09-08 17:56:40

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Counts all items at a library based on the length of their barcode numbers</p>
<ul><li>Lists current data</li>
<li>At the library you specify</li>
<li>grouped and sorted by the name of the library and the length of the barcode numbers</li>
<li>links to report 3557 which lists all of the items at a library with a specified barcode number length</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Can be used to identified errors made when items are entered with an incorrect barcode number</p>
<p></p>
<p class= "notetags" style="display: none;">#item barcode #length #barcode count</p>
</div>

----------
*/

SELECT
  branches.branchname,
  Coalesce(Length(items.barcode), 0) AS ITEM_BARCODE_LENGTH,
  Count(DISTINCT items.itemnumber) AS ITEM_BARCODE_COUNT,
  CONCAT(
    '<a class= "clicked" href=\"/cgi-bin/koha/reports/guided_reports.pl?reports=3557&phase=Run+this+report&param_name=Choose+your+library|ZBRAN&sql_params=',
    items.homebranch,
    '&param_name=Enter+barcode+length&sql_params=',
    Coalesce(Length(items.barcode), 0),
    '" target="_blank">List of items</a>'
  ) AS LINK_TO_FULL_LIST
FROM
  items JOIN
  branches ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE <<Choose your library|ZBRAN>>
GROUP BY
  branches.branchname,
  Length(items.barcode)



