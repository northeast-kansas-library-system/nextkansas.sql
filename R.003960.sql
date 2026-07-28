/*
R.003960

----------

Name: GHW - test
Created by: George Williams

----------

Group: -
     -

Created on: 2026-06-01 12:19:17
Modified on: 2026-06-01 12:29:44
Date last run: 2026-06-01 12:30:22

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT SUM(totalcount) AS 'Total Checkouts in Range'
FROM (
    SELECT COUNT(*) AS totalcount
    FROM issues
    WHERE borrowernumber IN <<example list |list>>
    AND issuedate BETWEEN <<Start date|date>> AND <<End date|date>>

    UNION ALL

    SELECT COUNT(*) AS totalcount
    FROM old_issues
    WHERE borrowernumber IN <<example list |list>>
    AND returndate BETWEEN <<Start date|date>> AND <<End date|date>>
) AS total

























