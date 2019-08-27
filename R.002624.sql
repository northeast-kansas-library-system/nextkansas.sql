/*
R.002624

----------

Name: Lent and Lost at another branch in last 365 days
Created by: Bywater bwssupport

----------

Group: Administrative Reports
     -

Created on: 2015-10-23 01:02:56
Modified on: 2016-01-12 13:16:06
Date last run: 2017-05-16 14:33:29

----------

Public: 0
Expiry: 0

----------

Returns all branches. Updated by hb, 1/12/16. Works! 

----------
*/

select
sum(replacementprice),
items.homebranch
from
items
where itemnumber IN (SELECT itemnumber FROM items WHERE datediff(CURRENT_DATE, itemlost_on) < 365 and items.itemlost IN ('1','2','4','5')
and items.homebranch != items.holdingbranch) group by items.homebranch
order by sum(replacementprice) desc



