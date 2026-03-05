/*
R.003217

----------

Name: GHW - Duplicate card helper
Created by: George Williams

----------

Group: -
     -

Created on: 2019-07-12 00:20:17
Modified on: 2019-07-22 11:39:15
Date last run: 2024-08-29 14:45:33

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat('<br />POSSIBLE DUPLICATE PATRON<br />There are two patrons with this name and birth date.  This account (', pat1.cardnumber, ' - ',  pat1.branchcode, ') and another with card number  <a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat2.borrowernumber, '" target="_blank">', pat2.cardnumber, ' - ',  pat2.branchcode, '.</a><br />Please check with the patron to determine which account is the active account and', ' d', 'elete the inactive account.<br />GHW - NEKLS<br />') AS CARDONE,
  Concat('<br />POSSIBLE DUPLICATE PATRON<br />There are two patrons with this name and birth date.  This account (', pat2.cardnumber, ' - ',  pat2.branchcode, ') and another with card number  <a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat1.borrowernumber, '" target="_blank">', pat1.cardnumber, ' - ',  pat1.branchcode, '.</a><br />Please check with the patron to determine which account is the active account and', ' d', 'elete the inactive account.<br />GHW - NEKLS<br />') AS CARDTWO
FROM
  borrowers pat1,
  borrowers pat2
WHERE
  pat1.cardnumber = <<Card one>> AND
  pat2.cardnumber = <<Card two>>

























