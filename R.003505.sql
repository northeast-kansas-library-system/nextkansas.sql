/*
R.003505

----------

Name: GHW - D2 Circulation by borrower details - circulation by zipcode - Next Search Catalog
Created by: George H Williams

----------

Group: Statistics
     2022 beginning of month statistics

Created on: 2021-05-12 20:58:05
Modified on: 2022-03-10 15:18:35
Date last run: 2022-03-10 16:33:27

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint> 
<p>Circulation by borrower details - checkouts and renewals by check-out library and zipcode</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by checkout-library and borrower zipcode</li> 
</ul><br /> 
<p><ins>Notes:</ins></p> 
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
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3505">Click here to download as a csv file</a></p> 
<p class= "notetags" style="display: none;">#monthly #statistics #borrower #details #zipcode</p> 
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --> 
</div> 

----------
*/



SELECT 
  branches.branchname AS 'Library', 
  If( 
    zipcounts.Count_borrowernumber < 10, 
    '-', 
    If( 
      circcounts.BORROWER_ZIPCODE = '', 
      '0', 
      circcounts.BORROWER_ZIPCODE 
    ) 
  ) AS 'Borrower zipcode', 
  Sum(circcounts.CKO_RENEW) AS 'Checkouts + renewals' 
FROM 
    (SELECT 
      statistics.branch AS CKO_BRANCH, 
      Left(Trim(borrowers.zipcode), 5) AS BORROWER_ZIPCODE, 
      COUNT(*) AS CKO_RENEW 
    FROM 
      statistics LEFT JOIN 
      borrowers ON borrowers.borrowernumber = statistics.borrowernumber 
    WHERE 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') AND 
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND 
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) 
    GROUP BY 
      statistics.branch, 
      Left(Trim(borrowers.zipcode), 5) 
    ORDER BY 
      CKO_BRANCH, 
      BORROWER_ZIPCODE 
    ) circcounts 
  LEFT JOIN 
    (SELECT 
      Left(Trim(borrowers.zipcode), 5) AS ZIP, 
      Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber 
    FROM 
      borrowers 
    GROUP BY 
      Left(Trim(borrowers.zipcode), 5) 
    ) zipcounts 
  ON zipcounts.ZIP = circcounts.BORROWER_ZIPCODE 
  JOIN branches ON circcounts.CKO_BRANCH = branches.branchcode 
GROUP BY 
  branches.branchname, 
  If( 
    zipcounts.Count_borrowernumber < 10, 
    '-', 
    If( 
      circcounts.BORROWER_ZIPCODE = '', 
      '0', 
      circcounts.BORROWER_ZIPCODE 
    ) 
  ) 
ORDER BY 
  branches.branchname, 
  BORROWER_ZIPCODE 

























