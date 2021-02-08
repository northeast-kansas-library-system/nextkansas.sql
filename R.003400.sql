/*
R.003400

----------

Name: koha-US test 2101
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-13 02:08:46
Modified on: 2021-01-13 02:08:46
Date last run: 2021-01-15 16:14:01

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
        reserves.reserve_id,
        reserves.borrowernumber,
        reserves.reservedate,
        reserves.biblionumber,
        reserves.branchcode,
        reserves.notificationdate,
        reserves.reminderdate,
        reserves.cancellationdate,
        reserves.reservenotes,
        reserves.priority,
        reserves.found,
        reserves.timestamp,
        reserves.itemnumber,
        reserves.waitingdate,
        reserves.expirationdate,
        reserves.lowestPriority,
        reserves.suspend,
        reserves.suspend_until,
        reserves.itemtype,
        If(reserves.reserve_id IS NOT NULL, "Active", "-") AS statuss
      FROM
        reserves



