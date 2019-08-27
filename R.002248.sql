/*
R.002248

----------

Name: Count of Total items currently checked out by collection and location
Created by: Heather Braum

----------

Group: Circulation
     Checked Out

Created on: 2014-04-23 14:08:50
Modified on: 2014-04-23 14:11:54
Date last run: 2019-05-22 16:23:59

----------

Public: 0
Expiry: 0

----------

Limited by items' homebranch. Gives total counts of items currently checked out in collection codes and shelving locations. 

----------
*/

select items.ccode, items.location, count(issues.itemnumber) from issues join items using(itemnumber) where items.homebranch=<<branch|branches>> GROUP BY items.ccode, items.location



