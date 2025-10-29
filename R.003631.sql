/*
R.003631

----------

Name: GHW - items received from transfer
Created by: George Williams

----------

Group: -
     -

Created on: 2021-12-22 15:50:13
Modified on: 2025-02-18 11:16:24
Date last run: 2025-02-18 11:16:36

----------

Public: 0
Expiry: 300

----------

<div class="reportInfo noprint" id="reportinfo"> 
 
  <div class="reportInfoContent"> 
 
    <p>Gives a count of items received from transfers</p> 
 
    <ul> 
      <li>received during the date range you specify</li> 
      <li>received at the library you specify</li> 
      <li>grouped by receiving library, date and time arrived, date arrived, and date range</li> 
      <li>sorted by receiving library, date and time arrived</li> 
    </ul> 
 
  </div> 
 
  <div class="reportInfoNotes"> 
 
    <p> 
 
    </p> 
 
    <p> 

    </p> 
 
    <p> 
 
    </p> 
 
  </div> 
 
  <div id="reportInfoLinks"> 
 
    <!-- Can't be linked because the report requires runtime parameters -->
 
  </div> 
 
  <div id="reportInfoTags"> 
 
    <p style="display: none;"> 
      #transfers
      #received
      #count of items
    </p> 
 
  </div> 
 
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
 
</div> 

----------
*/



SELECT
  branches.branchname AS TO_BRANCH,
  Date_Format(branchtransfers.datearrived, "%W") AS DAY,
  Date_Format(branchtransfers.datearrived, "%Y-%m-%d--%H:%i") AS DATE_TIME,
  Count(branchtransfers.branchtransfer_id) AS COUNT_OF_ITEMS_RECEIVED,
  '' DAILY_ITEMS_RECEIVED,
  '' DATE_RANGE_ITEMS_RECEIVED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.tobranch
WHERE
  branchtransfers.tobranch Like &lt;&gt; AND
  branchtransfers.datearrived BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  Date_Format(branchtransfers.datearrived, "%Y-%m-%d--%H:%i"),
  branchtransfers.tobranch
UNION
(SELECT
  branches.branchname AS TO_BRANCH,
  Date_Format(branchtransfers.datearrived, "%W") AS DAY,
  Concat_Ws('', Date_Format(branchtransfers.datearrived, "%Y-%m-%d"), ' - Daily Total') AS DATE_TIME,
  '' AS COUNT_OF_ITEMS_RECEIVED,
  Count(branchtransfers.branchtransfer_id) AS DAILY_ITEMS_RECEIVED,
  '' DATE_RANGE_ITEMS_RECEIVED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.tobranch
WHERE
  branchtransfers.tobranch Like &lt;&gt; AND
  branchtransfers.datearrived BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  DATE_TIME,
  branchtransfers.tobranch)
UNION
(SELECT
  branches.branchname AS TO_BRANCH,
  '' AS DAY,
  ' Total for date range' AS DATE_TIME,
  '' AS COUNT_OF_ITEMS_RECEIVED,
  '' DAILY_ITEMS_RECEIVED,
  Count(branchtransfers.branchtransfer_id) AS NUMBER_OF_ITEMS_RECEIVED
FROM
  branchtransfers JOIN
  branches ON branches.branchcode = branchtransfers.tobranch
WHERE
  branchtransfers.tobranch Like &lt;&gt; AND
  branchtransfers.datearrived BETWEEN &lt;&gt; AND (&lt;&gt; + interval 1 day)
GROUP BY
  DATE_TIME,
  branchtransfers.tobranch)
ORDER BY
  TO_BRANCH ASC,
  DATE_TIME DESC

























