/*
R.002990

----------

Name: Items By IType
Created by: Robin Hastings

----------

Group: Catalog Records and Items
     -

Created on: 2017-08-16 13:55:47
Modified on: 2017-08-16 13:57:51
Date last run: 2017-08-16 14:02:00

----------

Public: 0
Expiry: 300

----------

RMH - Select all materials of <itype> from <library>
includes - date accessioned; item type; call number, barcode, author, title and copyright date

----------
*/

SELECT 
                 items.dateaccessioned,
                 items.itype,
                 items.itemcallnumber,
                 items.barcode,
                 biblio.author,
                 biblio.title, 
                 biblio.copyrightdate 
  FROM items 
  LEFT JOIN biblioitems ON (items.biblioitemnumber=biblioitems.biblioitemnumber) 
  LEFT JOIN biblio ON (biblioitems.biblionumber=biblio.biblionumber) 
  WHERE (items.homebranch=<<Home branch|branches>> AND items.itype=<<Item type|itemtypes>>) 
  ORDER BY items.dateaccessioned DESC



