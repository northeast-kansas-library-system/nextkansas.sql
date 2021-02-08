/*
R.003401

----------

Name: koha-US test 2102
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-13 02:09:27
Modified on: 2021-01-13 02:09:27
Date last run: 2021-01-15 16:13:58

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
        old_reserves.reserve_id,
        old_reserves.borrowernumber,
        old_reserves.reservedate,
        old_reserves.biblionumber,
        old_reserves.branchcode,
        old_reserves.notificationdate,
        old_reserves.reminderdate,
        old_reserves.cancellationdate,
        old_reserves.reservenotes,
        old_reserves.priority,
        old_reserves.found,
        old_reserves.timestamp,
        old_reserves.itemnumber,
        old_reserves.waitingdate,
        old_reserves.expirationdate,
        old_reserves.lowestPriority,
        old_reserves.suspend,
        old_reserves.suspend_until,
        old_reserves.itemtype,
        If(old_reserves.cancellationdate IS NOT NULL, "Cancelled", "Filled") AS statuss
      FROM
        old_reserves



