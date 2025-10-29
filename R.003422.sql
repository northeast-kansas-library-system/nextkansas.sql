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
Date last run: 2025-10-09 10:52:09

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
<p>Monthly overview - total number of bibliographic records system-wide</p> 
<ul><li>Shows holdings count for the previous calendar month</li> 
<li>For the entire Next Search Catalog consortium</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>Generates data for:</p> 
<ul> 
  <li>Total items owned on the last day of the month last month</li> 
</ul> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3422">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #overview #monthly_overview</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  'DESCRIPTION' AS DESCRIPTION,
  'COUNT' AS COUNT
UNION  
SELECT 
  'Total biblios on last day of last month' AS DESCRIPTION,
  count(*) AS COUNT
FROM 
  biblio
WHERE 
  biblio.datecreated &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1)

























