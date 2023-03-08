/*
R.003701

----------

Name: D1 Circulation by borrower details - Circulation by borrower category
Created by: George H Williams

----------

Group: Statistics
     2023 beginning of month statistics

Created on: 2023-02-10 09:36:34
Modified on: 2023-02-10 14:04:28
Date last run: 2023-03-01 00:45:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by borrower details - circulation by borrower category</p> 
<ul>
  <li>Shows circulation and renewal statistics grouped by borrower category</li> 
  <li>during the previous calendar month</li> 
  <li>At all Next Search Catalog libraries</li> 
  <li>grouped and sorted by library and borrower category</li> 
</ul>
<br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<p></p> 
<p></p> 
<p></p> 
<p></p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3701">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #borrower #details #borrower_category #circulation_by_borrower_details</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branchescategories.branchname AS 'Library', 
  branchescategories.description AS 'Borrower category', 
  CIR_RENEW_LM.count AS 'Total items checked out/renewed', 
  ADULT.count AS 'Adult items checked out/renewed', 
  YOUNG_ADULT.count AS 'Young-adult items checked out/renewed', 
  JUVENILE.count AS 'Juvenile items checked out/renewed', 
  OTHER.count AS 'Other items checked out/renewed' 
FROM 
  ( 
    SELECT 
      branches.branchcode, 
      branches.branchname, 
      categories.categorycode, 
      categories.description 
    FROM 
      branches, 
      categories 
    GROUP BY 
      branches.branchcode, 
      branches.branchname, 
      categories.categorycode, 
      categories.description 
  ) branchescategories 
    LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) CIR_RENEW_LM 
    ON CIR_RENEW_LM.CATEGORY_CODE = branchescategories.categorycode AND 
    CIR_RENEW_LM.branch = branchescategories.branchcode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%AD%" 
    GROUP BY 
      statistics.branch, 
      Coalesce(borrowers.categorycode, deletedborrowers.categorycode, 'ADULT') 
  ) ADULT 
    ON ADULT.branch = branchescategories.branchcode AND 
    ADULT.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE "%YA%" 
    GROUP BY 
      statistics.branch, 
      Coalesce(borrowers.categorycode, deletedborrowers.categorycode, 'ADULT') 
  ) YOUNG_ADULT 
    ON YOUNG_ADULT.branch = branchescategories.branchcode AND 
    YOUNG_ADULT.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) LIKE"%JU%" 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) JUVENILE 
    ON JUVENILE.branch = branchescategories.branchcode AND 
    JUVENILE.CATEGORY_CODE = branchescategories.categorycode LEFT JOIN 
  ( 
    SELECT 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) AS CATEGORY_CODE, 
      Count(*) AS count 
    FROM 
      statistics LEFT JOIN 
      items ON items.itemnumber = statistics.itemnumber LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber LEFT JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      ( 
        statistics.type = 'issue' OR 
        statistics.type = 'renew' 
      ) AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%AD%" AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD")) NOT LIKE "%YA%" AND 
      If( 
        Coalesce(statistics.location, "L_AD") = "CART", 
        Coalesce(items.permanent_location, "L_AD"), 
        Coalesce(statistics.location, "L_AD") 
      ) NOT LIKE "%JU%" 
    GROUP BY 
      statistics.branch, 
      Coalesce( 
        borrowers.categorycode, 
        deletedborrowers.categorycode, 
        'ADULT' 
      ) 
  ) OTHER 
    ON OTHER.branch = branchescategories.branchcode AND 
    OTHER.CATEGORY_CODE = branchescategories.categorycode 
GROUP BY 
  branchescategories.branchname, 
  branchescategories.description, 
  CIR_RENEW_LM.count, 
  ADULT.count, 
  YOUNG_ADULT.count, 
  JUVENILE.count, 
  OTHER.count 
ORDER BY 
  branchescategories.branchname, 
  branchescategories.description 

























