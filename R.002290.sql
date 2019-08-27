/*
R.002290

----------

Name: Possible items not checked in
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2014-06-26 11:31:52
Modified on: 2014-06-26 11:34:03
Date last run: 2019-04-25 14:52:56

----------

Public: 0
Expiry: 0

----------

This is a slow report. Please be patient. You'll need to choose your library branch twice. 

This report can be used for shelf checking on materials that patrons say they returned with other materials. It reports on patrons who have returned materials in the past 3 days, who have still have materials due in the past three days or next three days, who still have items checked out. 

----------
*/

SELECT borrowernumber, CONCAT (borrowers.firstname, ' ', borrowers.surname) as "patron name", count(items.itemnumber) as "items still out", GROUP_CONCAT(items.itemcallnumber, " ( ",
biblio.title, ") ") AS "booklist still out"
FROM (SELECT borrowernumber
FROM statistics
WHERE date(statistics.datetime) >= ( CURDATE() - INTERVAL 3 DAY ) 
      AND statistics.type='return' AND statistics.branch=<<branch|branches>>
GROUP BY borrowernumber) whoreturned
LEFT JOIN borrowers USING(borrowernumber)
LEFT JOIN issues USING (borrowernumber)
LEFT JOIN items USING (itemnumber)
LEFT JOIN biblio USING (biblionumber)
WHERE (date(issues.date_due) >= ( CURDATE() - INTERVAL 3 DAY ) OR date(issues.date_due) <=  ( CURDATE() + INTERVAL 3 DAY )) AND issues.branchcode=<<branch|branches>>
GROUP BY borrowernumber
ORDER BY issues.branchcode



