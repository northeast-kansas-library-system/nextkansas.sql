/*
R.002491

----------

Name: Multiple copies of a title at Doniphan libraries
Created by: Heather Braum

----------

Group:  Doniphan County
     -

Created on: 2015-04-14 17:54:17
Modified on: 2021-08-16 20:40:35
Date last run: 2024-08-27 14:31:24

----------

Public: 0
Expiry: 0

----------

This is a duplicate of report #1573 but it's written specifically for Doniphan libraries. 

----------
*/



SELECT CONCAT('',biblio.biblionumber,'') as "link to record", biblio.title, biblio.author, count(itemnumber) as "total items", GROUP_CONCAT(items.homebranch SEPARATOR '; ') as "home libraries", GROUP_CONCAT(items.barcode SEPARATOR '; ') as barcodes, GROUP_CONCAT(items.ccode SEPARATOR '; ') as ccodes, GROUP_CONCAT(items.location SEPARATOR '; ') as locations, GROUP_CONCAT(items.itemcallnumber SEPARATOR '; ') as callnumbers FROM biblio LEFT JOIN items USING(biblionumber) WHERE items.homebranch LIKE 'DONI%' GROUP BY items.biblionumber HAVING count(items.itemnumber) &gt; 1 ORDER BY biblio.author


























