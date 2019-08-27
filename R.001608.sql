/*
R.001608

----------

Name: For duplicate record analysis
Created by: Heather Braum

----------

Group: Administrative Reports
     Duplicate Records-admin

Created on: 2012-10-28 18:21:08
Modified on: 2017-12-18 14:56:33
Date last run: 2018-12-04 13:24:57

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT ExtractValue(metadata, '//datafield[@tag="020"]/subfield[@code="a"]') as isbna, ExtractValue(metadata, '//datafield[@tag="024"]/subfield[@code="a"]') as upc FROM biblio_metadata WHERE (itemtype NOT IN ('MAGAZINE','DIGITAL','KITS','EQUIPMENT','ILL') OR itemtype IS NULL)



