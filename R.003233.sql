/*
R.003233

----------

Name: GHW - Multi card duplicate helper - alternate
Created by: George Williams

----------

Group: -
     -

Created on: 2019-07-22 14:07:34
Modified on: 2019-07-23 08:41:03
Date last run: 2021-11-02 10:46:53

----------

Public: 0
Expiry: 300

----------

Set for 10

----------
*/



SELECT

  Concat(
    '<br />MULTIPLE ACCOUNTS<br />This patron appears to have multiple accounts.<br />',
    
    'This account (', pat1.cardnumber, ' - ', pat1.branchcode, '), and the following other accounts:',
    'This account (', pat2.cardnumber, ' - ', pat2.branchcode, '), and the following other accounts:',
    'This account (', pat3.cardnumber, ' - ', pat3.branchcode, '), and the following other accounts:',
    'This account (', pat4.cardnumber, ' - ', pat4.branchcode, '), and the following other accounts:',
    'This account (', pat5.cardnumber, ' - ', pat5.branchcode, '), and the following other accounts:',
    'This account (', pat6.cardnumber, ' - ', pat6.branchcode, '), and the following other accounts:',
    'This account (', pat7.cardnumber, ' - ', pat7.branchcode, '), and the following other accounts:',
    'This account (', pat8.cardnumber, ' - ', pat8.branchcode, '), and the following other accounts:',
    'This account (', pat9.cardnumber, ' - ', pat9.branchcode, '), and the following other accounts:',
    'This account (', pat10.cardnumber, ' - ', pat10.branchcode, '), and the following other accounts:',
    
    '<ul>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat1.borrowernumber, '" target="_blank">', pat1.cardnumber, ' - ', pat1.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat2.borrowernumber, '" target="_blank">', pat2.cardnumber, ' - ', pat2.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat3.borrowernumber, '" target="_blank">', pat3.cardnumber, ' - ', pat3.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat4.borrowernumber, '" target="_blank">', pat4.cardnumber, ' - ', pat4.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat5.borrowernumber, '" target="_blank">', pat5.cardnumber, ' - ', pat5.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat6.borrowernumber, '" target="_blank">', pat6.cardnumber, ' - ', pat6.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat7.borrowernumber, '" target="_blank">', pat7.cardnumber, ' - ', pat7.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat8.borrowernumber, '" target="_blank">', pat8.cardnumber, ' - ', pat8.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat9.borrowernumber, '" target="_blank">', pat9.cardnumber, ' - ', pat9.branchcode, '</a></li>',
    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=', pat10.borrowernumber, '" target="_blank">', pat10.cardnumber, ' - ', pat10.branchcode, '</a></li>',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d',
    'elete all of the inactive accounts.<br />',
    'These accounts appear similar because',
    '<ul>',
    '<li>These accounts have the same/similar names</li>',
    '<li>These accounts have the same/similar birthdates</li>',
    '<li>These accounts have the same/similar contact information</li>',
    '<li>These accounts have the same/similar addresses</li>',
    '<li>These accounts have the same/similar phone numbers</li>',
    '<li>These accounts have the same/similar email addresses</li>',
    '</ul>',
    'When updating accounts, please be sure to add middle initials and middle names as necessary to make it easier for staff to identify individual patrons.',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br />GHW - NEKLS<br />'
  ) AS INFOBLOCK

FROM
  borrowers pat1,
  borrowers pat2,
  borrowers pat3,
  borrowers pat4,
  borrowers pat5,
  borrowers pat6,
  borrowers pat7,
  borrowers pat8,
  borrowers pat9,
  borrowers pat10

WHERE
  pat1.cardnumber = <> AND
  pat2.cardnumber = <> AND
  pat3.cardnumber = <> AND
  pat4.cardnumber = <> AND
  pat5.cardnumber = <> AND
  pat6.cardnumber = <> AND
  pat7.cardnumber = <> AND
  pat8.cardnumber = <> AND
  pat9.cardnumber = <> AND
  pat10.cardnumber = <>

























