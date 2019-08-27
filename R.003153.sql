/*
R.003153

----------

Name: Items not loaded in Highland migration due to duplicate barcodes
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2019-01-12 11:24:13
Modified on: 2019-01-12 11:24:13
Date last run: 2019-02-09 10:27:33

----------

Public: 0
Expiry: 300

----------



----------
*/

select biblionumber,title from biblio where datecreated='2019-01-12' and biblionumber not in (select biblionumber from items)



