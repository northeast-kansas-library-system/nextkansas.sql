/*
R.003232

----------

Name: GHW - Multi card duplicate helper
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-22 12:01:08
Modified on: 2019-07-22 13:49:24
Date last run: 2022-02-08 11:43:25

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
    '&lt;br /&gt;DUPLICATE ACCOUNTS&lt;br /&gt;<br />This patron appears to have multiple accounts.&lt;br /&gt;<br />This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:&lt;ul&gt;<br />',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank"&gt;',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '&lt;/a&gt;&lt;/li&gt;<br />',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank"&gt;',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '&lt;/a&gt;&lt;/li&gt;<br />',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank"&gt;',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '&lt;/a&gt;&lt;/li&gt;<br />',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank"&gt;',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '&lt;/a&gt;&lt;/li&gt;<br />',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank"&gt;',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '&lt;/a&gt;&lt;/li&gt;<br />',

    '&lt;/ul&gt;',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.&lt;br /&gt;<br />',
    'These accounts appear similar because&lt;ul&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar names&lt;/li&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar birthdates&lt;/li&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar contact information&lt;/li&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar addresses&lt;/li&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar phone numbers&lt;/li&gt;<br />',
    '&lt;li&gt;These accounts have the same/similar email addresses&lt;/li&gt;<br />',
    '&lt;br /&gt; PER Next Search Catalog policy, with few exceptions, each patron should only have one account.&lt;br /&gt;<br />GHW - NEKLS&lt;br /&gt;<br />'
  ) AS CARDONE,

  Concat(
    '&lt;br /&gt;DUPLICATE ACCOUNTS&lt;br /&gt;This patron appears to have multiple accounts.&lt;br /&gt;This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:&lt;ul&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank"&gt;',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank"&gt;',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank"&gt;',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank"&gt;',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank"&gt;',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;/ul&gt;',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.&lt;br /&gt;',
    'These accounts appear similar because&lt;ul&gt;',
    '&lt;li&gt;These accounts have the same/similar names&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar birthdates&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar contact information&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar addresses&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar phone numbers&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar email addresses&lt;/li&gt;',
    '&lt;br /&gt; PER Next Search Catalog policy, with few exceptions, each patron should only have one account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;'
  ) AS CARDTWO,

  Concat(
    '&lt;br /&gt;DUPLICATE ACCOUNTS&lt;br /&gt;This patron appears to have multiple accounts.&lt;br /&gt;This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:&lt;ul&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank"&gt;',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank"&gt;',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank"&gt;',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank"&gt;',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank"&gt;',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;/ul&gt;',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.&lt;br /&gt;',
    'These accounts appear similar because&lt;ul&gt;',
    '&lt;li&gt;These accounts have the same/similar names&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar birthdates&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar contact information&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar addresses&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar phone numbers&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar email addresses&lt;/li&gt;',
    '&lt;br /&gt; PER Next Search Catalog policy, with few exceptions, each patron should only have one account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;'
  ) AS CARDTHREE,

  Concat(
    '&lt;br /&gt;DUPLICATE ACCOUNTS&lt;br /&gt;This patron appears to have multiple accounts.&lt;br /&gt;This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:&lt;ul&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank"&gt;',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank"&gt;',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank"&gt;',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank"&gt;',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank"&gt;',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;/ul&gt;',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.&lt;br /&gt;',
    'These accounts appear similar because&lt;ul&gt;',
    '&lt;li&gt;These accounts have the same/similar names&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar birthdates&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar contact information&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar addresses&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar phone numbers&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar email addresses&lt;/li&gt;',
    '&lt;br /&gt; PER Next Search Catalog policy, with few exceptions, each patron should only have one account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;'
  ) AS CARDFOUR,

  Concat(
    '&lt;br /&gt;DUPLICATE ACCOUNTS&lt;br /&gt;This patron appears to have multiple accounts.&lt;br /&gt;This account (',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '), and the following accounts:&lt;ul&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat1.borrowernumber,
    '" target="_blank"&gt;',
    pat1.cardnumber,
    ' - ',
    pat1.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat2.borrowernumber,
    '" target="_blank"&gt;',
    pat2.cardnumber,
    ' - ',
    pat2.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat3.borrowernumber,
    '" target="_blank"&gt;',
    pat3.cardnumber,
    ' - ',
    pat3.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat4.borrowernumber,
    '" target="_blank"&gt;',
    pat4.cardnumber,
    ' - ',
    pat4.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;li&gt;&lt;a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
    pat5.borrowernumber,
    '" target="_blank"&gt;',
    pat5.cardnumber,
    ' - ',
    pat5.branchcode,
    '&lt;/a&gt;&lt;/li&gt;',

    '&lt;/ul&gt;',
    'Please check with the patron to determine which account is the active account and', ' d', 'elete all of the inactive accounts.&lt;br /&gt;',
    'These accounts appear similar because&lt;ul&gt;',
    '&lt;li&gt;These accounts have the same/similar names&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar birthdates&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar contact information&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar addresses&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar phone numbers&lt;/li&gt;',
    '&lt;li&gt;These accounts have the same/similar email addresses&lt;/li&gt;',
    '&lt;br /&gt; PER Next Search Catalog policy, with few exceptions, each patron should only have one account.&lt;br /&gt;GHW - NEKLS&lt;br /&gt;'
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


























