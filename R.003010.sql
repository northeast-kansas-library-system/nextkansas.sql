/*
R.003010

----------

Name: GHW - SMS Providers List
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2017-11-01 08:24:07
Modified on: 2018-04-16 11:11:41
Date last run: 2017-11-01 08:24:32

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of SMS providers in the system</p>
<ul><li>Lists current providers plus the domain name for e-mail to text services</li>
<li>For all libraries in the system</li>
<li>grouped and sorted by provider name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3010&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

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



