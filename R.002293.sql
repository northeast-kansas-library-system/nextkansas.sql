/*
R.002293

----------

Name: Monthly 007 ILL Loans and Borrows
Created by: Heather Braum

----------

Group: -
     -

Created on: 2014-07-01 12:14:04
Modified on: 2016-10-05 16:16:30
Date last run: 2017-11-07 15:46:42

----------

Public: 0
Expiry: 0

----------

Combined Monthly ILL report
Combined Version of reports #793 & #794


----------
*/

SELECT branches.branchcode as Library, 
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) AND MONTH(branchtransfers.datesent)=<<Choose month|MONTH>> AND YEAR(branchtransfers.datesent)=<<Choose year|YEAR>>) as loans,
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING(itemnumber) WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) AND MONTH(branchtransfers.datesent)=<<Choose Month second time|MONTH>> AND YEAR(branchtransfers.datesent)=<<Choose Year second time|YEAR>>) as borrows
FROM branches WHERE branches.branchcode NOT IN ('DIGITAL','LOUISBURG')
GROUP BY branches.branchcode 
LIMIT 100



