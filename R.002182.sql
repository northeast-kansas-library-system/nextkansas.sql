/*
R.002182

----------

Name: Yearly ILL Borrows for Book Materials
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2014-02-06 14:42:49
Modified on: 2014-02-06 14:59:33
Date last run: -

----------

Public: 0
Expiry: 0

----------

Non-AV Ccodes

----------
*/

SELECT branchtransfers.tobranch, COUNT(*) as borrows FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('XXX','BILINGUAL','BIOGRAPHY','BOARDBK','BOOKONCASS','BOOKONCD','BOOKONMP','READER','EDUCATION','FICTION','GENEALOGY','GRAPHIC','HOLIDAY','INSPRATION','KANSAS','LARGEPRINT','MAP','MYSTERY','NEW','NONFICTION','DISPLAY','OVERSIZE','PAPERBACK','PARENTING','EASY','PROFCOLL','ROMANCE','SF-FANT','SPANISH','WALKIN','WESTERN') GROUP BY branchtransfers.tobranch



