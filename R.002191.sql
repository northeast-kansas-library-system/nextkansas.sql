/*
R.002191

----------

Name: Basehor Call Number Counts
Created by: Heather Braum

----------

Group: Library-Specific
     Basehor

Created on: 2014-02-17 15:21:45
Modified on: 2014-02-17 16:08:07
Date last run: -

----------

Public: 0
Expiry: 0

----------

To 6 digits in the prefix... Adjust the second substring number to change how far into the call number is counted. 

----------
*/

SELECT substring(items.itemcallnumber,1,6) AS 'Call Number range', count(*) AS count FROM items WHERE items.homebranch='basehor' AND itype <> 'MAGAZINE' AND notforloan<>'1' AND ccode<>'ILL' GROUP By substring(items.itemcallnumber,1,6)



