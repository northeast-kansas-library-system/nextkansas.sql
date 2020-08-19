/*
R.002447

----------

Name: Ottawa Withdrawn, including patron name charged for lost material
Created by: Heather Braum

----------

Group: Library-Specific
     Ottawa

Created on: 2015-01-22 09:58:34
Modified on: 2019-12-26 11:46:13
Date last run: 2020-06-03 16:51:16

----------

Public: 0
Expiry: 0

----------

<p><span style="color: yellow; background-color: red; font-size: 200%;">References accountlines.accounttype.  Needs to be updated after January 4, 2020</span></p>

----------
*/

SELECT CONCAT('<a href=\"/cgi-bin/koha/circ/circulation.pl?borrowernumber=',borrowers.borrowernumber,'" target="_blank">',borrowers.cardnumber,'</a>') as "link to borrower", accountlines.date, biblio.title, items.barcode, borrowers.firstname, borrowers.surname, borrowers.cardnumber, accountlines.amountoutstanding FROM biblio, items, accountlines, borrowers WHERE items.biblionumber=biblio.biblionumber AND items.itemnumber=accountlines.itemnumber AND accountlines.borrowernumber=borrowers.borrowernumber AND accountlines.accounttype='L' AND items.itemnumber IN (SELECT itemnumber FROM items WHERE homebranch='OTTAWA' AND withdrawn <> '0')



