/*
R.003956

----------

Name: sh
Created by: Nikki Hansen

----------

Group: -
     -

Created on: 2026-04-10 13:59:31
Modified on: 2026-04-10 14:00:15
Date last run: 2026-04-10 14:00:21

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  ExtractValue(metadata,'//datafield[@tag="655"]/*') AS ITEM
FROM biblio_metadata
WHERE biblionumber = %; homebranch = <<Pick your branch|branches>>


























