/*
R.003659

----------

Name: GHW - Borrowers by last borrowed date
Created by: George Williams

----------

Group: -
     -

Created on: 2022-03-31 16:55:23
Modified on: 2024-01-17 12:11:53
Date last run: 2022-10-20 15:20:06

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows borrowers sorted by their "Last borrowed" date but only if the last borrowed date was less than 25 months in the past.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;With the home library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by LAST_BORROWED date&lt;/li&gt;
&lt;li&gt;links to the borrower record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;This report gets the "LAST_BORROWED" dates from the statistics table in Koha.  As a matter of data security, Next Search Catalog only keeps data in the statistics table for the previous 25 months, therefore, the "LAST_BORROWED" date will never be more than 25 months in the past.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p class= "notetags" style="display: none;"&gt;#last borrowed&lt;/p&gt;
&lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt;
&lt;/div&gt; 

----------
*/



SELECT
  Concat_Ws('',
    'Borrower'
  ) AS LINK,
  Concat_Ws('', 
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
  Concat_Ws('', 
    Concat(borrowers.address, 
      If(
        borrowers.address2 = '', 
        '', 
        Concat('', borrowers.address2))
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
      statistics.branch = &lt;&gt;
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
      Sum(accountlines.amountoutstanding) &gt; 0) accountliness ON
      accountliness.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE &lt;&gt; AND
  borrowers.categorycode LIKE &lt;&gt; AND
  statisticss.Max_datetime &lt; &lt;&gt;
ORDER BY
  LAST_BORROWED DESC

























