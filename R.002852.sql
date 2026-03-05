/*
R.002852

----------

Name: GHW - LEAVENWRTH Reset patrsons - includes information that might block their deletion
Created by: George Williams

----------

Group:  LEAVENWRTH
     -

Created on: 2016-12-12 16:53:41
Modified on: 2024-01-17 11:46:48
Date last run: 2025-10-09 09:45:03

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Shows all "Reset" patrons with current checkout count (if any), current amount due (if any), guarantors (if any), and current guarantees (if any)&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows patrons that still have a NExpress account&lt;/li&gt;
&lt;li&gt;Only shows patrons with the word "reset" in the barcode number&lt;/li&gt;
&lt;li&gt;grouped and sorted by card number, patron homebranch, expiration date, current checkout count, and amount owed&lt;/li&gt;
&lt;li&gt;links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2852&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.branchcode AS BORROWER_HOMEBRANCH,
  borrowers.dateexpiry,
  currentcheckouts.CKO_COUNT AS CURRENT_CHECKOUTS,
  format(feesowed.Sum_amountoutstanding, 2) AS OWES,
  borrowers1.cardnumber AS IS_GUARANTEED_BY,
  GROUP_CONCAT(guarantorstable.cardnumber SEPARATOR ", ") AS GUARANTOR
FROM
  borrowers LEFT JOIN
  (SELECT
    issues.borrowernumber,
    Count(issues.issue_id) AS CKO_COUNT
  FROM
    issues
  GROUP BY
    issues.borrowernumber) currentcheckouts
    ON borrowers.borrowernumber = currentcheckouts.borrowernumber LEFT JOIN
  (SELECT
    accountlines.borrowernumber,
    Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding
  FROM
    accountlines
  GROUP BY
    accountlines.borrowernumber) feesowed
    ON borrowers.borrowernumber = feesowed.borrowernumber LEFT JOIN
  (SELECT
    borrowers.guarantorid,
    borrowers.cardnumber
  FROM
    borrowers) guarantorstable
    ON borrowers.borrowernumber = guarantorstable.guarantorid LEFT JOIN
  borrowers borrowers1
    ON borrowers.guarantorid = borrowers1.borrowernumber
WHERE
  borrowers.cardnumber LIKE "%RESET%"
GROUP BY
  borrowers.cardnumber,
  BORROWER_HOMEBRANCH,
  borrowers.dateexpiry,
  CURRENT_CHECKOUTS,
  OWES,
  IS_GUARANTEED_BY

























