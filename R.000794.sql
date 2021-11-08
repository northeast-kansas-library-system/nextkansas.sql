/*
R.000794

----------

Name: Monthly ILL (Borrows)
Created by:  Tongie Book Club

----------

Group: Administrative Reports
     Daily, Monthly, Yearly Stats-admin

Created on: 2010-01-25 09:59:59
Modified on: 2014-01-06 10:39:42
Date last run: 2021-11-01 14:43:16

----------

Public: 0
Expiry: 0

----------

Enhanced! Logic - the items arriving at my branch are not my items.  Use 2-digit month '01' and 4-digit year '2011'.  All Branches.

----------
*/



SELECT branchtransfers.tobranch, COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) AND MONTH(branchtransfers.datesent)= <<Month>> and YEAR(branchtransfers.datesent) = <<Year>> GROUP BY branchtransfers.tobranch

























