/*
R.002970

----------

Name: GHW - Collection Statistics - Items at a library
Created by: George H Williams

----------

Group: Catalog Records and Items
     Collection Statistics

Created on: 2017-07-03 14:36:44
Modified on: 2018-04-16 11:11:22
Date last run: 2021-07-08 15:53:24

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a count of items by home branch, shelving location, and collection code with totals by library and location code.</p>
<ul><li>Counts items currently in NExpress</li>
<li>at the library you specify</li>
<li>grouped and sorted by homebranch, location, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This will show all items owned by the selected library - including all items that are checked out, lost, missing, in mending, and withdrawn-but-not-deleted items.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2970&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  items.homebranch,
  items.location,
  ccodes.lib,
  Count(items.itemnumber) AS Count_itemnumber
FROM
  items
  LEFT JOIN (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON items.ccode = ccodes.authorised_value
WHERE
  items.homebranch Like <<Choose item home library|LBRANCH>>
GROUP BY
  items.homebranch,
  items.location,
  ccodes.lib
WITH ROLLUP



