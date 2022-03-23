/*
R.002978

----------

Name: GHW - Circulation Statistics by borrower's birth year (previous month)
Created by: George H Williams

----------

Group: Statistics
     Last calendar month

Created on: 2017-07-25 13:21:52
Modified on: 2018-04-16 11:11:29
Date last run: 2021-12-02 09:05:12

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts checkouts + renewals in the previous calendar month at a library grouped by the patron's birth year</p>
<ul><li>Shows data from the previous calendar month</li>
<li>at the library you specify</li>
<li>grouped and sorted by checkout branchcode and borrower's birth year</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2978&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.BIRTHYEAR, "-") AS BORROWERS_BIRTH_YEAR,
  Coalesce(CIR_RENEW_LM.count, 0) AS CHECKOUT_RENEW_LM
FROM
  branches
  LEFT JOIN (SELECT
      statistics.branch,
      Count(*) AS count,
      Coalesce(Year(borrowers.dateofbirth), Year(deletedborrowers.dateofbirth)) AS BIRTHYEAR
    FROM
      statistics
      LEFT JOIN borrowers ON statistics.borrowernumber = borrowers.borrowernumber
      LEFT JOIN deletedborrowers ON statistics.borrowernumber = deletedborrowers.borrowernumber
    WHERE
      (statistics.type = 'issue' OR
        statistics.type = 'renew') AND
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
    GROUP BY
      statistics.branch,
      Coalesce(Year(borrowers.dateofbirth), Year(deletedborrowers.dateofbirth))) CIR_RENEW_LM ON branches.branchcode = CIR_RENEW_LM.branch
WHERE
  branches.branchcode LIKE <<Choose check-out branch|LBRANCH>> AND
  Coalesce(CIR_RENEW_LM.BIRTHYEAR, "-") LIKE CONCAT("%",<<Enter part of the borrower's birth year (or enter "%" for all patrons)>>,"%")
GROUP BY
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.BIRTHYEAR, "-")
ORDER BY
  branches.branchcode,
  BORROWERS_BIRTH_YEAR

























