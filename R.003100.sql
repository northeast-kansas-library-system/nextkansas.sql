/*
R.003100

----------

Name: GHW - Last borrower informatin to be deleted
Created by: George Williams

----------

Group: -
     -

Created on: 2018-07-02 17:18:28
Modified on: 2024-01-17 11:57:56
Date last run: 2022-08-24 17:36:48

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows id numbers from rows in items_last_borrower table that should be deleted.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows items_last_borrowed id numbers where the item is not lost/damaged/withdrawn and the item was returned more than 13 months ago.&lt;/li&gt;
&lt;li&gt;on items at all libraries&lt;/li&gt;
&lt;li&gt;grouped by id number&lt;/li&gt;
&lt;li&gt;sorted by id number&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3100&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  items_last_borrower.id AS ITEMS_LAST_BORROWER_ID
FROM
  items_last_borrower
  JOIN items ON items_last_borrower.itemnumber = items.itemnumber
WHERE
  items_last_borrower.created_on &lt; (Date_Sub(Date(Now()), INTERVAL DayOfWeek(Now()) + 7 DAY) + INTERVAL 1 WEEK) - INTERVAL 13 MONTH AND
  Coalesce(items.damaged, "0") = 0 AND
  Coalesce(items.itemlost, "0") = 0 AND
  Coalesce(items.withdrawn, "0") = 0
GROUP BY
  items_last_borrower.id
ORDER BY
  items_last_borrower.created_on

























