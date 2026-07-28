/*
R.002244

----------

Name: List of Items Checked out in a Collection Code
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2014-04-23 13:48:23
Modified on: 2026-06-11 12:46:18
Date last run: 2026-06-11 12:43:06

----------

Public: 0
Expiry: 0

----------

This report limits on items' home library and collection code, and displays the cardnumber, patron's home library, patron name, item title, location, collection code, item type, item barcode, date checked out, days checked out, date due, days overdue, last date renewed, renewals count, of all materials currently checked out from your library's collection. 

----------
*/



 SELECT   borrowers.cardnumber,
         borrowers.branchcode AS homelibrary,
         borrowers.firstname,
         borrowers.surname,
         biblio.title,
         items.itemcallnumber AS callnumber,
         items.location,
         items.ccode,
         items.itype,
         items.barcode,
         Date(issues.issuedate)                  AS "date out",
         (To_days(Curdate())-To_days(issuedate)) AS daysout,
         Date(issues.date_due)                   AS "date due",
         (To_days(Curdate())-To_days(date_due))  AS "days overdue",
         Date(issues.lastreneweddate)            AS "last renewed"
FROM     issues
JOIN     borrowers
using   (borrowernumber)
JOIN     items
using   (itemnumber)
JOIN     biblio
using   (biblionumber)
WHERE    items.homebranch LIKE <<branch|branches>>
AND      items.ccode LIKE <<ccode|ccode:all>>
ORDER BY daysout DESC

























