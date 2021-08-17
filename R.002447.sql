/*
R.002447

----------

Name: Ottawa Withdrawn, including patron name charged for lost material
Created by: Heather Braum

----------

Group:  OTTAWA
     -

Created on: 2015-01-22 09:58:34
Modified on: 2021-08-16 13:43:55
Date last run: 2020-09-24 11:15:23

----------

Public: 0
Expiry: 0

----------

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowers.borrowernumber,'" target="_blank">',borrowers.cardnumber,'</a>') as "link to borrower", accountlines.date, biblio.title, items.barcode, borrowers.firstname, borrowers.surname, borrowers.cardnumber, accountlines.amountoutstanding FROM biblio, items, accountlines, borrowers WHERE items.biblionumber=biblio.biblionumber AND items.itemnumber=accountlines.itemnumber AND accountlines.borrowernumber=borrowers.borrowernumber AND accountlines.accounttype='L' AND items.itemnumber IN (SELECT itemnumber FROM items WHERE homebranch='OTTAWA' AND withdrawn <> '0')



