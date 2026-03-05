/*
R.002666

----------

Name: Cleaning up mixed up ccodes
Created by: Heather Braum

----------

Group: -
     -

Created on: 2016-02-10 22:19:37
Modified on: 2019-07-01 16:13:51
Date last run: 2019-07-01 16:16:32

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT CONCAT('',biblionumber,'') AS bibnumber, 
GROUP_CONCAT(DISTINCT ccode),
COUNT(DISTINCT ccode)
FROM items 
GROUP BY biblionumber 
HAVING 
count(itemnumber) &gt; '1' AND
COUNT(DISTINCT ccode) &gt; 1 AND
GROUP_CONCAT(DISTINCT ccode) LIKE Concat("%", &lt;&gt;, "%")

























