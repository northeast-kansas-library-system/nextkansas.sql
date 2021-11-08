/*
R.000570

----------

Name: Monthly 005 New Materials Added by Item Type and Location
Created by:  Tongie Book Club

----------

Group: -
     -

Created on: 2009-06-01 16:56:47
Modified on: 2020-12-08 22:41:10
Date last run: 2021-11-03 11:29:22

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by item type and shelving location

----------
*/



SELECT
  items.homebranch AS "Library",
  items.itype AS "Item Type",
  items.permanent_location AS "Location",
  Count(items.biblionumber) AS "Total Added"
FROM
  items
WHERE
  Month(items.dateaccessioned) = <<Choose month|MONTH>> AND
  Year(items.dateaccessioned) = <<Choose year|YEAR>>
GROUP BY
  items.homebranch,
  items.itype,
  items.permanent_location

























