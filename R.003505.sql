/*
R.003505

----------

Name: 0055 - 2024_99_d_circulation_zipcode monthly_statistics
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2021-05-12 20:58:05
Modified on: 2025-04-30 10:54:48
Date last run: 2026-01-01 00:55:02

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Circulation by borrower details - checkouts and renewals by check-out library and zipcode&lt;/p&gt; 
&lt;ul&gt;&lt;li&gt;during the previous calendar month&lt;/li&gt; 
&lt;li&gt;at all system libraries&lt;/li&gt; 
&lt;li&gt;grouped and sorted by checkout-library and borrower zipcode&lt;/li&gt; 
&lt;/ul&gt;&lt;br /&gt; 
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;ul&gt; 
  &lt;li&gt;Zip codes on borrower records are only as accurate as the staff members who entered those zip codes into the borrower records.  There are hundreds of incorrect and non-standard zip codes in the borrower data.&lt;/li&gt; 
  &lt;li&gt;All zip codes are trimmed to 5 digits&lt;/li&gt;  
  &lt;li&gt;If BORROWER_ZIPCODE = "-" that means there are less than 25 borrowers with that zip code system-wide&lt;br /&gt;in order to protect borrower privacy, if there are fewer than 25 borrowers in a zip code, that zip code will be hidden.&lt;/li&gt; 
  &lt;li&gt;If BORROWER_ZIPCODE = "0" that means that the zipdcode that has been left blank, that zipcode contains nothing but spaces, or that zipcode is set to zero&lt;/li&gt; 
&lt;/ul&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022-03-10&lt;/p&gt; 
&lt;p class="updated"&gt;This report and these notes updated on 2022-02-09&lt;/p&gt; 
&lt;p&gt;&lt;/p&gt; 
&lt;p id="rquickdown"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id= 3505"&gt;Click here to download as a csv file&lt;/a&gt;&lt;/p&gt; 
&lt;p class= "notetags" style="display: none;"&gt;#monthly #statistics #borrower #details #zipcode #circulation_by_borrower_details&lt;/p&gt; 
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
&lt;/div&gt; 

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
    zipcounts.Count_borrowernumber &lt; 25,
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
      COUNT(&ast;) AS CKO_RENEW
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
    zipcounts.Count_borrowernumber &lt; 25,
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
    zipcounts.Count_borrowernumber &lt; 25,
    ' -',
    If(
      circcounts.BORROWER_ZIPCODE = '',
      ' 0',
      circcounts.BORROWER_ZIPCODE
    )
  )
)

























