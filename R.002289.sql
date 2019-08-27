/*
R.002289

----------

Name: Data for Quarterly Review for Holds Queue Reordering
Created by: Heather Braum

----------

Group: Administrative Reports
     ILL-admin

Created on: 2014-06-25 12:53:52
Modified on: 2014-12-01 11:08:51
Date last run: -

----------

Public: 0
Expiry: 0

----------

This was hardcoded for data in July, August, and September 2014. Can be written for last three months or whatever the date criteria is we want to use. 

----------
*/

SELECT branches.branchname, branches.branchcode, 
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE branches.branchcode=items.homebranch AND (items.homebranch != branchtransfers.tobranch) AND (branchtransfers.frombranch != branchtransfers.tobranch) AND year(branchtransfers.datesent)='2014' AND month(branchtransfers.datesent) IN ('08','09','10','11')) as loans,
(SELECT count(*) FROM branchtransfers LEFT JOIN items USING(itemnumber) WHERE branches.branchcode=branchtransfers.tobranch AND (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) AND year(branchtransfers.datesent)='2014' AND month(branchtransfers.datesent) IN ('08','09','10','11')) as borrows
FROM branches WHERE branches.branchcode NOT IN ('DIGITAL','PAOLA','LOUISBURG')
GROUP BY branches.branchcode 
LIMIT 100



