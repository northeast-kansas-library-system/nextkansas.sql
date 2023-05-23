/*
R.003418

----------

Name: A1 Monthly overview - Items and holdings
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2021-02-04 16:34:33
Modified on: 2023-02-10 14:06:52
Date last run: 2023-05-01 16:34:04

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Monthly overview - collection statistics</p> 
<ul><li>Shows item and holding counts for the previous calendar month</li> 
<li>At all Next Search Catalog libraries</li> 
<li>grouped and sorted by branch name</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p>Generates data for:</p> 
<ul> 
  <li>START_I = number of items owned on the first of the month</li> 
  <li>END_I = number of items owned on the last day of the month</li> 
  <li>ITEMS_ADD_L_M = items added last month</li> 
  <li>ITEMS_DEL_L_M = items deleted last month</li> 
  <li>TOTAL_HOLDINGS = number of bibliographic records where at least 1 item was held at this library on the first of the month</li> 
</ul> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3418">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #overview #monthly_overview</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches.branchname AS BRANCH, 
  Coalesce(Sum(DISTINCT START_ITEMS.count), 0) AS START_I, 
  Coalesce(Sum(DISTINCT END_ITEMS.count), 0) AS END_I, 
  Coalesce(Sum(DISTINCT ITEMS_ADDED.count), 0) AS ITEMS_ADD_L_M, 
  Coalesce(ITEMS_DELETED.count, 0) AS ITEMS_DEL_L_M, 
  Coalesce(Sum(DISTINCT TOTAL_HOLDINGS.count), 0) AS TOTAL_HOLDINGS 
FROM branches 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) START_ITEMS ON branches.branchcode = START_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) END_ITEMS ON branches.branchcode = END_ITEMS.homebranch 
  LEFT JOIN ( 
    SELECT 
      items.homebranch, 
      Count(*) AS count 
    FROM items 
    WHERE Month(items.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(items.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.dateaccessioned) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.dateaccessioned) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_ADDED ON branches.branchcode = ITEMS_ADDED.homebranch 
  LEFT JOIN ( 
    SELECT 
      deleteditems.homebranch, 
      Count(*) AS count 
    FROM deleteditems 
    WHERE Month(deleteditems.timestamp) = Month(Now() - INTERVAL 1 MONTH) 
      AND Year(deleteditems.timestamp) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY deleteditems.homebranch 
  ) ITEMS_DELETED ON branches.branchcode = ITEMS_DELETED.homebranch 
  LEFT JOIN ( 
    SELECT items.homebranch, 
      Count(DISTINCT items.biblionumber) AS count 
    FROM items 
    WHERE items.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY items.homebranch 
    UNION 
    SELECT 
      deleteditems.homebranch, 
      Count(DISTINCT deleteditems.biblionumber) AS count 
    FROM deleteditems 
    WHERE deleteditems.dateaccessioned < AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
      AND deleteditems.timestamp >= AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1) 
    GROUP BY deleteditems.homebranch 
  ) TOTAL_HOLDINGS ON branches.branchcode = TOTAL_HOLDINGS.homebranch 
GROUP BY branches.branchname 
ORDER BY BRANCH 

























