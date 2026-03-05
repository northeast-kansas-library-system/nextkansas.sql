/*
R.003731

----------

Name: GHW - Home library and item counts by first five digits of item barcode number
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-09 11:51:53
Modified on: 2024-01-17 11:14:29
Date last run: 2023-06-09 11:55:24

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Counts items by the first five digits of item barcode number.</p>
  <ul>
    <li>counts items currently in the catalog</li>
    <li>at all libraries</li>
    <li>grouped by first five digits of item barcode number and library</li>
    <li>sorted by first five digits of item barcode number</li>
  </ul><br />
  <p></p>
  <p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3731">Click here to download as a csv file</a></p>
  <p class= "notetags" style="display: none;">#barcode #items #prefix</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT
  Left(items.barcode, 5) AS FIRST_5_DIGITS_OF_ITEM_BARCODE,
  branches.branchname AS LIBRARY_NAME,
  Count(items.itemnumber) AS ITEM_COUNT
FROM
  branches JOIN
  items ON items.homebranch = branches.branchcode
GROUP BY
  Left(items.barcode, 5),
  branches.branchname
ORDER BY
  barcode

























