/*
R.002959

----------

Name: GHW - Items about to be automatically deleted
Created by: George Williams

----------

Group: -
     -

Created on: 2017-06-21 17:08:16
Modified on: 2024-01-17 11:49:47
Date last run: 2025-10-14 14:18:53

----------

Public: 0
Expiry: 300

----------

 
Generates a list of items that will be automatically deleted two months from today
Shows items that are about to be deleted
at the branch you specify
grouped by item number
sorted by homebranch, location, item type, collection code, call number, author, and title
contains links to the bibliographic records of the items about to be deleted

Notes:

Updated 2017.09.08 to correct for some errors/problems that have come up in the auto-deletion process.

This report goes along with the script that NExpress asked ByWater to write in 2015 that automatically deletes any items that have had a "Lost," "Lost (more than 45 days overdue)," "Missing," "Lost - Damaged/Replace," "Lost - Patron Claims Returned," "In Processing," "Discard," "Lost - Not Returnable," or  "Withdrawn" status for more than 13 months.  This report allows libraries to see what these items are 2 months before the items are scheduled to be deleted.

The report will show all deletions that are scheduled to happen 2 months in the future.  For example, if you run the report in January, you will see what is going to be deleted automatically through the end of March.  If you run it in July, you will see what is going to be deleted through the end of September.  If you run it in December, you will see what is going to be deleted through the end of February of the next year.

Click here to run in a new window


----------
*/



SELECT
  Concat('', biblio.biblionumber, '') AS LINK_TO_TITLE,
  Concat("-", items.barcode, "-") AS BARCODE,
  items.homebranch,
  Concat(itemtypes.description, " (", items.itype, ")") AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="c"]')) AS FULL_TITLE,
  biblioitems.publicationyear,
  Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) AS LAST_CHANGE,
  Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH AS AUTO_DELETE_DATE,
  Concat(Coalesce(lcodes.lib, "-"), " | ", Coalesce(wcodes.lib, "-")) AS STATUS
FROM
  biblio
  JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
  JOIN items ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE') ccodes ON items.ccode = ccodes.authorised_value
  JOIN biblioitems ON biblioitems.biblionumber = biblio.biblionumber AND
    items.biblioitemnumber = biblioitems.biblioitemnumber
  JOIN itemtypes ON items.itype = itemtypes.itemtype
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOST') lcodes ON items.itemlost = lcodes.authorised_value
  LEFT JOIN (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'withdrawn') wcodes ON items.withdrawn = wcodes.authorised_value
WHERE
  items.homebranch LIKE &lt;&gt; AND
  ((items.itemlost &gt; 0 AND
  (Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH) &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL -2 MONTH)), 1)) OR
  (items.withdrawn &gt; 0 AND
  (Greatest(Coalesce(CAST(items.dateaccessioned AS DATE), 0),
    Coalesce(CAST(items.datelastborrowed AS DATE), 0),
    Coalesce(CAST(items.datelastseen AS DATE), 0),
    Coalesce(CAST(items.itemlost_on AS DATE), 0),
    Coalesce(CAST(items.withdrawn_on AS DATE), 0),
    Coalesce(CAST(items.timestamp AS DATE), 0)) + INTERVAL 13 MONTH) &lt; AddDate(Last_Day(SubDate(Now(), INTERVAL -2 MONTH)), 1)))
GROUP BY
  biblio.biblionumber,
  items.itemnumber
ORDER BY
  items.homebranch,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























