/*
R.003212

----------

Name: GHW - Rotating collections - Report 4 ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-06-10 14:42:31
Modified on: 2019-06-10 14:53:44
Date last run: 2019-06-10 14:44:56

----------

Public: 0
Expiry: 300

----------

List of problematic URLs

----------
*/

SELECT
  Concat("https://staff.nextkansas.org/cgi-bin/koha/rotating_collections/addItems.pl?colId=", collections_tracking.colId, "&barcode=", items.barcode, "&removeItem=1&action=addItem") AS URLS
FROM
  collections_tracking
  JOIN items
    ON items.itemnumber = collections_tracking.itemnumber
WHERE
  collections_tracking.colId = <<Enter collection ID number>>



