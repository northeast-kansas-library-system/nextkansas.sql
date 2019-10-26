/*
R.002612

----------

Name: fixing coded_location_qualifier data
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-10-08 15:26:17
Modified on: 2015-10-21 17:14:22
Date last run: 2018-07-03 15:58:34

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT barcode, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblionumber,'&itemnumber=',itemnumber,'#edititem\" target="_blank">'"edit item"'</a>') as "edit item", coded_location_qualifier  FROM items where coded_location_qualifier IS NOT NULL AND coded_location_qualifier <> '' and homebranch <> 'LEAVENWRTH'


