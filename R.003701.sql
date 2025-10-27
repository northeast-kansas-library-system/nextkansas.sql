/*
R.003701

----------

Name: 0045 - 2024_99_d_circulation_borrower_category monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2023-02-10 09:36:34
Modified on: 2025-04-30 10:53:14
Date last run: 2025-10-02 00:45:02

----------

Public: 0
Expiry: 300

----------

 
Circulation by borrower details - circulation by borrower category 

  Shows circulation and renewal statistics grouped by borrower category 
  during the previous calendar month 
  At all Next Search Catalog libraries 
  grouped and sorted by library and borrower category 

 
Notes: 
 
 
 
 
 
 
Click here to download as a csv file 
#monthly #statistics #borrower #details #borrower_category #circulation_by_borrower_details 
 
 

----------
*/



SELECT 
  'Library' AS 'Library',  
  'Borrower category' AS 'Borrower category',  
  'Total items checked out/renewed' AS 'Total items checked out/renewed',  
  'Adult items checked out/renewed' AS 'Adult items checked out/renewed',  
  'Young-adult items checked out/renewed' AS 'Young-adult items checked out/renewed',  
  'Juvenile items checked out/renewed' AS 'Juvenile items checked out/renewed',  
  'Other items checked out/renewed' AS 'Other items checked out/renewed'
UNION 
(SELECT 
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
  branchescategories.description )

























