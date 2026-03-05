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

&lt;div class="reportInfo noprint" id="reportinfo"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Gives a count of items received from transfers&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;received during the date range you specify&lt;/li&gt; 
      &lt;li&gt;received at the library you specify&lt;/li&gt; 
      &lt;li&gt;grouped by receiving library, date and time arrived, date arrived, and date range&lt;/li&gt; 
      &lt;li&gt;sorted by receiving library, date and time arrived&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
    &lt;p&gt; 

    &lt;/p&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
    &lt;!-- Can't be linked because the report requires runtime parameters --&gt;
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #transfers
      #received
      #count of items
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt; 

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

























