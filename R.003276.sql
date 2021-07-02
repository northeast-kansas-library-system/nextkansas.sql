/*
R.003276

----------

Name: GHW - Find unfilled/not-suspended requests for a library
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-10-02 16:50:52
Modified on: 2020-06-06 01:27:11
Date last run: 2021-05-21 14:42:50

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', reserves.borrowernumber, '#reserves" target="_blank">Open in new window</a>') AS LINK,
  Concat('https://staff.nextkansas.org/cgi-bin/koha/circ/circulation.pl?borrowernumber=', reserves.borrowernumber, '#reserves') AS URL,
  reserves.branchcode,
  Count(reserves.reserve_id) AS Count_reserve_id
FROM
  reserves
WHERE
  reserves.branchcode LIKE <<Choose your library|LBRANCH>> AND
  reserves.found IS NULL AND
  reserves.suspend = ""
GROUP BY
  reserves.borrowernumber,
  reserves.branchcode,
  reserves.found,
  reserves.suspend
ORDER BY
  reserves.branchcode,
  reserves.borrowernumber



