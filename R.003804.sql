/*
R.003804

----------

Name: GMD list
Created by: Robin Hastings

----------

Group:  NEKLS
     -

Created on: 2024-03-07 07:37:42
Modified on: 2024-03-07 07:37:48
Date last run: 2024-03-07 07:39:24

----------

Public: 0
Expiry: 300

----------

Pulls list of GMDs in use in the catalog

----------
*/



SELECT ExtractValue(metadata, '//datafield[@tag="245"]/subfield[@code="h"]') AS GMD, 
       count(*) AS COUNT
       From biblio_metadata 
       GROUP BY GMD ORDER BY COUNT DESC

























