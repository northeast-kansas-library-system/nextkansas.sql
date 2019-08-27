/*
R.002093

----------

Name: DVD Borrows
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2013-11-12 13:08:50
Modified on: 2013-11-17 11:58:09
Date last run: 2017-06-28 12:37:16

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT branchtransfers.tobranch, year(branchtransfers.datesent) AS year, COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch)GROUP BY year(branchtransfers.datesent), branchtransfers.tobranch ORDER BY branchtransfers.tobranch, year



