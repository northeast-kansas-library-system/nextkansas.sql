/*
R.002772

----------

Name: GHW - Guarantors with guarantees that owe money
Created by: George Williams

----------

Group: Administrative Reports
     Reports Testing Ground

Created on: 2016-09-13 20:06:28
Modified on: 2018-06-04 10:52:10
Date last run: 2024-07-23 16:52:55

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  CONCAT('Link to guarantor') AS LINK_TO_GUARANTOR,
  Concat_WS('',
    Concat("Cardnumber: ", Guarantors.cardnumber),
    Concat('Home: ', Guarantors.branchcode)
  ) AS GUARANTOR_INFO,
  CONCAT(Guarantors.surname, IF(Guarantors.firstname is null, "", Concat(", ", Guarantors.firstname))) AS GUARANTOR,
  CONCAT_WS('',Guarantors.address, (CONCAT_WS(' ',(CONCAT_WS(', ',Guarantors.city, Guarantors.state)),Guarantors.zipcode)), Guarantors.phone,Guarantors.email) AS GUARANTOR_CONTACT,
  Concat_WS('',
    Concat("Cardnumber: ", Guarantees.cardnumber),
    Concat('Home: ', Guarantees.branchcode)
  ) AS GUARANTEE_INFO,
  CONCAT(Guarantees.surname, IF(Guarantees.firstname is null, "", Concat(", ", Guarantees.firstname))) AS GUARANTEE,
  CONCAT_WS('',Guarantees.address, (CONCAT_WS(' ',(CONCAT_WS(', ',Guarantees.city, Guarantees.state)),Guarantees.zipcode)), Guarantees.phone,Guarantees.email) AS GUARANTEE_CONTACT,
  FORMAT(Sum(accountlines.amountoutstanding),2) AS AMOUNT_OUTSTANIDING,
  CONCAT('Link to guarantee') AS LINK_TO_GUARANTEE
FROM
  borrowers Guarantors INNER JOIN
  borrowers Guarantees
    ON Guarantors.borrowernumber = Guarantees.guarantorid LEFT JOIN
  accountlines
    ON accountlines.borrowernumber = Guarantees.borrowernumber
WHERE
  Guarantors.branchcode LIKE <>
GROUP BY
  Guarantors.borrowernumber,
  Guarantees.borrowernumber
HAVING
  Sum(accountlines.amountoutstanding) > <>
ORDER BY
  Guarantors.branchcode,
  Guarantors.surname,
  Guarantors.firstname,
  Guarantees.firstname,
  Guarantees.surname

























