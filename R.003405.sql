/*
R.003405

----------

Name: GHW - VIDEO items with a non-videodisc item type
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-01-14 16:51:37
Modified on: 2021-01-28 14:02:16
Date last run: 2021-01-28 13:46:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Shows list of items with a Video item type and a collection code other than DVD, Blu-ray, Combo, or TV Series</p>
<ul><li>Shows items currently in the system</li>
<li>at the library you specify</li>
<li>grouped by item number, location, collection code, and bibliographic number</li>
<li>sorted by the normal Next classification order</li>
<li>links to the bibliographic record and the edit item page</li>
</ul><br />
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3405&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">collection code cleanup</p>
</div>

----------
*/



SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    item_info.biblionumber, 
    '\" target="_blank">', 
    item_info.biblionumber, 
    '</a>'
  ) AS LINK_TO_ITEM,
  Concat_Ws('<br />', 
    Concat(
      '<a href="/cgi-bin/koha/circ/circulation.pl?borrowernumber=',
      borrowers.borrowernumber, 
      '" target="_blank">Go to patron account</a>'
    ),
    borrowers.cardnumber, 
    If(
      borrowers.othernames = '', 
      Concat(borrowers.surname, ', ', borrowers.firstname), 
      Concat(borrowers.surname, ', ',borrowers.firstname, ' (', borrowers.othernames, ')')
    ),
    borrowers.borrowernumber
  ) AS BORROWER,
  Concat_Ws(' &lt;br&gt;&lt;br&gt; ', 
    'LOST ITEM PROCESSING FEE: ', 
    Concat('Item barcode: ', item_info.barcode), 
    Concat('Owned by: ', item_info.homebranch),
    Concat('Location: ', item_info.PERM_LOCATION), 
    Concat('Item type: ', item_info.ITEM_TYPE), 
    Concat('Collection: ', item_info.COLLECTION_CODE),
    Concat('Call number: ', item_info.itemcallnumber), 
    Concat('Author: ', item_info.author), 
    Concat('Title: ', item_info.FULL_TITLE),
    Concat('Due date: ', old_checkouts.ORIGINAL_DUE_DATE), 
    Concat('Lost on: ', item_info.LOST_ON_DATE, '&lt;br&gt;&lt;br&gt;')
  ) AS FEE_NOTE
FROM
  (SELECT
     old_issues.itemnumber,
     Concat_Ws('-', 
       Year(old_issues.timestamp),
       LPad(Month(old_issues.timestamp), 2, 0), 
       LPad(Day(old_issues.timestamp), 2, 0)
     ) AS LOST_DATE,
     Concat_Ws('-', 
       Year(old_issues.date_due), 
       LPad(Month(old_issues.date_due), 2, 0), 
       LPad(Day(old_issues.date_due), 2, 0)
     ) AS ORIGINAL_DUE_DATE,
     old_issues.borrowernumber,
     old_issues.branchcode
   FROM
     old_issues
   WHERE
     old_issues.branchcode = 'SENECA') old_checkouts JOIN
  (SELECT
     items.biblionumber,
     items.itemnumber,
     items.barcode,
     items.homebranch,
     permanent_location.lib AS PERM_LOCATION,
     location.lib AS LOCATION,
     itypes.description AS ITEM_TYPE,
     collectioncodes.lib AS COLLECTION_CODE,
     items.itemcallnumber,
     biblio.author,
     Concat_Ws(" ", 
       biblio.title, 
       ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
       ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
       ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
       ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
     ) AS FULL_TITLE,
     Concat_Ws('-', 
       Year(items.itemlost_on), 
       LPad(Month(items.itemlost_on), 2, 0), 
       LPad(Day(items.itemlost_on), 2, 0)
     ) AS LOST_ON_DATE
   FROM
     items JOIN
     biblio ON items.biblionumber = biblio.biblionumber JOIN
     biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber
     LEFT JOIN
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOC') permanent_location ON
         permanent_location.authorised_value = items.permanent_location
     LEFT JOIN
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'LOC') location ON
         location.authorised_value = items.location LEFT JOIN
     (SELECT
        itemtypes.itemtype,
        itemtypes.description
      FROM
        itemtypes) itypes ON itypes.itemtype = items.itype LEFT JOIN
     (SELECT
        authorised_values.category,
        authorised_values.authorised_value,
        authorised_values.lib
      FROM
        authorised_values
      WHERE
        authorised_values.category = 'CCODE') collectioncodes ON
         collectioncodes.authorised_value = items.ccode
   WHERE
     items.itemlost = 2) item_info ON item_info.itemnumber =
      old_checkouts.itemnumber AND
      item_info.LOST_ON_DATE = old_checkouts.LOST_DATE JOIN
  borrowers ON borrowers.borrowernumber = old_checkouts.borrowernumber
GROUP BY
  old_checkouts.itemnumber
ORDER BY
  item_info.LOST_ON_DATE DESC

























