/*
R.003422

----------

Name: GHW - A5 Monthly overview - Biblios total - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-02-04 21:38:26
Modified on: 2022-03-10 15:02:17
Date last run: 2022-10-01 00:25:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
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
<p class= "notetags" style="display: none;">#monthly #statistics #overview</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  'Total biblios on last day of last month' AS DESCRIPTION, 
  count(*) AS COUNT 
FROM 
  biblio 
WHERE 
  biblio.datecreated < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 

























