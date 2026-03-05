/*
R.003768

----------

Name: GHW - Monthly system wide statistics - Count of biblios added and deleted in the previous calendar month
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-13 17:04:41
Modified on: 2024-01-17 11:17:55
Date last run: 2023-10-16 14:26:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Generates a count of biblios added and deleted in the previous calendar month&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;Counts biblios added in the previous calendar month&lt;/li&gt; 
      &lt;li&gt;At all libraries&lt;/li&gt; 
      &lt;li&gt;grouped and sorted by library name&lt;/li&gt; 
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
    &lt;p&gt; 
     To be folded into 2024 spreadsheet. 
    &lt;/p&gt; 
 
    &lt;p&gt; 
      If the library of the user that created or deleted a record cannot be determined, the creation/deletion is assigned to NEKLS 
    &lt;/p&gt; 
   
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
    &lt;p id="sql_quick_down"&gt; 
      &lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3768"&gt; 
        Click here to download as a csv file 
      &lt;/a&gt; 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #statistics 
      #monthly statistics 
      #biblio count 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt; 

----------
*/



SELECT 
  branchess.branchname, 
  total_added.Count_action_id AS BIBLIOS_ADDED, 
  total_deleted.Count_action_id AS BIBLIOS_DELETED 
FROM 
  ( 
    SELECT 
      branches.branchcode, 
      branches.branchname 
    FROM 
      branches 
  ) branchess 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, 'NEKLS') AS branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'CATALOGUING' AND 
      action_logs.action = 'ADD' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.info = 'biblio' 
    GROUP BY 
      Coalesce(borrowers.branchcode, 'NEKLS') 
   ) total_added 
    ON total_added.branchcode = branchess.branchcode 
  LEFT JOIN 
  ( 
    SELECT 
      Coalesce(borrowers.branchcode, 'NEKLS') AS branchcode, 
      Count(action_logs.action_id) AS Count_action_id 
    FROM 
      action_logs LEFT JOIN 
      borrowers ON borrowers.borrowernumber = action_logs.user 
    WHERE 
      action_logs.module = 'CATALOGUING' AND 
      action_logs.action LIKE 'DELE%' AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      action_logs.info = 'biblio' 
    GROUP BY 
      Coalesce(borrowers.branchcode, 'NEKLS') 
  ) total_deleted 
    ON total_deleted.branchcode = branchess.branchcode 
GROUP BY 
  branchess.branchname 

























