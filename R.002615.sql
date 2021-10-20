/*
R.002615

----------

Name: records with 1 item, lost in transit
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-10-09 14:19:00
Modified on: 2015-10-15 16:44:44
Date last run: 2019-01-17 23:27:26

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT CONCAT ('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',reserves.biblionumber,'\" target="_blank">',reserves.reserve_id,'</a>') AS "Link to Reserve", (SELECT count(*) FROM items WHERE items.biblionumber=reserves.biblionumber) as itemcount FROM reserves where itemnumber iN (SELECT itemnumber from items where itemlost='4' and damaged='2') GROUP BY itemnumber

























