/*
R.002910

----------

Name: GHW - Bounced e-mail helper
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2017-02-20 18:56:41
Modified on: 2024-04-18 08:30:44
Date last run: 2024-07-19 09:06:59

----------

Public: 0
Expiry: 0

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of patrons based on their e-mail address and produces a "Bounced Email" message that can be quickly cut and pasted into a message on the patron's account.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all borrowers that are using the specified e-mail address&lt;/li&gt;
&lt;li&gt;Shows borrowers at all NExpress branches with that e-mail address&lt;/li&gt;
&lt;li&gt;grouped by barcode number&lt;/li&gt;
&lt;li&gt;includes links to the patron record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;If more than one patron is using the e-mail address you enter on their account, you will receive one result in this report for each patron with that e-mail address.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;For bounced text messages, use report 3062.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2910&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  borrowers.email,
  borrowers.cardnumber,
  Concat("&lt;br /&gt;BOUNCED EMAIL&lt;br /&gt;An e-mail sent to this patron's e-mail address &lt;strong&gt;(",borrowers.email,")&lt;/strong&gt; bounced.&lt;br /&gt;Please confirm the patron's contact information the next time they use their account.&lt;br /&gt;", CurDate()) AS MESSAGE,
  Concat('', borrowers.borrowernumber,'') AS 'LINK_TO_PATRON'
FROM
  borrowers
WHERE
  borrowers.email LIKE CONCAT( '%',&lt;&gt;, '%')
GROUP BY borrowers.cardnumber

























