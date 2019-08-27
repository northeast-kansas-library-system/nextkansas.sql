/*
R.001537

----------

Name: List of Deleted Bib Records in a Year
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2012-09-10 17:11:55
Modified on: 2015-05-19 11:42:53
Date last run: 2018-07-23 15:49:54

----------

Public: 0
Expiry: 0

----------

#special

----------
*/

SELECT title, author, biblionumber, datecreated, timestamp FROM deletedbiblio WHERE YEAR(timestamp) = << year >> ORDER BY timestamp DESC



