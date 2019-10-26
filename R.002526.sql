/*
R.002526

----------

Name: Items not checked out
Created by: Robin Hastings

----------

Group: Administrative Reports
     Circ Stats-admin

Created on: 2015-06-23 10:30:22
Modified on: 2015-06-23 10:33:15
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblio.title,items.itemcallnumber 
  FROM items 
  LEFT JOIN biblioitems ON (items.biblioitemnumber=biblioitems.biblioitemnumber) 
  LEFT JOIN biblio ON (biblioitems.biblionumber=biblio.biblionumber) 
  WHERE items.homebranch=<<Home branch|branches>> 


