/*
R.002522

----------

Name: Bibs to Export
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-06-15 22:07:00
Modified on: 2015-06-16 20:03:37
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber FROM biblioitems WHERE (itemtype <> 'DIGITAL' OR itemtype IS NULL) AND biblionumber BETWEEN <<start>> AND <<end>>



