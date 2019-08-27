/*
R.001475

----------

Name: Checked Out List
Created by: Heather Braum

----------

Group: Circulation
     -

Created on: 2012-07-11 13:10:40
Modified on: 2013-10-14 12:14:04
Date last run: 2019-08-14 15:18:35

----------

Public: 0
Expiry: 0

----------

Who currently has things checked out from your library's collection, what are they, and when are they due? #circ

----------
*/

select borrowers.firstname, borrowers.surname, borrowers.address, borrowers.branchcode, issues.issuingbranch, CONCAT ('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',biblio.biblionumber,'\" target="_blank">'"link to record"'</a>') AS "Link to Record",  biblio.title, issues.date_due, items.barcode from issues join borrowers USING(borrowernumber) join items using(itemnumber) join biblio using(biblionumber)  where items.homebranch =<<Select your Library|branches>> ORDER BY borrowers.surname, biblio.title LIMIT 1000



