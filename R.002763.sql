/*
R.002763

----------

Name: GHW - Items more than XX days overdue
Created by: George Williams

----------

Group: Circulation
     Overdues

Created on: 2016-09-06 10:02:52
Modified on: 2024-01-17 11:36:48
Date last run: 2025-05-17 14:18:15

----------

Public: 0
Expiry: 0

----------

 
Generates a list of items checked out at a specified branch that are owned by a specified branch and are now overdue for more than a specified number of days
Shows current data
Shows items checked out at the library you specify, owned by the location you specify, and overdue for more than the number of days you specify
grouped by check-out library, owning library, item classification, author, title, and due date
contains links to the item's bibliographic record

Notes:
Report created at the request of LANSING.
Report created by George Williams.



----------
*/



SELECT
  Concat('', biblio.biblionumber,  '') AS LINK_TO_TITLE,
  issues.branchcode AS CHECK_OUT_BRANCH,
  items.barcode,
  CONCAT_WS('',items.location,items.ccode,items.itype,items.itemcallnumber) AS CLASSIFICATION,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata,  '//datafield[@tag="245"]/subfield[@code="b"]'),  ExtractValue(biblio_metadata.metadata,  '//datafield[@tag="245"]/subfield[@code="p"]'),  ExtractValue(biblio_metadata.metadata,  '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  items.dateaccessioned AS DATE_ADDED,
  items.datelastborrowed,
  items.datelastseen AS DATE_LAST_CHECKED_IN,
  items.onloan AS DATE_DUE,
  SUM(IFNULL(items.issues, 0) + IFNULL(items.renewals, 0)) AS CHECK_OUTS_PLUS_RENEWALS,
  If(Sum(items.damaged + items.itemlost + items.withdrawn) = 0, ' ',
  'Damaged, lost, or withdrawn') AS STATUS_PROBLEMS,
  items.homebranch AS ITEMS_HOMEBRANCH
FROM
  items JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata
    ON biblio_metadata.biblionumber = biblio.biblionumber AND
    items.biblionumber = biblio_metadata.biblionumber JOIN
  issues
    ON issues.itemnumber = items.itemnumber
WHERE
  issues.branchcode  LIKE &lt;&gt;AND
  items.homebranch  LIKE &lt;&gt; AND
  items.onloan &lt;= (NOW() - INTERVAL &lt;&gt; DAY)
GROUP BY
  issues.branchcode,
  items.homebranch,
  items.location,
  items.ccode,
  items.itype,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  items.onloan


























