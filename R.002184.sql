/*
R.002184

----------

Name: Yearly ILL Loans for AV Materials
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2014-02-06 14:54:15
Modified on: 2014-02-06 14:59:07
Date last run: -

----------

Public: 0
Expiry: 0

----------

Bluray, DVD, Music, TV Series, VHS, Videogame

----------
*/

SELECT items.homebranch, COUNT(*) as loans FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('BLU-RAY','DVD','MUSIC','TVSERIES','VHS','VIDEOGAME') GROUP BY items.homebranch



