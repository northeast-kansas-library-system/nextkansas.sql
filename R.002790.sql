/*
R.002790

----------

Name: Monthly 007a
Created by: George H Williams

----------

Group: Administrative Reports
     Reports Testing Ground

Created on: 2016-10-07 12:53:57
Modified on: 2018-12-08 22:55:58
Date last run: 2018-12-09 21:26:20

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT branches.branchcode as Library, 
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) AND (MONTH(branchtransfers.datesent)=@MONTH:=<<Choose month|MONTH>> COLLATE utf8mb4_unicode_ci) AND (YEAR(branchtransfers.datesent)=@YEAR:=<<Choose year|YEAR>> COLLATE utf8mb4_unicode_ci)) as loans,
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING(itemnumber) WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) AND MONTH(branchtransfers.datesent)=@MONTH AND YEAR(branchtransfers.datesent)=@YEAR) as borrows,
SUM((SELECT count(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) AND MONTH(branchtransfers.datesent)=@MONTH AND YEAR(branchtransfers.datesent)=@YEAR)-(SELECT count(*) FROM branchtransfers LEFT JOIN items USING(itemnumber) WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) AND MONTH(branchtransfers.datesent)=@MONTH AND YEAR(branchtransfers.datesent)=@YEAR)) as DIFFERENCE
FROM branches WHERE branches.branchcode NOT IN ('DIGITAL','LOUISBURG')
GROUP BY branches.branchcode 
LIMIT 100



