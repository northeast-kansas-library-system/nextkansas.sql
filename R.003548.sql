/*
R.003548

----------

Name: GHW - E2 Borrower statistics - borrower count by zip code - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-08-04 16:23:25
Modified on: 2022-03-10 17:21:49
Date last run: 2022-12-01 01:00:01

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Borrower statistics - borrower count by zip code</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by checkout-library and borrower zipcode</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
<p></p> 
<ul> 
  <li>ZIPCODE = borrower's zip code trimmed to 5 digits</li> 
  <li>BORROWER_COUNT = count of all borrowers with this home library and this zip code</li> 
  <li>RENEWED_LM= count of borrowers with this home library that were renewed last month</li> 
  <li>ADDED_LM = count of borrowers with this home library that were added last month</li> 
  <li>DELETED_LM = count of borrowers with this home library that were deleted last month</li> 
</ul> 
<p></p> 
<ul> 
  <li>Zip codes on borrower records are only as accurate as the staff members who entered those zip codes into the borrower records.  There are hundreds of incorrect and non-standard zip codes in the borrower data.</li> 
  <li>All zip codes are trimmed to 5 digits</li> 
  <li>If BORROWER_ZIPCODE = "-" that means there are less than 10 borrowers with that zip code system-wide<br />in order to protect borrower privacy, if there are fewer than 10 borrowers in a zip code, that zip code will be hidden.</li> 
  <li>If BORROWER_ZIPCODE = "0" that means that the zipdcode that has been left blank, that zipcode contains nothing but spaces, or that zipcode is set to zero</li> 
</ul> 
<p></p> 
<p class="updated">This report and these notes updated on 2022.03.10</p> 
<p></p> 
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3548">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #borrower #count #zipcode</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches.branchname, 
  If( 
    zipcounts.Count_borrowernumber < 10, 
    '-', 
    If( 
      branchcodeszipss.ZIPCODE = '', 
      '0', 
      branchcodeszipss.ZIPCODE 
    ) 
  ) AS ZIP_CODE, 
  Sum(DISTINCT Coalesce(totals.Count_borrowernumber, 0)) AS BORROWER_COUNT, 
  Sum(DISTINCT renewed_lm.Count_borrowernumber) AS RENEWED_LM, 
  Sum(DISTINCT added_lm.Count_borrowernumber) AS ADDED_LM, 
  Sum(DISTINCT deleted_lm.Count_borrowernumber) AS DELETED_LM 
FROM 
    (SELECT 
      borrowers.branchcode AS BRANCHCODE, 
      Left(Trim(borrowers.zipcode), 5) AS ZIPCODE 
    FROM 
      borrowers 
    GROUP BY 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) 
    UNION 
    SELECT 
      deletedborrowers.branchcode AS BRANCHCODE, 
      Left(Trim(deletedborrowers.zipcode), 5) AS ZIPCODE 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode, 
      Left(Trim(deletedborrowers.zipcode), 5) 
    ORDER BY 
      BRANCHCODE, 
      ZIPCODE 
    ) branchcodeszipss 
  JOIN branches ON 
    branchcodeszipss.BRANCHCODE = branches.branchcode LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) AS zipcode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    GROUP BY 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5)) totals ON totals.branchcode = 
      branchcodeszipss.BRANCHCODE AND 
      totals.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) AS zipcode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    WHERE 
      Year(borrowers.dateenrolled) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(borrowers.dateenrolled) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) 
    ) added_lm 
  ON added_lm.branchcode = branchcodeszipss.BRANCHCODE AND 
    added_lm.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN 
    (SELECT 
      deletedborrowers.branchcode, 
      Left(Trim(deletedborrowers.zipcode), 5) AS zipcode, 
      Count(deletedborrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      action_logs JOIN 
      deletedborrowers ON deletedborrowers.borrowernumber = action_logs.object 
    WHERE 
      action_logs.module = 'MEMBERS' AND 
      Month(action_logs.timestamp) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(action_logs.timestamp) = Year(Now() - INTERVAL 1 MONTH) AND 
      action_logs.action LIKE 'DELET%' 
    GROUP BY 
      deletedborrowers.branchcode, 
      Left(Trim(deletedborrowers.zipcode), 5) 
    ) deleted_lm 
  ON deleted_lm.branchcode = branchcodeszipss.BRANCHCODE AND 
    deleted_lm.zipcode = branchcodeszipss.ZIPCODE LEFT JOIN 
    (SELECT 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) AS zipcode, 
      Count(borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    WHERE 
      Year(borrowers.date_renewed) = Year(Now() - INTERVAL 1 MONTH) AND 
      Month(borrowers.date_renewed) = Month(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      borrowers.branchcode, 
      Left(Trim(borrowers.zipcode), 5) 
    ) renewed_lm 
  ON renewed_lm.branchcode = branchcodeszipss.BRANCHCODE AND 
    renewed_lm.zipcode = branchcodeszipss.ZIPCODE JOIN 
    (SELECT 
      Left(Trim(borrowers.zipcode), 5) AS ZIP, 
      Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    GROUP BY 
      Left(Trim(borrowers.zipcode), 5) 
  ) zipcounts ON zipcounts.ZIP = branchcodeszipss.ZIPCODE 
GROUP BY 
  branches.branchname, 
  If( 
    zipcounts.Count_borrowernumber < 10, 
    '-', 
    If( 
      branchcodeszipss.ZIPCODE = '', 
      '0', 
      branchcodeszipss.ZIPCODE 
    ) 
  ) 

























