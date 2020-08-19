/*
R.002936

----------

Name: GHW - Monthly statistics - Unique patron count
Created by: George H Williams

----------

Group: Statistics
     -

Created on: 2017-05-01 10:06:47
Modified on: 2018-04-16 11:08:54
Date last run: 2020-07-22 15:21:30

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Counts the number of "unique" borrower at a library during the previous calendar month</p>
<ul><li>shows data from the previous calendar month (i.e. between 12:00 a.m. on the first and 11:59 p.m. on the last day of the month)</li>
<li>shows data from the library you specify based on the library where the items were checked out or renewed</li>
<li>grouped and sorted by check-out/renewal branch and item type</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Report created at the request of MCLOUTH.</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports= XX PUT REPORTNUMBER HERE and remove XXs and Spaces XX &phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  branches.branchcode,
  uniquepatron.itemtype,
  uniquepatron.Count_borrowernumber
FROM
  branches
  INNER JOIN (SELECT
      statistics.branch,
      statistics.itemtype,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      statistics.itemtype
    UNION
    SELECT
      statistics.branch,
      If(statistics.itemtype <> " ", " Total unique patrons", "-") AS itemtypes,
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber
    FROM
      statistics
    WHERE
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND
      (statistics.type = 'issue' OR
        statistics.type = 'renew')
    GROUP BY
      statistics.branch,
      If(statistics.itemtype <> " ", " Total unique patrons", "-")) uniquepatron ON branches.branchcode =
    uniquepatron.branch
WHERE
  branches.branchcode LIKE <<Choose your library|LBRANCH>> AND
  uniquepatron.itemtype LIKE <<Choose an item type|LITYPES>>
GROUP BY
  branches.branchcode,
  uniquepatron.itemtype,
  uniquepatron.Count_borrowernumber
ORDER BY
  branches.branchcode,
  uniquepatron.itemtype



