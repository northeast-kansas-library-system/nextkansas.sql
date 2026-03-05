/*
R.003896

----------

Name: OSKIE total items
Created by: Robin Hastings

----------

Group:  OSKALOOSA
     -

Created on: 2025-07-15 14:55:30
Modified on: 2025-07-15 14:55:56
Date last run: 2025-07-15 14:56:17

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT  items.stocknumber FROM items LEFT JOIN biblioitems on (items.biblioitemnumber=biblioitems.biblioitemnumber) LEFT JOIN biblio on (biblioitems.biblionumber=biblio.biblionumber)   WHERE items.homebranch='OSKALOOSA'

























