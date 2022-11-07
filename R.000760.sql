/*
R.000760

----------

Name: Count of Yearly New items added by Itype
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2009-12-31 11:10:23
Modified on: 2015-03-17 15:14:38
Date last run: 2022-10-21 10:26:45

----------

Public: 0
Expiry: 0

----------

Enter a Year to determine the number of new items added by collection code in that year

----------
*/



SELECT i.homebranch, i.itype, i.location, count(i.itemnumber) as added FROM items i WHERE YEAR(i.dateaccessioned) = <<Year>> GROUP BY i.homebranch,i.itype,i.location

























