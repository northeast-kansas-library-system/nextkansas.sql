/*
R.000966

----------

Name: Cumulative ILL Borrows for Specific Branch
Created by: -

----------

Group: Daily, Monthly, Yearly Stats
     Yearly

Created on: 2010-10-25 15:30:46
Modified on: 2013-06-18 18:26:41
Date last run: 2018-12-10 12:39:49

----------

Public: 0
Expiry: 0

----------

Enhanced.  Pick Receiving Branch and 4-digit year. 

----------
*/

SELECT branchtransfers.tobranch, MONTH(datesent), COUNT(*) FROM branchtransfers LEFT JOIN items USING (itemnumber) WHERE (branchtransfers.tobranch != items.homebranch) AND (branchtransfers.tobranch != branchtransfers.frombranch) and YEAR(datesent)=<<Year>> and branchtransfers.tobranch=<<Pick Receiving Branch|branches>> GROUP BY MONTH(datesent)



