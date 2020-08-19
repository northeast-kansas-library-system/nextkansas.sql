/*
R.000571

----------

Name: Monthly 006 New Materials Added by Collection Code and Location
Created by:  Tongie Book Club

----------

Group: -
     -

Created on: 2009-06-01 16:58:23
Modified on: 2016-10-05 16:17:46
Date last run: 2020-05-18 15:38:27

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by ccode and shelving location 

----------
*/

SELECT  i.homebranch as "Library", i.ccode as "Collection Code", i.location as "Location", count(i.biblionumber) as "Total Added" from items i WHERE month(i.dateaccessioned) = << Choose month|MONTH >> AND year (i.dateaccessioned) = << Choose year|YEAR>> GROUP BY i.homebranch,i.ccode,i.location ORDER BY i.homebranch,i.ccode,i.location asc



