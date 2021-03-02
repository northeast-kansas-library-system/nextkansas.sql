/*
R.002763

----------

Name: GHW - Items more than XX days overdue
Created by: George H Williams

----------

Group: Circulation
     Overdues

Created on: 2016-09-06 10:02:52
Modified on: 2018-04-16 10:48:35
Date last run: 2019-01-25 10:24:52

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of items checked out at a specified branch that are owned by a specified branch and are now overdue for more than a specified number of days</p>
<ul><li>Shows current data</li>
<li>Shows items checked out at the library you specify, owned by the location you specify, and overdue for more than the number of days you specify</li>
<li>grouped by check-out library, owning library, item classification, author, title, and due date</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Report created at the request of LANSING.</p>
<p>Report created by George Williams.</p>
</div>


----------
*/

SELECT
  Concat('<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',  biblio.biblionumber, '\" target="_blank">', biblio.biblionumber,  '</a>') AS LINK_TO_TITLE,
  issues.branchcode AS CHECK_OUT_BRANCH,
  items.barcode,
  CONCAT_WS('<br />',items.location,items.ccode,items.itype,items.itemcallnumber) AS CLASSIFICATION,
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
  issues.branchcode  LIKE <<Pick the item's check-out branch|LBRANCH>>AND
  items.homebranch  LIKE <<Pick the item's home branch|LBRANCH>> AND
  items.onloan <= (NOW() - INTERVAL <<Select the number of days overdue>> DAY)
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




