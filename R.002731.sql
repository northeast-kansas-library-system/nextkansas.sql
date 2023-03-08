/*
R.002731

----------

Name: GHW - Flexible Shelflist Report
Created by: George H Williams

----------

Group: Catalog Records and Items
     Shelf Lists

Created on: 2016-08-11 16:36:03
Modified on: 2022-11-07 14:54:49
Date last run: 2023-03-07 15:52:34

----------

Public: 0
Expiry: 0

----------

<div id="reportinfo" class="noprint">
<p>This report shows all items added to Next Search Catalog at a specific library branch after a specified date - includes date added, date last borrowed, date last seen, and total circulations+renewals</p>
<p>Includes the date the item was added (dateaccessioned), the date the item was last checked out to a patron (datelastborrowed), and the date the item was last scanned on the check-in screen (datelastseen).</p>
<ul><li>Shows items that are currently still in Next</li>
<li>Allows user to specify the item's homebranch, permanent shelving location, item type, collection code, and the item's date added</li>
<li>grouped by homebranch, location, itype, collection code, and call number</li>
<li>sorted by homebranch, location, itype, collection code, and call number</li>
<li>contains links directly to the item's bibliographic record</li>
</ul><br />

<p><ins>Notes:</ins></p>
<p></p>
<p>This report now handles dateaccessioned, datelastborrowed, and datelastseen as follows:</p>
<ul>
  <li>dateaccessioned that are blank or older than 2000 are filtered as if they were added on January 2, 2000</li>
  <li>datelastborrowed that are blank or older than 2000 are filtered as if they were added on January 2, 2000</li>
  <li>datelastseen that are blank or older than 2000 are filtered as if they were added on January 2, 2000</li>
</ul>
<p>These dates will still show the actual dates in the appropriate columns, but you will no longer need to adjust the filters in order to identify dates prior to 2000.  The side-effect of this change is that you will no longer be able filter for dates prior to January 1, 2000.  If you run this report and specify dates before January 3, 2000, you will be able to see these items, but you cannot really specify dates older than January 1, 2000.</p>
<p></p>
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
<p>Added column "CKO_LAST_12M" which shows a count of the number of times an item has checked out in the previous 12 months.</p>

</div>

----------
*/



SELECT 
  Concat( 
    '<a class="btn btn-default noprint" ', 
    'href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">Go to title</a>' 
  ) AS LINK_TO_TITLE, 
  biblio.biblionumber AS BIBLIO_NUMBER, 
  items.itemnumber AS ITEM_NUMBER, 
  Concat('-', items.barcode, '-') AS BARCODE, 
  items.homebranch, 
  items.holdingbranch, 
  perm_locs.lib AS PERMANENT_LOCATION, 
  current_locs.lib AS LOCATION, 
  itemtypes.description AS ITYPE, 
  ccodes.lib AS CCODE, 
  items.itemcallnumber, 
  biblio.author, 
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="h"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="b"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="p"]' 
    ), 
    ExtractValue( 
      biblio_metadata.metadata, 
      '//datafield[@tag="245"]/subfield[@code="n"]' 
    ) 
  ) AS FULL_TITLE, 
  biblioitems.publicationyear, 
  biblioitems.isbn, 
  ExtractValue( 
    biblio_metadata.metadata, 
    '//datafield[@tag="022"]/subfield[@code="a"]' 
  ) AS ISSN, 
  ExtractValue( 
    biblio_metadata.metadata, 
    '//datafield[@tag="024"]/subfield[@code="a"]' 
  ) AS UPC, 
  items.dateaccessioned, 
  items.datelastborrowed, 
  items.datelastseen, 
  items.issues, 
  items.renewals, 
  Sum( 
    (Coalesce(items.issues, 0)) 
    + 
    (Coalesce(items.renewals, 0)) 
  ) AS CHECKOUTS_PLUS_RENEWALS, 
  Coalesce(last_twelve.count, 0) AS CKO_LAST_12M, 
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT_NOW, 
  not_loans.lib AS NOT_FOR_LOAN, 
  If( 
    Sum( 
      Coalesce(items.damaged, 0) 
      + 
      Coalesce(items.itemlost, 0) 
      + 
      Coalesce(items.withdrawn, 0) 
    ) = 0, 
    'No', 
    'Yes' 
  ) AS STATUS_PROBLEMS, 
  Concat_Ws('', 
    If( 
      Coalesce(damageds.lib, 0) = '', 
      '', 
      Concat(damageds.lib, ' (', Date_Format(items.damaged_on, "%Y.%m.%d"), ') / ') 
    ), 
    If( 
      Coalesce(losts.lib, 0) = '', 
      '', 
      Concat(losts.lib, ' (', Date_Format(items.itemlost_on, "%Y.%m.%d"), ') / ') 
    ), 
    If( 
      Coalesce(withdrawns.lib, 0) = '', 
      '', 
      Concat(withdrawns.lib, ' (', Date_Format(items.withdrawn_on, "%Y.%m.%d"), ')') 
    ) 
  ) AS STATUSSES, 
  items.itemnotes, 
  items.itemnotes_nonpublic, 
  items.copynumber, 
  items.replacementprice, 
  localcounts.Count_itemnumber AS LOCAL_COPIES, 
  systemcounts.Count_itemnumber AS SYSTEM_COPIES, 
  Concat( 
    '<a class="btn btn-default noprint" ', 
    'href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>' 
  ) AS EDIT_ITEM 
FROM 
  biblio JOIN 
  biblio_metadata 
  ON biblio_metadata.biblionumber = biblio.biblionumber JOIN 
  items 
  ON items.biblionumber = biblio.biblionumber LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC') perm_locs 
  ON perm_locs.authorised_value = items.permanent_location LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC') current_locs 
  ON current_locs.authorised_value = items.location LEFT JOIN 
  itemtypes 
  ON itemtypes.itemtype = items.itype LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'CCODE') ccodes 
  ON ccodes.authorised_value = items.ccode JOIN 
  biblioitems 
  ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'NOT_LOAN') not_loans 
  ON not_loans.authorised_value = items.notforloan LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'damaged') damageds 
  ON damageds.authorised_value = items.damaged LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'lost') losts 
  ON losts.authorised_value = items.itemlost LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'withdrawn') withdrawns 
  ON withdrawns.authorised_value = items.withdrawn LEFT JOIN 
  (SELECT 
      items.biblionumber, 
      items.homebranch, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    WHERE 
      items.homebranch LIKE <<Item home library|ZBRAN>> 
    GROUP BY 
      items.biblionumber, 
      items.homebranch) localcounts 
    ON localcounts.biblionumber = items.biblionumber 
      AND 
      localcounts.homebranch = items.homebranch LEFT JOIN 
  (SELECT 
      items.biblionumber, 
      Count(items.itemnumber) AS Count_itemnumber 
    FROM 
      items 
    GROUP BY 
      items.biblionumber) systemcounts 
  ON systemcounts.biblionumber = items.biblionumber LEFT JOIN 
  (SELECT 
      statistics.itemnumber, 
      Count(*) AS count 
    FROM 
      statistics 
    WHERE 
      statistics.datetime < CurDate() - INTERVAL 1 YEAR AND 
      (statistics.type = 'issue' OR 
        statistics.type = 'renew') 
    GROUP BY 
      statistics.itemnumber) last_twelve 
  ON last_twelve.itemnumber = items.itemnumber 
WHERE 
  items.homebranch LIKE <<Item home library|ZBRAN>> AND 
  Coalesce(items.permanent_location, "-") LIKE <<Item permanent shelving location|LLOC>> AND 
  Coalesce(items.itype, "PUNC") LIKE <<Item type|LITYPES>> AND 
  Coalesce(items.ccode, "XXX") LIKE <<Item collection code|LCCODE>> AND 
  Coalesce(items.itemcallnumber, "-") LIKE Concat(<<Enter first part of call number or a % symbol>>, "%") AND 
  Coalesce(not_loans.lib_opac, "-") LIKE <<Not for loan status|LNOT_LOAN>> AND 
  (If( 
    Coalesce(Year(Coalesce(items.dateaccessioned)), '1999') < '2000', 
    '2000-01-02', 
    items.dateaccessioned 
  ) BETWEEN <<Item added between date1|date>> AND <<and-date2|date>>) AND 
  If(items.onloan IS NULL, 'No', 'Yes') LIKE '%' AND 
  (If( 
    Coalesce(Year(Coalesce(items.datelastborrowed)), '1999') < '2000', 
    '2000-01-02', 
    items.datelastborrowed 
  ) BETWEEN <<Item last borrowed between date1|date>> AND <<and--date2|date>>) AND 
  (If( 
    Coalesce(Year(Coalesce(items.datelastseen)), '1999') < '2000', 
    '2000-01-02', 
    items.datelastseen 
  ) BETWEEN <<Item last seen between date1|date>> AND <<and---date2|date>>) AND 
  localcounts.Count_itemnumber >= 0 AND 
  systemcounts.Count_itemnumber >= 0 
GROUP BY 
  biblio.biblionumber, 
  items.itemnumber 
HAVING 
  CHECKOUTS_PLUS_RENEWALS <= <<With X or fewer checkouts|ZNUMBERS>> AND 
  CHECKED_OUT_NOW LIKE <<Display checked out items|ZYES_NO>> AND 
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
  FULL_TITLE

























