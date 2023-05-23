/*
R.003276

----------

Name: GHW - Find unfilled/not-suspended requests for a library
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-10-02 16:50:52
Modified on: 2023-02-09 09:16:57
Date last run: 2023-03-20 10:57:07

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
  reserves.suspend = "" AND 
  reserves.reservedate <= CURRENT_DATE()
GROUP BY
  reserves.borrowernumber,
  reserves.branchcode,
  reserves.found,
  reserves.suspend
ORDER BY
  reserves.branchcode,
  reserves.borrowernumber

























