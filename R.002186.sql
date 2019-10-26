/*
R.002186

----------

Name: Yearly ILL Borrows and Loans for Groups of CCodes
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2014-02-07 00:20:40
Modified on: 2014-02-07 00:20:40
Date last run: -

----------

Public: 0
Expiry: 300

----------

Run off hours; DVD/TV Series, Videogame, and All other CCode Borrows and Loan numbers in a year. 

----------
*/

SELECT branches.branchcode, 
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('DVD','TVSERIES')) as "DVD TV Series Borrows",  
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('VIDEOGAME')) AS "Videogame Borrows", 
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<enter year>> AND items.ccode NOT IN ('DVD','TVSERIES','VIDEOGAME')) as "All Other Borrows", 
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) and YEAR(datesent)=<<enter year>> AND items.ccode IN ('DVD','TVSERIES')) AS "DVD TV Series Loans", 
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) and YEAR(datesent)=<<enter year>>AND items.ccode IN ('VIDEOGAME')) AS "Videogame Loans",
(SELECT COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) 
WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) and YEAR(datesent)=<<enter year>> AND items.ccode NOT IN ('DVD','TVSERIES','VIDEOGAME')) AS "All Other Loans"    
FROM branches


