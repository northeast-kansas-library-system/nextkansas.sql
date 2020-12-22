/*
R.003359

----------

Name: GHW - Requests picked up or cancelled during the previous calendar month
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-21 23:06:16
Modified on: 2020-10-22 00:49:08
Date last run: 2020-12-03 19:53:20

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>List of requested titles picked up or cancelled in the previous calendar month</p>
<ul><li>Shows requests in the previous calendar month</li>
<li>at the request pickup library you specify</li>
<li>grouped by reserveid number</li>
<li>sorted by the pickup library plus the normal Next classification order</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>If a request shows up in this report with no classification information it's because no specific item was ever assigned to fill this request.  This can happen in several situations.</p>
<ul>
<li>The first situation would be if a title level request was placed and then cancelled before an available item reached the top of the requests queue</li>
<li>The second situation would be if a request was placed and an item was checked out to the borrower that filled that request before an available item reached the top of the requests queue</li>
<li>The third situation would be if an item was checked out to the borrower that was deleted after the item was returned but before this report was run</li>
</ul>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3359&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">#requests</p>
</div>

----------
*/

SELECT
  old_reserves.branchcode AS PICK_UP_LIBRARY,
  Concat_WS(" / ",
    If(
      old_reserves.found = "F", 
      "Request filled", 
      If(old_reserves.itemnumber > 1, "Request not picked up", "Cancelled before being held")
    ),
    DATE_FORMAT(old_reserves.timestamp, "%Y.%m.%d")
  ) AS FILLED,
  items.homebranch,
  LOCATIONS.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  CCODES.lib AS CCODE,
  If(
    old_reserves.found = "F", 
    Coalesce(items.itemcallnumber, "Item delted -OR- item was borrowed before request was filled"),
    items.itemcallnumber
  ) AS ITEM_CALL_NUMBER,
  biblio.author,
  biblio.title
FROM
  old_reserves JOIN
  biblio ON old_reserves.biblionumber = biblio.biblionumber LEFT JOIN
  items ON old_reserves.itemnumber = items.itemnumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') CCODES ON CCODES.authorised_value =
      items.ccode LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') LOCATIONS ON
      LOCATIONS.authorised_value = items.permanent_location
WHERE
  old_reserves.branchcode LIKE <<Choose your library|ZBRAN>> AND
  Year(old_reserves.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND
  Month(old_reserves.timestamp) = Month(Now() - INTERVAL 1 MONTH)
GROUP BY
  old_reserves.reserve_id
ORDER BY
  old_reserves.branchcode,
  items.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  ITEM_CALL_NUMBER,
  biblio.author,
  biblio.title



