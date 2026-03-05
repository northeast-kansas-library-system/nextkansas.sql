/*
R.003261

----------

Name: GHW - Deleted items list by date the item was marked "Lost"
Created by: George Williams

----------

Group: -
     -

Created on: 2019-09-10 10:46:16
Modified on: 2024-01-17 12:08:55
Date last run: 2023-10-31 10:24:32

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Lists items that have been marked as lost and have been deleted&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items marked lost during the date range you specify that have already been deleted&lt;/li&gt;
&lt;li&gt;at the library you specify&lt;/li&gt;
&lt;li&gt;grouped by item number&lt;/li&gt;
&lt;li&gt;sorted in the standard Next classification order&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3261&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  deleteditems.barcode,
  deleteditems.homebranch,
  deleteditems.holdingbranch,
  location.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccode.lib AS CCODE,
  deleteditems.itemcallnumber,
  Coalesce(biblio.author, deletedbiblio.author) AS AUTHOR,
  Coalesce(biblio.title, deletedbiblio.title) AS TITLE,
  deleteditems.price,
  deleteditems.replacementprice,
  deleteditems.timestamp AS DELETED_ON,
  losts.lib,
  deleteditems.itemlost_on,
  deleteditems.withdrawn,
  deleteditems.withdrawn_on
FROM
  deleteditems
  LEFT JOIN biblio
    ON deleteditems.biblionumber = biblio.biblionumber
  LEFT JOIN deletedbiblio
    ON deleteditems.biblionumber = deletedbiblio.biblionumber
  LEFT JOIN itemtypes
    ON deleteditems.itype = itemtypes.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) ccode
    ON deleteditems.ccode = ccode.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    GROUP BY
      authorised_values.authorised_value,
      authorised_values.lib
  ) location
    ON deleteditems.location = location.authorised_value
  LEFT JOIN (
    SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) losts
    ON losts.authorised_value = deleteditems.itemlost
WHERE
  deleteditems.homebranch LIKE &lt;&gt; AND
  Coalesce(deleteditems.location, "-") LIKE &lt;&gt; AND
  Coalesce(deleteditems.itype, "-") LIKE &lt;&gt; AND
  Coalesce(deleteditems.ccode, "-") LIKE &lt;&gt; AND
  deleteditems.itemlost_on BETWEEN &lt;&gt; AND (&lt;&gt; + INTERVAL 1 DAY)
GROUP BY
  deleteditems.itemnumber
ORDER BY
  deleteditems.homebranch,
  LOCATION,
  ITYPE,
  CCODE,
  AUTHOR,
  TITLE,
  deleteditems.itemcallnumber

























