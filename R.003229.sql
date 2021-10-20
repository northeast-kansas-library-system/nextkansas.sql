/*
R.003229

----------

Name: GHW - Reserves - short expiration report
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-18 15:24:51
Modified on: 2019-10-02 15:45:52
Date last run: 2019-10-02 15:46:09

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
  DateDiff(reserves.expirationdate, reserves.reservedate)
FROM
  reserves
WHERE
  DateDiff(reserves.expirationdate, reserves.reservedate) < 365

























