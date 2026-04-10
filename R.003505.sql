/*
R.003505

----------

Name: 0045 - 2024_99_d_circulation_zipcode monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-05-12 20:58:05
Modified on: 2026-01-30 17:30:03
Date last run: 2026-04-01 00:45:01

----------

Public: 0
Expiry: 300

----------

<div> 
<p>Circulation by borrower details - checkouts and renewals by check-out library and zipcode</p> 
<ul><li>during the previous calendar month</li> 
<li>at all system libraries</li> 
<li>grouped and sorted by checkout-library and borrower zipcode</li> 
</ul><br /> 
<p>Notes:</p> 
<p></p> 
<ul> 
  <li>Zip codes on borrower records are only as accurate as the staff members who entered those zip codes into the borrower records.  There are hundreds of incorrect and non-standard zip codes in the borrower data.</li> 
  <li>All zip codes are trimmed to 5 digits</li>  
  <li>If BORROWER_ZIPCODE = "-" that means there are less than 25 borrowers with that zip code system-wide<br />in order to protect borrower privacy, if there are fewer than 25 borrowers in a zip code, that zip code will be hidden.</li> 
  <li>If BORROWER_ZIPCODE = "0" that means that the zipdcode that has been left blank, that zipcode contains nothing but spaces, or that zipcode is set to zero</li> 
</ul> 
<p></p> 
<p>This report and these notes updated on 2022-03-10</p> 
<p>This report and these notes updated on 2022-02-09</p> 
<p></p> 
<p>Click here to download as a csv file</p> 
<p>#monthly #statistics #borrower #details #zipcode #circulation_by_borrower_details</p> 
 
</div> 

----------
*/



SELECT 
  'Library' AS 'Library',  
  'Borrower zipcode' AS 'Borrower zipcode',  
  'Checkouts + renewals' AS 'Checkouts + renewals'
UNION  
(SELECT 
  branches.branchname AS 'Library',
  If(
    zipcounts.Count_borrowernumber < 25,
    '-',
    If(
      circcounts.BORROWER_ZIPCODE = '',
      '0',
      circcounts.BORROWER_ZIPCODE
    )
  ) AS 'Borrower zipcode',
  Sum(circcounts.CKO_RENEW) AS 'Checkouts + renewals'
FROM 
  (
    SELECT 
      statistics.branch AS CKO_BRANCH,
      Left(
        Trim(
          Coalesce(
            If(borrowers.zipcode = '', '0', borrowers.zipcode),
            0
          )
        ),
        5
      ) AS BORROWER_ZIPCODE,
      COUNT(*) AS CKO_RENEW
    FROM statistics
      LEFT JOIN borrowers ON borrowers.borrowernumber = statistics.borrowernumber
    WHERE (
        statistics.type = 'issue'
        OR statistics.type = 'renew'
      )
      AND Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH)
      AND Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY statistics.branch,
      Left(
        Trim(
          Coalesce(
            If(borrowers.zipcode = '', '0', borrowers.zipcode),
            0
          )
        ),
        5
      )
    ORDER BY CKO_BRANCH,
      BORROWER_ZIPCODE
  ) circcounts
  LEFT JOIN (
    SELECT 
      Left(
        Trim(
          Coalesce(
            If(borrowers.zipcode = '', '0', borrowers.zipcode),
            0
          )
        ),
        5
      ) AS ZIP,
      Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber
    FROM borrowers
    GROUP BY Left(
        Trim(
          Coalesce(
            If(borrowers.zipcode = '', '0', borrowers.zipcode),
            0
          )
        ),
        5
      )
  ) zipcounts 
  ON zipcounts.ZIP = circcounts.BORROWER_ZIPCODE
  JOIN branches ON circcounts.CKO_BRANCH = branches.branchcode
GROUP BY branches.branchname,
  If(
    zipcounts.Count_borrowernumber < 25,
    '-',
    If(
      circcounts.BORROWER_ZIPCODE = '',
      '0',
      circcounts.BORROWER_ZIPCODE
    )
  )
ORDER BY
  branches.branchname,
  If(
    zipcounts.Count_borrowernumber < 25,
    ' -',
    If(
      circcounts.BORROWER_ZIPCODE = '',
      ' 0',
      circcounts.BORROWER_ZIPCODE
    )
  )
)

























