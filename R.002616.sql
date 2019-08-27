/*
R.002616

----------

Name: more lost in transit
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-10-09 14:54:42
Modified on: 2015-10-09 14:54:42
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT * FROM branchtransfers where itemnumber iN (SELECT itemnumber from items where itemlost='4' and damaged='2') AND datearrived IS NULL



