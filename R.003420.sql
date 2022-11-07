/*
R.003420

----------

Name: GHW - A3 Monthly overview - Borrowers - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-02-04 17:10:37
Modified on: 2022-03-10 14:58:24
Date last run: 2022-11-01 00:15:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Monthly overview - borrower statistics</p> 
<ul><li>Shows borrower counts for the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by branch name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>Generates data for:</p> 
<ul> 
  <li>BORROWER_ACCT_USED_LM = number of borrower accounts used to check out materials last month</li> 
  <li>TOTAL_BORROWERS = number of total borrowers with this home library</li> 
  <li>B_ADDED_LM = number of borrowers with this home library added last month</li> 
  <li>B_RENEWED_LM = number of borrowers with this home library renewed last month</li> 
  <li>B_DELETED_LM = number of borrowers with this home library deleted last month</li> 
</ul> 
<p></p> 
<p>These counts are current at the time the report is run (which for Next Search Catalog is usually between 12:01 a.m. and 4:00 a.m. on the first day of the month).</p> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3420">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #overview</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches.branchname, 
  Coalesce(ACCT_USED.count, 0) AS BORROWER_ACCT_USED_LM, 
  Coalesce(BORROWERS1.COUNT, 0) AS TOTAL_BORROWERS, 
  Coalesce(BORROWERSA.COUNT, 0) AS B_ADDED_LM, 
  Coalesce(BORROWERSR.COUNT, 0) AS B_RENEWED_LM, 
  Coalesce(BORROWESD.COUNT, 0) AS B_DELETED_LM 
FROM 
  branches LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      borrowers.dateenrolled < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERS1 
  ON branches.branchcode = BORROWERS1.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSA 
  ON branches.branchcode = BORROWERSA.branchcode LEFT JOIN 
    (SELECT 
      deletedborrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode 
    ) BORROWESD 
  ON branches.branchcode = BORROWESD.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Count(*) AS COUNT 
    FROM 
      borrowers 
    WHERE 
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode 
    ) BORROWERSR 
  ON branches.branchcode = BORROWERSR.branchcode LEFT JOIN 
    (SELECT 
      statistics.branch, 
      Count(DISTINCT statistics.borrowernumber) AS count 
    FROM 
      statistics 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew' OR 
        statistics.type = 'localuse') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch 
    ) ACCT_USED 
  ON ACCT_USED.branch = branches.branchcode 
GROUP BY 
  branches.branchname 
ORDER BY 
  branches.branchname 

























