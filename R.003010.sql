/*
R.003010

----------

Name: GHW - SMS Providers List
Created by: George Williams

----------

Group: Administrative Reports
     -

Created on: 2017-11-01 08:24:07
Modified on: 2024-01-17 11:52:03
Date last run: 2017-11-01 08:24:32

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
&lt;p&gt;Generates a list of SMS providers in the system&lt;/p&gt;
&lt;ul&gt;&lt;li&gt;Lists current providers plus the domain name for e-mail to text services&lt;/li&gt;
&lt;li&gt;For all libraries in the system&lt;/li&gt;
&lt;li&gt;grouped and sorted by provider name&lt;/li&gt;
&lt;/ul&gt;&lt;br /&gt;
&lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
&lt;p&gt;&lt;/p&gt;
&lt;p&gt;&lt;a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3010&phase=Run%20this%20report"  target="_blank"&gt;Click here to run in a new window&lt;/a&gt;&lt;/p&gt;
&lt;/div&gt;

----------
*/



SELECT
  sms_providers.name,
  sms_providers.domain
FROM
  sms_providers
GROUP BY
  sms_providers.name,
  sms_providers.domain

























