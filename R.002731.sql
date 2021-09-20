/*
R.002731

----------

Name: GHW - Flexible Shelflist Report
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-08-11 16:36:03
Modified on: 2021-09-08 10:53:17
Date last run: 2021-09-17 14:17:21

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>This report shows all items added to Next Search Catalog at a specific library branch after a specified date - includes date added, date last borrowed, date last seen, and total circulations+renewals</p>
<p>Includes the date the item was added (dateaccessioned), the date the item was last checked out to a patron (datelastborrowed), and the date the item was last scanned on the check-in screen (datelastseen).</p>
<ul><li>Shows items that are currently still in Next</li>
<li>Allows user to specify the item's homebranch, shelving location, item type, collection code, and the item's date added</li>
<li>grouped by homebranch, location, itype, collection code, and call number</li>
<li>sorted by homebranch, location, itype, collection code, and call number</li>
<li>contains links directly to the item's bibliographic record</li>
</ul><br />

<p><ins>Notes:</ins></p>
<p></p>
<p>Please note the dates in the default - especially "Item added between date1:" +  "and date2:"  These dates default to 1/1/2000 and today's date.  If you have an item that has a "Date acquired" date prior to 1/1/2000, it will not appear on this report.  as of the writing of this note (2020.12.17) there are approximately 21,000 items at 43 libraries that have "Date acquired" dates prior to 1/1/2000.
</p>
<p></p>
<p>publicationyear data comes from the 264$c subfield.  If the data in 264$c is not a 4 digit year, the data will be problematic.  If 264$c is blank, the result in this report will be blank.</p>
<p></p>
<p>Report updated on 2021.09.08 to include ISBN and ISSN fields.</p>
<p></p>
<p>Formerly called "Flexible Weeding Report"</p>
<p>Replaces reports:
<ul>
  <li>664 (Full Shelf List)</li>
  <li>2686 (Collection Code Super Weeder)</li>
  <li>1013 (Item Type Super Weeder)</li>
  <li>1442 (Super Weeder by Callnumber)</li>
  <li>2471 (BCPL.SuperWeeder.by.Callnumber)</li>
  <li>1017 (Items with NO checkouts (all items))</li>
  <li>1151 (Date last borrowed, Call number and Title limited by Item type)</li>
  <li>1426 (Last seen on a specific date or earlier)</li>
  <li>1807 (Items with NO checkouts -- limited by CCode)</li>
  <li>2202 (Items with NO checkouts (limited to a collection code and location))</li>
  <li>2203 (Items with NO checkouts (limited to a collection code))</li>
  <li>2241 (Last Seen Date, limited by Collection Code)</li>
  <li>2392 (Date last borrowed, Call number and Title limited by Ccode and Location)</li>
  <li>2411 (Date last borrowed)</li>
  <li>1408 (Shelf List of Specific Item Type)</li>
  <li>1409 (Shelf List of Specific CCode and Location)</li>
  <li>1410 (Shelf List of Specific Item Type and Location)</li>
  <li>3014 (GHW - Shelflist with left anchored call number limit)</li>
  <li>2809 (GHW - List of items with display locations)</li>
  <li>886 Videogames Circ List</li>
</ul>
<p></p>
<p>Added public and non-public notes fields on 2016.12.28</p>
<p>Added item count fields on 2018.10.03</p>

</div>

----------
*/

SELECT
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">', 
    items.biblionumber, 
    '</a>'
  ) AS LINK_TO_TITLE,
  items.biblionumber,
  items.itemnumber AS ITEM_NUMBER,
  Concat("-", Coalesce(items.barcode, "-"), "-") AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  Coalesce(permlocs.lib, "-") AS PERMANENT_LOCATION,
  Coalesce(locs.lib, "-") AS LOCATION,
  Coalesce(itypes.description, "-") AS ITYPE,
  Coalesce(ccodes.lib, "-") AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  biblioitems.isbn,
  biblioitems.issn,
  Coalesce(biblioitems.publicationyear, "0") AS publicationyear,
  items.dateaccessioned,
  Coalesce(items.datelastborrowed, 0) AS datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))) AS
  CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT,
  If(
    Sum(Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) + Coalesce(items.withdrawn, 0)) = 0, 
    'No', 
    'Yes'
  ) AS STATUS_PROBLEMS,
  Coalesce(notloan.lib, "-") AS NOT_FOR_LOAN,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.copynumber,
  items.replacementprice,
  localcounts.Count_itemnumber AS LOCAL_COPIES,
  systemcounts.Count_itemnumber AS SYSTEM_COPIES,
  Concat(
    '<a class= "clicked" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber JOIN
  biblio_metadata ON items.biblionumber = biblio_metadata.biblionumber JOIN
  biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber JOIN
  (SELECT
      items.biblionumber,
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber,
      items.homebranch) localcounts ON items.biblionumber =
      localcounts.biblionumber AND
      items.homebranch = localcounts.homebranch JOIN
  (SELECT
      items.biblionumber,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber) systemcounts ON items.biblionumber =
      systemcounts.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN'
    GROUP BY
      authorised_values.category,
      authorised_values.authorised_value) notloan ON notloan.authorised_value =
      items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
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
      authorised_values.category = 'LOC') permlocs ON
      permlocs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location
WHERE items.homebranch LIKE <<Item home library|ZBRAN>> AND
  Coalesce(items.permanent_location, "-") LIKE <<Item permanent shelving location|LLOC>> AND
  Coalesce(items.itype, "PUNC") LIKE <<Item type|LITYPES>> AND
  Coalesce(items.ccode, "XXX") LIKE <<Item collection code|LCCODE>> AND
  Coalesce(items.itemcallnumber, "-") LIKE Concat(<<Enter first part of call number or a % symbol>>, "%") AND
  Coalesce(notloan.lib, "-") LIKE <<Not for loan status|LNOT_LOAN>> AND
  Coalesce(items.dateaccessioned, CurDate()) >= <<Item added between date1|date>> AND
  Coalesce(items.dateaccessioned, "0") <= <<and date2|date>> AND 
  Coalesce(items.datelastborrowed, CurDate()) >= <<Item last borrowed between date1|date>> AND
  Coalesce(items.datelastborrowed, "0") <= <<and  date2|date>> AND 
  Coalesce(items.datelastseen, CurDate()) >= <<Item last seen between date1|date>> AND
  Coalesce(items.datelastseen, "0") <= <<and date2|date>>
GROUP BY
  biblio.biblionumber,
  items.itemnumber
HAVING
  CHECKOUTS_PLUS_RENEWALS <= <<With X or fewer checkouts|ZNUMBERS>> AND
  CHECKED_OUT LIKE <<Display checked out items|ZYES_NO>> AND
  STATUS_PROBLEMS LIKE <<Display lost, missing, and withdrawn items|ZYES_NO>> AND
  LOCAL_COPIES >= <<With X or more copies at this library|YNUMBER>> AND
  SYSTEM_COPIES >= <<With X or more copies at throughout the catalog|YNUMBER>>
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE,
  biblio.title



