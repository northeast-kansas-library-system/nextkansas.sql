/*
R.000984

----------

Name: Problem Holds
Created by: -

----------

Group: Administrative Reports
     Holds-admin

Created on: 2010-11-19 15:14:42
Modified on: 2013-06-18 18:29:30
Date last run: 2019-03-07 12:51:18

----------

Public: 0
Expiry: 0

----------



----------
*/

select surname, firstname, cardnumber, reserves.borrowernumber, reserves.branchcode, reservenotes, priority, found, reserves.timestamp, reserves.itemnumber, waitingdate, biblio.title from reserves LEFT JOIN borrowers USING(borrowernumber) LEFT JOIN biblio USING(biblionumber) WHERE priority = 0 and waitingdate is null and found is not null order by reservedate desc



