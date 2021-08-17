/*
R.000571

----------

Name: Monthly 006 New Materials Added by Collection Code and Location
Created by:  Tongie Book Club

----------

Group: -
     -

Created on: 2009-06-01 16:58:23
Modified on: 2020-12-08 22:47:06
Date last run: 2021-08-02 13:07:19

----------

Public: 0
Expiry: 0

----------

Shows count of new items added to a collection in last month by ccode and shelving location 

----------
*/

SELECT
  items.homebranch AS "Library",
  items.ccode AS "Collection Code",
  items.permanent_location AS "Location",
  Count(items.biblionumber) AS "Total Added"
FROM
  items
WHERE
  Year(items.dateaccessioned) = << Choose year|YEAR>> AND
  Month(items.dateaccessioned) = << Choose month|MONTH >>
GROUP BY
  items.homebranch,
  items.ccode,
  items.permanent_location



