/*
R.003040

----------

Name: GHW - Request action logs by request ID
Created by: George Williams

----------

Group: -
     -

Created on: 2018-01-16 22:16:46
Modified on: 2025-10-27 10:22:11
Date last run: 2025-11-24 14:42:01

----------

Public: 0
Expiry: 300

----------

&lt;div&gt; 
&lt;p&gt;Shows action log entries for specific requests from the last 60 days&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows actions that happened within the last 60 days&lt;/li&gt;
&lt;li&gt;on the request you specify&lt;/li&gt;
&lt;li&gt;grouped and sorted by action log ID&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;Notes:&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Data from the action logs is purged once it is 60 days old.  This report cannot show you information about request modifications if those modifications happened more than 60 days ago.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Click here to run in a new window&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  action_logs.action_id,
  action_logs.timestamp,
  action_logs.user,
  action_logs.module,
  action_logs.action,
  action_logs.object,
  REPLACE(
    action_logs.info, 
    ',', 
    ','
  ) AS DESCRIPTION,
  action_logs.interface,
  CONCAT(
    'See who created/modified/cancelled the request'
  ) AS LINK
FROM
  action_logs
WHERE
  action_logs.module = "HOLDS" AND
  action_logs.object LIKE Concat('%', &lt;&gt;, '%')
GROUP BY
  action_logs.action_id
ORDER BY
  action_logs.action_id
  DESC

























