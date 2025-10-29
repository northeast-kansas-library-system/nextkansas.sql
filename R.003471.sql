/*
R.003471

----------

Name: GHW - Replacement cost of library materials by Collection Code
Created by: George Williams

----------

Group: -
     -

Created on: 2021-03-03 15:29:51
Modified on: 2025-03-26 01:12:58
Date last run: 2025-10-24 17:16:12

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Shows replacement cost of collection</p>
<ul><li>Results are based on materials currently in the catalog</li>
<li>at the library, shelving location, and collection code you specify</li>
<li>grouped and sorted by library, shelving location, and collection code</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Updated in March of 2025 to link to 3879 instead of 2731.</p>
<p>This report will only return values based on the "Cost, replacement price" field in the item record (Marc subfield 952$v).  If no value is entered in this field, the value for that item will be $0.00.  If that field has been incorrectly entered, that incorrect value will be a part of the total.</p><br />
<p>Report 3362 can show you items at your library with a blank or 0 value "Cost, replacement price" field: <a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3362&phase=Run%20this%20report">click here to run report 3362</a></p>

<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3471&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/



SELECT
  branches.branchname AS LIBRARY,
  locs.lib AS SHELVING_LOCATION,
  ccodes.lib AS COLLECTION_CODE,
  Count(items.itemnumber) AS ITEM_COUNT,
  Coalesce(Sum(items.replacementprice), 0) AS REPLACEMENT_COST,
  Concat( 
    '', 
    'Shelflist for these items' 
  ) AS SHELFLIST 
FROM
  items 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode'
  ) ccodes 
    ON ccodes.authorised_value = Coalesce(items.ccode, "XXX") 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'loc'
  ) locs 
    ON locs.authorised_value = Coalesce(items.permanent_location, "PROC") 
  JOIN branches 
    ON items.homebranch = branches.branchcode
WHERE
  items.homebranch LIKE &lt;&gt; AND
  items.permanent_location LIKE &lt;&gt; AND
  items.ccode LIKE &lt;&gt;
GROUP BY
  branches.branchname,
  locs.lib,
  ccodes.lib

























