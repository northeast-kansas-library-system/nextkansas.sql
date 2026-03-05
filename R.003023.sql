/*
R.003023

----------

Name: GHW - Cronjob count
Created by: George Williams

----------

Group: -
     -

Created on: 2017-12-27 10:35:28
Modified on: 2024-01-17 11:52:19
Date last run: 2018-01-24 14:25:53

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Counts the number of times a specified cronjob has run in the previous 60 days&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Counts cronjobs run in the previuos 60 days&lt;/li&gt;
&lt;li&gt;system-wide&lt;/li&gt;
&lt;li&gt;grouped by date and cronjob name&lt;/li&gt;
&lt;li&gt;sorted by date - newest to oldest&lt;/li&gt;
&lt;li&gt;Contains links to report 3024 which allows you to see the specific times the cronjob ran on that date&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3023&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Date_Format(action_logs.timestamp, "%Y-%m-%d") AS DATE,
  action_logs.info,
  Count(action_logs.action_id) AS COUNT,
  Concat("See when this cronjob ran on this date") AS LINK
FROM
  action_logs
WHERE
  action_logs.module = 'CRONJOBS' AND
  action_logs.info LIKE &lt;&gt;
GROUP BY
  Date_Format(action_logs.timestamp, "%Y.%m.%d"),
  action_logs.info
ORDER BY
  DATE DESC, action_logs.info ASC

























