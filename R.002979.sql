/*
R.002979

----------

Name: GHW - Circulation Statistics by borrower's birth year (date range)
Created by: George H Williams

----------

Group: Statistics
     Date range

Created on: 2017-07-25 13:44:51
Modified on: 2018-04-16 11:11:31
Date last run: 2018-05-04 17:33:46

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Counts checkouts + renewals grouped by the patron's birth year</p>
<ul><li>Shows data from the date range you specify</li>
<li>at the library you specify</li>
<li>grouped and sorted by checkout branchcode and borrower's birth year</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Data from the statistics table is purged after 25 months so this report cannot generate reports for data more than 25 months old.  As with all statistical data, the best practice is to run the reports for the data you want within a month or two of the creation of that data and then to save that data as a spreadsheet.</p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2979&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
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
        (statistics.datetime BETWEEN <<Items checked out or renewed between|date>> and (<<and|date>> + interval 1 day))
    GROUP BY
      statistics.branch,
      Coalesce(Year(borrowers.dateofbirth), Year(deletedborrowers.dateofbirth))) CIR_RENEW_LM ON branches.branchcode = CIR_RENEW_LM.branch
WHERE
  branches.branchcode LIKE <<Choose check-out branch|LBRANCH>> AND
  Coalesce(CIR_RENEW_LM.BIRTHYEAR, "-") LIKE CONCAT("%",<<Enter patron's birth year (or enter "%" for all patrons)>>,"%")
GROUP BY
  branches.branchcode,
  Coalesce(CIR_RENEW_LM.BIRTHYEAR, "-")
ORDER BY
  branches.branchcode,
  BORROWERS_BIRTH_YEAR



