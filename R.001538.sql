/*
R.001538

----------

Name: Count of Deleted Bib Records by Year
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeded Already

Created on: 2012-09-10 17:13:41
Modified on: 2015-05-19 11:42:44
Date last run: 2020-12-03 12:36:07

----------

Public: 0
Expiry: 0

----------

#special

----------
*/

SELECT YEAR(timestamp), COUNT(biblionumber) FROM deletedbiblio GROUP BY YEAR(timestamp)



