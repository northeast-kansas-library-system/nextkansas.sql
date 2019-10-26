/*
R.002525

----------

Name: Items not checked out
Created by: Robin Hastings

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2015-06-23 10:29:21
Modified on: 2015-06-23 10:29:21
Date last run: 2018-04-02 12:51:10

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  items.price,items.replacementprice,biblio.title,biblio.author,items.itemcallnumber 
  FROM items 
  LEFT JOIN biblioitems ON (items.biblioitemnumber=biblioitems.biblioitemnumber) 
  LEFT JOIN biblio ON (biblioitems.biblionumber=biblio.biblionumber) 
  WHERE items.homebranch=<<Home branch|branches>> 
  ORDER BY items.itemcallnumber ASC


