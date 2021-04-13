/*
R.000761

----------

Name: Count of Yearly New items added by CCode
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2009-12-31 11:18:16
Modified on: 2013-06-16 14:47:14
Date last run: 2021-03-08 14:37:44

----------

Public: 0
Expiry: 0

----------

Enter a Year to determine the number of new items added by collection code in that year.  Year End Report.

----------
*/

SELECT count(i.biblionumber) as added, i.homebranch, i.ccode,  i.location from items i WHERE YEAR(i.dateaccessioned) = <<Year>> GROUP BY i.homebranch,i.ccode,i.location ORDER BY i.homebranch,i.ccode,i.location asc



