/*
R.000984

----------

Name: Problem Holds
Created by: -

----------

Group: Administrative Reports
     Holds-admin

Created on: 2010-11-19 15:14:42
Modified on: 2022-12-14 12:03:26
Date last run: 2022-12-14 12:03:29

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT 
  surname, 
  firstname, 
  cardnumber, 
  reserves.borrowernumber, 
  reserves.branchcode, 
  reservenotes, 
  priority, 
  found, 
  reserves.timestamp, 
  reserves.itemnumber, 
  waitingdate, 
  biblio.title 
FROM reserves 
  LEFT JOIN borrowers USING(borrowernumber) 
  LEFT JOIN biblio USING(biblionumber) 
WHERE 
  priority = 0 and 
  waitingdate is null and 
  found is not null 
ORDER BY reservedate DESC

























