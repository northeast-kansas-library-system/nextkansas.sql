/*
R.002391

----------

Name: unknown
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-10-14 21:37:12
Modified on: 2019-06-30 21:19:11
Date last run: 2021-09-09 20:38:34

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT concat(b.surname,', ',b.firstname) AS name, count(s.borrowernumber) AS checkouts
FROM statistics s
LEFT JOIN borrowers b
USING (borrowernumber)
WHERE b.branchcode=&lt;&gt; AND s.datetime BETWEEN &lt;&gt; AND &lt;&gt;
GROUP BY s.borrowernumber
ORDER BY count(s.borrowernumber) DESC
LIMIT 2000

























