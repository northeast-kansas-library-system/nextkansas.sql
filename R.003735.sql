/*
R.003735

----------

Name: GHW - koha-US Permissions testing
Created by: George Williams

----------

Group: -
     -

Created on: 2023-06-13 12:04:35
Modified on: 2023-06-13 12:04:35
Date last run: 2025-01-24 08:58:42

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  userflags.bit,
  If(userflags.bit < 7, userflags.bit + 1, userflags.bit) AS HTML_FLAG_NUMBER,
  power(2, userflags.bit) AS FLAGS,
  userflags.flag,
  userflags.flagdesc,
  userflags.defaulton
FROM
  userflags

























