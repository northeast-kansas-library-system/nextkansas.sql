/*
R.002521

----------

Name: New Records, non-digital
Created by: Heather Braum

----------

Group: -
     -

Created on: 2015-06-14 23:08:08
Modified on: 2015-06-14 23:08:40
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT biblionumber FROM biblioitems WHERE biblionumber > 670000 AND (itemtype <> 'DIGITAL' OR itemtype IS NULL)



