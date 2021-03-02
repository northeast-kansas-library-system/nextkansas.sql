/*
R.003007

----------

Name: GHW - Single patron address label
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-10-19 12:23:06
Modified on: 2017-12-22 17:39:12
Date last run: 2018-01-30 14:43:50

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  CONCAT(
    borrowers.firstname,
    " ",
    borrowers.surname,
    "<br />",
    borrowers.address,
    "<br />",
    borrowers.city,
    ", ",
    borrowers.state,
    " ",
    borrowers.zipcode)  AS SINGLE_ADDRESS_LABEL  
FROM
  borrowers
WHERE
  borrowers.cardnumber LIKE Concat("%", <<Enter patron barcode number>>, "%")



