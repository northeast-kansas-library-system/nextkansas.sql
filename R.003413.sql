/*
R.003413

----------

Name: GHW - SENECA Lost item processing fee report
Created by: George H Williams

----------

Group: Library-Specific
     Seneca

Created on: 2021-01-26 17:01:42
Modified on: 2021-01-28 14:42:33
Date last run: 2021-03-31 18:01:11

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Identifies borrowers who need to be assessed a $20.00 lost item processing fee at SENECA</p>
<ul><li>Shows borrowers who borrowed items from SENECA and the item was marked as "Lost (more than 45 days overdue)" within the last XX days</li>
<li>Shows items checked out at SENECA regardless of the item's home library</li>
<li>grouped by the issue_id of the checkout</li>
<li>sorted by the date the item was lost</li>
<li>contains links to the item and links to the borrower</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Notes go here.</p>
<p></p>
<p>Should not be exported to a csv file.  This is customized to be run from the screen.</p>
<p class= "notetags" style="display: none;">#seneca, processing fee, </p>
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
  item_info.LOST_ON_DATE,
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
  Concat_Ws(' &lt;br &#47;&gt;&lt;br &#47;&gt; ', 
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
    Concat('Lost on: ', item_info.LOST_ON_DATE, '&lt;br &#47;&gt;&lt;br &#47;&gt;')
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
WHERE
  item_info.LOST_ON_DATE > (Now() - INTERVAL <<Only display items lost in the previous XX days|YNUMBER>> DAY)
GROUP BY
  old_checkouts.itemnumber
ORDER BY
  item_info.LOST_ON_DATE DESC



