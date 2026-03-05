/*
R.003319

----------

Name: GHW - COVID-19 Self-registered duplicate
Created by: George Williams

----------

Group: -
     -

Created on: 2020-04-13 14:47:24
Modified on: 2020-04-13 14:47:24
Date last run: 2020-07-08 14:35:42

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat(
    '<br />SELF-REGISTERED DUPLICATE PATRON<br />This patron appears to have self-registered for a second account during the COVID-19 emergency and now has two accounts.  This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    ') and another with card number  <a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '.</a><br />The self-registered account should not be renewed or updated after the emergency has passed.<br />GHW - NEKLS<br />'
  ) AS CARDONE,
  Concat(
    '<br />SELF-REGISTERED DUPLICATE PATRON<br />This patron appears to have self-registered for a second account during the COVID-19 emergency and now has two accounts.  This account (',
      pat2.cardnumber,
      ' - ',
      pat2.branchcode,
      ') and another with card number  <a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
      pat1.borrowernumber,
      '" target="_blank">',
      pat1.cardnumber,
      ' - ',
      pat1.branchcode,
      '.</a><br />The self-registered account should not be renewed or updated after the emergency has passed.<br />GHW - NEKLS<br />'
  ) AS CARDTWO
FROM borrowers pat1,
     borrowers pat2
WHERE pat1.cardnumber = <<Card one>>
  AND pat2.cardnumber = <<Card two>>

























