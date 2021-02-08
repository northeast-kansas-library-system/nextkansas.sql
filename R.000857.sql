/*
R.000857

----------

Name: BASEHOR Monthly Circ by Call Number
Created by:  Tongie Book Club

----------

Group: Library-Specific
     -

Created on: 2010-04-23 15:32:16
Modified on: 2014-02-12 16:26:43
Date last run: 2020-12-30 13:37:54

----------

Public: 0
Expiry: 0

----------

USE THIS ONE FOR MONTHLY CIRCS

----------
*/

SELECT count(*) FROM statistics LEFT JOIN items USING(itemnumber) WHERE statistics.type IN ('issue', 'renew') AND datetime >='2014-01-01' AND datetime <'2014-02-01' AND statistics.branch = 'BASEHOR'  AND (items.itemcallnumber LIKE 'YBIO%' OR items.itemcallnumber LIKE 'YB%' OR items.itemcallnumber LIKE 'Y BIO%')    



