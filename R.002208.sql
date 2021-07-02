/*
R.002208

----------

Name: Top 20 Holds (as of 3-12-14) with priorities
Created by: Heather Braum

----------

Group: Administrative Reports
     -

Created on: 2014-03-13 13:25:08
Modified on: 2014-03-13 13:25:23
Date last run: 2021-06-28 16:17:52

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT b.biblionumber, b.title, r.borrowernumber, r.reservedate, r.branchcode, r.priority, r.found, r.timestamp FROM reserves r LEFT JOIN biblio b USING(biblionumber) WHERE b.biblionumber IN ('598448','621613','598444','598453','598426','598493','621614','598445','621935','597373','621801','454326','621615','598449','598451','621616','598461','590004','620569','597012') ORDER BY b.biblionumber, r.priority LIMIT 3000



