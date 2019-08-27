/*
R.001692

----------

Name: Count of Items Added to Collection in a Year
Created by: Heather Braum

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2013-01-03 23:10:15
Modified on: 2013-06-16 14:46:14
Date last run: 2019-01-17 14:46:37

----------

Public: 0
Expiry: 0

----------

Enter a Year to determine the number of new items added in that year.  Year End Report.

----------
*/

SELECT i.homebranch, count(i.itemnumber) from items i WHERE YEAR(i.dateaccessioned) = <<Year>> GROUP BY i.homebranch ORDER BY i.homebranch LIMIT 50



