/*
R.003283

----------

Name: GHW - Search for borrower by SMS text message number
Created by: George Williams

----------

Group: Borrowers
     -

Created on: 2019-11-27 10:45:22
Modified on: 2024-01-17 12:05:57
Date last run: 2022-10-06 14:38:32

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Find a patron's card number based on a portion of their SMS text messaging number&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows all patrons that currently have that portion of an SMS text number&lt;/li&gt;
&lt;li&gt;at all libraries&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber&lt;/li&gt;
&lt;li&gt;grouped by text messaging phone number&lt;/li&gt;
&lt;li&gt;links to the patron's account&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Text message numbers are ten digits long and  only contain numerals - no spaces, letters, or punctuation.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3283&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('Go to patron account') AS LINK,
  borrowers.cardnumber,
  borrowers.smsalertnumber
FROM
  borrowers
WHERE
  borrowers.smsalertnumber LIKE CONCAT("%", REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(&lt;&gt;, ' ', ''), '-', ''), '(', ''), ')', ''), '.', ''), "%")
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.smsalertnumber

























