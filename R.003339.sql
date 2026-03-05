/*
R.003339

----------

Name: GHW - Borrowers with unresolved credits on their accounts
Created by: George Williams

----------

Group: -
     -

Created on: 2020-07-10 15:06:56
Modified on: 2024-01-17 12:04:36
Date last run: 2026-01-29 11:12:41

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows a list of borrowers with unresolved credits on their accounts&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows borrowers with currently unresolved credits&lt;/li&gt;
&lt;li&gt;shows patrons at the home library you specify&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;sorted by formula that generates row numbers&lt;/li&gt;
&lt;li&gt;links to the borrower's fine payment tab&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;  
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;replaces report 831&lt;/p&gt;
&lt;p&gt;replaces report 3526&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3339&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  (@row_number:=@row_number + 1) AS num, 
  Concat('Link to patron') AS
  LINK,
  borrowers.branchcode,
  borrowers.cardnumber AS LIBRARYCARD,
  borrowers.categorycode,
  Sum(accountlineslesszero.amountoutstanding) AS Sum_amountoutstanding
FROM
  borrowers JOIN
  (SELECT
      accountlines.borrowernumber,
      accountlines.amountoutstanding
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding &lt; 0) accountlineslesszero ON
      accountlineslesszero.borrowernumber = borrowers.borrowernumber,
    (SELECT @row_number:=0) AS t
WHERE
  borrowers.branchcode LIKE &lt;&gt;
GROUP BY
  borrowers.borrowernumber
ORDER BY
  num

























