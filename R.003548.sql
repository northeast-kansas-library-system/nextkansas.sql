/*
R.003548

----------

Name: 0105 - 2024_99_e_borrower_count_zipcode monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-08-04 16:23:25
Modified on: 2025-04-30 11:34:51
Date last run: 2026-01-01 01:05:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Borrower statistics - borrower count by zip code&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;during the previous calendar month&lt;/li&gt; 
&lt;li&gt;at all system libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by checkout-library and borrower zipcode&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;ZIPCODE = borrower's zip code trimmed to 5 digits&lt;/li&gt; 
  &lt;li&gt;BORROWER_COUNT = count of all borrowers with this home library and this zip code&lt;/li&gt; 
  &lt;li&gt;RENEWED_LM= count of borrowers with this home library that were renewed last month&lt;/li&gt; 
  &lt;li&gt;ADDED_LM = count of borrowers with this home library that were added last month&lt;/li&gt; 
  &lt;li&gt;DELETED_LM = count of borrowers with this home library that were deleted last month&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;Zip codes on borrower records are only as accurate as the staff members who entered those zip codes into the borrower records.  There are hundreds of incorrect and non-standard zip codes in the borrower data.&lt;/li&gt; 
  &lt;li&gt;All zip codes are trimmed to 5 digits&lt;/li&gt; 
  &lt;li&gt;If BORROWER_ZIPCODE = "-" that means there are less than 25 borrowers with that zip code system-wide&lt;br /&gt;in order to protect borrower privacy, if there are fewer than 10 borrowers in a zip code, that zip code will be hidden.&lt;/li&gt; 
  &lt;li&gt;If BORROWER_ZIPCODE = "0" that means that the zipdcode that has been left blank, that zipcode contains nothing but spaces, or that zipcode is set to zero&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022.03.10&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2024.02.09&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3548"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #borrower #count #zipcode&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

----------
*/



SELECT 
  'branchname' AS 'branchname',  
  'ZIP_CODE' AS 'ZIP_CODE',  
  'BORROWER_COUNT' AS 'BORROWER_COUNT',  
  'RENEWED_LM' AS 'RENEWED_LM',  
  'ADDED_LM' AS 'ADDED_LM',  
  'DELETED_LM' AS 'DELETED_LM'
UNION 
(SELECT 
  branches.branchname, 
  If( 
    zipcounts.Count_borrowernumber &lt; 25, 
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
    zipcounts.Count_borrowernumber &lt; 25, 
    '-', 
    If( 
      branchcodeszipss.ZIPCODE = '', 
      '0', 
      branchcodeszipss.ZIPCODE 
    ) 
  ) 
ORDER BY 
  branches.branchname, 
  If( 
    zipcounts.Count_borrowernumber &lt; 25, 
    ' -', 
    If( 
      branchcodeszipss.ZIPCODE = '', 
      ' 0', 
      branchcodeszipss.ZIPCODE 
    ) 
  ) 
) 

























