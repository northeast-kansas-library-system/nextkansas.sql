/*
R.002931

----------

Name: GHW - Card prefix report - System-wide
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2017-04-28 10:56:00
Modified on: 2021-02-25 10:13:54
Date last run: 2021-02-25 10:01:13

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  <<Number of digits in card prefix|YNUMBER>> AS CARD_PREFIX_LENGTH,
  UPPER(Left(borrowers.cardnumber, <<Number of digits in card prefix|YNUMBER>>)) AS LIBRAY_CARD_PREFIX,
  LENGTH(borrowers.cardnumber) AS CARD_NUMBER_LENGTH,
  Count(borrowers.borrowernumber) AS LIBRARY_CARD_COUNT,
  CONCAT( '<a href=\"/cgi-bin/koha/reports/guided_reports.pl?phase=Run+this+report&reports=2773&sql_params=', (Left(borrowers.cardnumber, <<Number of digits in card prefix|YNUMBER>>)) ,'&limit=10000 \" target="_blank">Link to report 2773</a>' ) AS LINK_TO_PREFIX_REPORT_2
FROM
  borrowers
GROUP BY
  LIBRAY_CARD_PREFIX, CARD_NUMBER_LENGTH
HAVING
  LIBRARY_CARD_COUNT >= <<Minimum card number count|YNUMBER>>
ORDER BY
  LIBRAY_CARD_PREFIX, CARD_NUMBER_LENGTH



