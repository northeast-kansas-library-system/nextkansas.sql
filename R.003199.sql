/*
R.003199

----------

Name: GHW - Lookup payment details by receipt number
Created by: George Williams

----------

Group: -
     -

Created on: 2019-05-06 16:00:50
Modified on: 2024-01-17 11:54:32
Date last run: 2022-07-20 13:55:06

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Look up payment and writeoff details by Next Search Catalog receipt number.&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Shows payments and writeoffs still logged in the database&lt;/li&gt;
&lt;li&gt;grouped by borrowernumber and receipt number&lt;/li&gt;
&lt;li&gt;contains a link to the corresponding details page in the patron's fines/fees record&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;Details on payments and writeoffs made prior to the addition of the accounts offsets table in 2018 will not include details about which outstanding fees were reconciled by a specific payment.&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p id="rquickopen"&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3199&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  Concat('LINK') AS LINK_TO_DETAILS,
  accountlines.borrowernumber,
  borrowers.cardnumber,
  borrowers.surname,
  borrowers.firstname,
  borrowers.branchcode
FROM
  accountlines
  JOIN borrowers
    ON accountlines.borrowernumber = borrowers.borrowernumber
WHERE
  accountlines.accountlines_id = &lt;&gt;
GROUP BY
  accountlines.borrowernumber,
  accountlines.accountlines_id

























