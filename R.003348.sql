/*
R.003348

----------

Name: GHW - Titles with requests
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-08-21 16:22:19
Modified on: 2020-08-21 16:50:22
Date last run: 2020-11-19 13:02:43

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  reserves.branchcode AS PICKUP_AT,
  reserves.reservedate AS REQUESTED_ON,
  If(reserves.suspend_until > 1, Concat('Suspended until ', Date_Format(reserves.suspend_until, "%m/%d/%Y")), If(reserves.suspend = '', 'Active', 'Suspended indefinitely')) AS SUSPENDED,
  biblio.author,
  biblio.title,
  If(reserves.item_level_hold = '', '-', 'Item level request') AS ITEM_LEVEL,
  Concat('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=', reserves.biblionumber, '\" target="_blank">', reserves.biblionumber, '</a>') AS LINK_TO_REQUEST
FROM
  reserves JOIN
  biblio ON reserves.biblionumber = biblio.biblionumber
WHERE
  reserves.branchcode LIKE <<Choose pick-up library|ZBRAN>> AND
  If(reserves.suspend > 0, 'Yes', 'No') LIKE <<Display suspended requests|ZYES_NO>>
GROUP BY
  reserves.reserve_id
ORDER BY
  PICKUP_AT



