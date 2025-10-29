/*
R.002931

----------

Name: GHW - Card prefix report - System-wide
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2017-04-28 10:56:00
Modified on: 2021-02-25 10:13:54
Date last run: 2024-08-28 09:03:33

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  <> AS CARD_PREFIX_LENGTH,
  UPPER(Left(borrowers.cardnumber, <>)) AS LIBRAY_CARD_PREFIX,
  LENGTH(borrowers.cardnumber) AS CARD_NUMBER_LENGTH,
  Count(borrowers.borrowernumber) AS LIBRARY_CARD_COUNT,
  CONCAT( '>)) ,'&limit=10000 \" target="_blank">Link to report 2773' ) AS LINK_TO_PREFIX_REPORT_2
FROM
  borrowers
GROUP BY
  LIBRAY_CARD_PREFIX, CARD_NUMBER_LENGTH
HAVING
  LIBRARY_CARD_COUNT >= <>
ORDER BY
  LIBRAY_CARD_PREFIX, CARD_NUMBER_LENGTH

























