/*
R.003659

----------

Name: GHW - Borrowers by last borrowed date
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-03-31 16:55:23
Modified on: 2022-10-20 15:20:02
Date last run: 2022-10-20 15:20:06

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows borrowers sorted by their "Last borrowed" date but only if the last borrowed date was less than 25 months in the past.</p>
<ul><li>With the home library you specify</li>
<li>grouped by borrowernumber</li>
<li>sorted by LAST_BORROWED date</li>
<li>links to the borrower record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>This report gets the "LAST_BORROWED" dates from the statistics table in Koha.  As a matter of data security, Next Search Catalog only keeps data in the statistics table for the previous 25 months, therefore, the "LAST_BORROWED" date will never be more than 25 months in the past.</p>
<p></p>
<p class= "notetags" style="display: none;">#last borrowed</p>
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div> 

----------
*/



SELECT
  Concat_Ws('',
    '<a class="btn btn-default btn-xs noprint"', 
    'href=\"/cgi-bin/koha/members/moremember.pl?borrowernumber=', 
    borrowers.borrowernumber, 
    '" target="_blank">Borrower</a>'
  ) AS LINK,
  Concat_Ws('<br />', 
    Concat_Ws(' ', 
      borrowers.firstname, 
      borrowers.surname,
      If(
        borrowers.othernames = '', 
        '', 
        Concat('(', borrowers.othernames, ')')
      )
    ), 
    borrowers.cardnumber
  ) AS BORROWER,
  Concat_Ws('<br />', 
    Concat(borrowers.address, 
      If(
        borrowers.address2 = '', 
        '', 
        Concat('<br />', borrowers.address2))
      ), 
      Concat(borrowers.city, ', ', borrowers.state, ' ', borrowers.zipcode)
  ) AS ADDRESS,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode,
  borrowers.categorycode,
  statisticss.Max_datetime AS LAST_BORROWED,
  Format(accountliness.Sum_amountoutstanding, 2) AS UNPAID_FEES
FROM
  borrowers LEFT JOIN
  (SELECT
      statistics.borrowernumber,
      Max(statistics.datetime) AS Max_datetime,
      Count(DISTINCT statistics.itemnumber) AS Count_itemnumber
    FROM
      statistics
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      statistics.branch = <<Choose your library|ZBRAN>>
    GROUP BY
      statistics.borrowernumber
    ORDER BY
      statistics.borrowernumber,
      Max_datetime DESC) statisticss ON statisticss.borrowernumber =
      borrowers.borrowernumber LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber
    HAVING
      Sum(accountlines.amountoutstanding) > 0) accountliness ON
      accountliness.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|ZBRAN>> AND
  borrowers.categorycode LIKE <<Choose a borrower category|categorycode>> AND
  statisticss.Max_datetime < <<Last checkout before|date>>
ORDER BY
  LAST_BORROWED DESC

























