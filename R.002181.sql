/*
R.002181

----------

Name: Yearly ILL Borrows for AV Materials
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2014-02-06 14:41:13
Modified on: 2014-02-06 14:59:24
Date last run: -

----------

Public: 0
Expiry: 0

----------

Bluray, DVD, Music, TV Series, VHS, Videogame

----------
*/

SELECT branchtransfers.tobranch, COUNT(*) as borrows FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('BLU-RAY','DVD','MUSIC','TVSERIES','VHS','VIDEOGAME') GROUP BY branchtransfers.tobranch



