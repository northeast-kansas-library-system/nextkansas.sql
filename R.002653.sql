/*
R.002653

----------

Name: Due on May 6th 2016
Created by: Robin Hastings

----------

Group: Circulation
     -

Created on: 2016-01-11 13:31:13
Modified on: 2016-01-11 13:47:11
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT c.date_due, p.surname, p.firstname, b.title, b.author
FROM issues c
LEFT JOIN items i ON (c.itemnumber=i.itemnumber) 
LEFT JOIN borrowers p ON (c.borrowernumber=p.borrowernumber) 
LEFT JOIN biblio b ON (i.biblionumber=b.biblionumber) 
WHERE c.issuedate >= DATE_SUB(CURDATE(),INTERVAL 3 DAY)
      AND i.homebranch = <<Branch|branches>>
ORDER BY c.date_due ASC


