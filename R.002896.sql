/*
R.002896

----------

Name: GHW - Items by home library and lost status
Created by: George H Williams

----------

Group: -
     -

Created on: 2017-02-01 16:27:01
Modified on: 2020-08-18 16:40:29
Date last run: 2021-08-11 15:28:17

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Generates a list of lost items</p>
<ul><li>Shows items that currently have the lost status you specify</li>
<li>shows items with a home library that you specify</li>
<li>that were declared lost during the date range you specify</li>
<li>grouped by item barcode number</li>
<li>sorted by NExpress standard classification scheme</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Replaces report 888</p>
<p></p>
<p>If an item has a blank LOST_DATE and a blank DAYS_LOST it is because the item was marked lost before we upgraded to Koha 3.16 (October 2014)</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2896&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/

SELECT
  items.itemnumber AS ITEM_NUMBER,
  items.barcode AS BARCODE,
  items.homebranch AS ITEM_HOME,
  items.holdingbranch,
  items.location AS LOCATION,
  items.itype AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  Concat_Ws(
    ' ',
    biblio.title,
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  losts.lib AS LOST_STATUS,
  If(items.itemlost_on IS NULL, (CAST('2000-02-29' AS DATETIME)), items.itemlost_on) AS LOST_DATE,
  DateDiff(CurDate(), items.itemlost_on) AS DAYS_LOST,
  items.replacementprice
FROM
  items
  JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = "CCODE") ccodes ON items.ccode = ccodes.authorised_value
  LEFT JOIN (SELECT
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOST') losts ON items.itemlost = losts.authorised_value
  JOIN biblio_metadata ON biblio.biblionumber = biblio_metadata.biblionumber
WHERE
  items.homebranch LIKE <<Item home branch|ZBRAN>> AND
  items.itemlost LIKE <<Item lost status|LLOST>> AND
  If(items.itemlost_on IS NULL, (CAST('2000-01-01' AS DATETIME)), items.itemlost_on) BETWEEN <<Lost between start date|date>> AND <<and end date|date>>
GROUP BY
  items.barcode
HAVING
  LOST_DATE 
ORDER BY
  ITEM_HOME,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  FULL_TITLE,
  biblio.author



