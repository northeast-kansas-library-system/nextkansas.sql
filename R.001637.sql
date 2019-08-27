/*
R.001637

----------

Name: Last Checked Out Date
Created by: Heather Braum

----------

Group: Patrons
     -

Created on: 2012-11-16 10:21:00
Modified on: 2013-05-13 19:56:00
Date last run: 2018-08-01 16:28:27

----------

Public: 0
Expiry: 0

----------

#patrons (use in conjunction with 1639) This report does not account for patrons without checkouts. 

----------
*/

SELECT p.borrowernumber, p.surname, p.firstname, p.address, p.address2, p.city, p.zipcode,
p.categorycode, MAX(circ.issuedate) AS "Date Last Checked Out",
MAX(circ.returndate) AS "Date Last Returned"
FROM
(select issuedate, returndate, borrowernumber 
from issues
UNION ALL
select issuedate, returndate, borrowernumber 
from old_issues
) as circ 
left join borrowers p USING (borrowernumber) 
WHERE p.branchcode = <<Select your branch|branches>>
GROUP BY p.borrowernumber, p.surname, p.firstname, p.address, p.address2, p.city, p.zipcode
ORDER BY p.surname ASC, circ.issuedate DESC



