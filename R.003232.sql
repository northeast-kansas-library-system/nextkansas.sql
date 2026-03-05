/*
R.003232

----------

Name: GHW - Multi card duplicate helper
Created by: George Williams

----------

Group: -
     -

Created on: 2019-07-22 12:01:08
Modified on: 2019-07-22 13:49:24
Date last run: 2022-12-14 11:31:38

----------

Public: 0
Expiry: 300

----------

Add to select as necessary

Add 
borrowers patX

for X cards

Add 

patX.cardnumber = <<Card X>>

for X cards

----------
*/



SELECT

  Concat(
    '<br />DUPLICATE ACCOUNTS<br /><br />This patron appears to have multiple accounts.<br /><br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:<ul><br />',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank">',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '</a></li><br />',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '</a></li><br />',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank">',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '</a></li><br />',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank">',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '</a></li><br />',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank">',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '</a></li><br />',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.<br /><br />',
    'These accounts appear similar because<ul><br />',
    '<li>These accounts have the same/similar names</li><br />',
    '<li>These accounts have the same/similar birthdates</li><br />',
    '<li>These accounts have the same/similar contact information</li><br />',
    '<li>These accounts have the same/similar addresses</li><br />',
    '<li>These accounts have the same/similar phone numbers</li><br />',
    '<li>These accounts have the same/similar email addresses</li><br />',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br /><br />GHW - NEKLS<br /><br />'
  ) AS CARDONE,

  Concat(
    '<br />DUPLICATE ACCOUNTS<br />This patron appears to have multiple accounts.<br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:<ul>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank">',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank">',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank">',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank">',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '</a></li>',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.<br />',
    'These accounts appear similar because<ul>',
    '<li>These accounts have the same/similar names</li>',
    '<li>These accounts have the same/similar birthdates</li>',
    '<li>These accounts have the same/similar contact information</li>',
    '<li>These accounts have the same/similar addresses</li>',
    '<li>These accounts have the same/similar phone numbers</li>',
    '<li>These accounts have the same/similar email addresses</li>',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br />GHW - NEKLS<br />'
  ) AS CARDTWO,

  Concat(
    '<br />DUPLICATE ACCOUNTS<br />This patron appears to have multiple accounts.<br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:<ul>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank">',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank">',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank">',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank">',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '</a></li>',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.<br />',
    'These accounts appear similar because<ul>',
    '<li>These accounts have the same/similar names</li>',
    '<li>These accounts have the same/similar birthdates</li>',
    '<li>These accounts have the same/similar contact information</li>',
    '<li>These accounts have the same/similar addresses</li>',
    '<li>These accounts have the same/similar phone numbers</li>',
    '<li>These accounts have the same/similar email addresses</li>',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br />GHW - NEKLS<br />'
  ) AS CARDTHREE,

  Concat(
    '<br />DUPLICATE ACCOUNTS<br />This patron appears to have multiple accounts.<br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:<ul>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank">',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank">',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank">',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank">',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '</a></li>',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.<br />',
    'These accounts appear similar because<ul>',
    '<li>These accounts have the same/similar names</li>',
    '<li>These accounts have the same/similar birthdates</li>',
    '<li>These accounts have the same/similar contact information</li>',
    '<li>These accounts have the same/similar addresses</li>',
    '<li>These accounts have the same/similar phone numbers</li>',
    '<li>These accounts have the same/similar email addresses</li>',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br />GHW - NEKLS<br />'
  ) AS CARDFOUR,

  Concat(
    '<br />DUPLICATE ACCOUNTS<br />This patron appears to have multiple accounts.<br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:<ul>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank">',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank">',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank">',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank">',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '</a></li>',

    '<li><a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank">',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '</a></li>',

    '</ul>',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.<br />',
    'These accounts appear similar because<ul>',
    '<li>These accounts have the same/similar names</li>',
    '<li>These accounts have the same/similar birthdates</li>',
    '<li>These accounts have the same/similar contact information</li>',
    '<li>These accounts have the same/similar addresses</li>',
    '<li>These accounts have the same/similar phone numbers</li>',
    '<li>These accounts have the same/similar email addresses</li>',
    '<br /> PER Next Search Catalog policy, with few exceptions, each patron should only have one account.<br />GHW - NEKLS<br />'
  ) AS CARDFIVE


FROM
  borrowers pat1,
  borrowers pat2,
  borrowers pat3,
  borrowers pat4,
  borrowers pat5

WHERE
  pat1.cardnumber = <<Card 1>> AND
  pat2.cardnumber = <<Card 2>> AND
  pat3.cardnumber = <<Card 3>> AND
  pat4.cardnumber = <<Card 4>> AND
  pat5.cardnumber = <<Card 5>>


























