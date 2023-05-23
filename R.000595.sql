/*
R.000595

----------

Name: Weekly Juv (JF, E or Childrens) Circ, Tongie example
Created by:  Tongie Book Club

----------

Group: Circulation
     Circ Stats

Created on: 2009-06-16 12:09:51
Modified on: 2013-11-17 13:00:26
Date last run: 2023-03-08 16:20:33

----------

Public: 0
Expiry: 0

----------

From John

----------
*/



select date_format(`datetime`,"%X-%V") as 'Week', count(*) as 'Checkouts' from statistics LEFT JOIN items USING (itemnumber) where homebranch=<<Pick your branch|branches>> AND datetime LIKE <<enter date with % (ex. 2012-01-05%>> AND type in ('issue','renew') AND (items.itemcallnumber like <<enter first call number with % ex. JF%>> and type in ('issue','renew') OR <<enter second call number with % ex. E%>> OR items.location in ('CHILDRENS')) group by date_format(`datetime`,"%X-%V") order by date_format(`datetime`,"%X-%V")

























