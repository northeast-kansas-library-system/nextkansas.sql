/*
R.003255

----------

Name: 8/19/19
Created by: BURLINGAME TECH

----------

Group: -
     -

Created on: 2019-08-19 07:22:37
Modified on: 2019-08-19 15:37:54
Date last run: 2019-08-19 15:37:58

----------

Public: 0
Expiry: 300

----------

I don't know what you're trying to accomplish with this report, but the report you've written has a good chance of crashing the system.  I've added a 20 row limit to this report to keep it from overloading the system.  Please contact us for help at nexthelp@nekls.org

----------
*/

SELECT  biblio.title,items.ccode,items.location,items.itemcallnumber,items.datelastseen,items.barcode,items.biblioitemnumber,items.biblionumber,items.itemnumber FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber) limit 20



