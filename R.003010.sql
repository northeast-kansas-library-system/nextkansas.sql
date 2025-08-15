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

 
Generates a list of SMS providers in the system
Lists current providers plus the domain name for e-mail to text services
For all libraries in the system
grouped and sorted by provider name

Notes:

Click here to run in a new window


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

























