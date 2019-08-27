/*
R.003230

----------

Name: GHW - Test 2 - expired holds with short turnarounds
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-18 15:59:12
Modified on: 2019-07-18 15:59:12
Date last run: 2019-07-23 22:26:10

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
  DateDiff(old_reserves.expirationdate, old_reserves.reservedate)
FROM
  old_reserves
WHERE
  DateDiff(old_reserves.expirationdate, old_reserves.reservedate) < 365



