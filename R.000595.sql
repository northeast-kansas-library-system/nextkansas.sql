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
Date last run: 2025-07-21 13:02:46

----------

Public: 0
Expiry: 0

----------

From John

----------
*/



select date_format(`datetime`,"%X-%V") as 'Week', count(*) as 'Checkouts' from statistics LEFT JOIN items USING (itemnumber) where homebranch=&lt;&gt; AND datetime LIKE &lt;&gt; AND type in ('issue','renew') AND (items.itemcallnumber like &lt;&gt; and type in ('issue','renew') OR &lt;&gt; OR items.location in ('CHILDRENS')) group by date_format(`datetime`,"%X-%V") order by date_format(`datetime`,"%X-%V")

























