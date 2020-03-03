/*
R.003276

----------

Name: GHW - Find unfilled/not-suspended requests for a library
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-10-02 16:50:52
Modified on: 2019-10-08 11:13:05
Date last run: 2020-02-27 13:04:51

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  Concat('<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', reserves.borrowernumber, '#reserves" target="_blank">Open in new window</a>') AS LINK,
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
  reserves.borrowernumber



