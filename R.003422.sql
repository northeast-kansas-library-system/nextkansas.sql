/*
R.003422

----------

Name: 0025 - 2024_99_a_cy monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-02-04 21:38:26
Modified on: 2025-04-30 10:11:24
Date last run: 2026-01-06 15:27:55

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Monthly overview - total number of bibliographic records system-wide&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;Shows holdings count for the previous calendar month&lt;/li&gt; 
&lt;li&gt;For the entire Next Search Catalog consortium&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p&gt;Generates data for:&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;Total items owned on the last day of the month last month&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3422"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #overview #monthly_overview&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'DESCRIPTION' AS DESCRIPTION,
  'COUNT' AS COUNT
UNION  
SELECT 
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(&ast;) AS COUNT
FROM 
  biblio
WHERE 
  biblio.datecreated &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)

























