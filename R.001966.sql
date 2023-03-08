/*
R.001966

----------

Name: Never Checked Out Or Hasn't Checked Out Since a specific date
Created by: Heather Braum

----------

Group: Catalog Records and Items
     Weeding Criteria

Created on: 2013-07-31 13:02:01
Modified on: 2022-08-09 10:43:46
Date last run: 2023-02-22 12:27:51

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Lists items that (A) have never checked out or that (B) have not been borrowed since before the date you specify</p>
<ul><li>Shows items currently in the collection</li>
<li>owned by the library you specify</li>
<li>grouped by item number</li>
<li>sorted by the standard Next Search Catalog classification scheme</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p class= "notetags" style="display: none;">#weeding #datelastborrowed #dateaccessioned</p>
<!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div> 

----------
*/



SELECT
  items.itemnumber,
  items.barcode AS ITEM_BARCODE,
  home_branches.branchname AS HOME_BRANCH,
  holding_branches.branchname AS HOLDING_BRANCH,
  If(
    perm_loc.lib = loc.lib, 
    perm_loc.lib, 
    Concat(perm_loc.lib, ' (', loc.lib, ')')
  ) AS LOCATION,
  itypes.description AS ITEM_TYPE,
  ccode.lib AS CCODE,
  If(
    items.copynumber IS NULL, 
    items.itemcallnumber, 
    Concat(items.itemcallnumber, ' // Copy number: ', items.copynumber)
  ) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  biblioitems.publicationyear AS COPYRIGHT_DATE,
  items.dateaccessioned AS DATE_ADDED,
  items.datelastborrowed AS DATE_LAST_BORROWED,
  items.datelastseen AS DATE_LAST_SEEN,
  (Coalesce(items.issues, 0) + Coalesce(items.renewals, 0)) AS TOTAL_CKO_RENEW
FROM
  items LEFT JOIN
  biblio ON biblio.biblionumber = items.biblionumber LEFT JOIN
  biblioitems ON biblioitems.biblioitemnumber = items.biblionumber LEFT JOIN
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
    ) home_branches 
  ON home_branches.branchcode = items.homebranch
  LEFT JOIN
  (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
    ) holding_branches 
  ON holding_branches.branchcode = items.holdingbranch 
  LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    ) perm_loc 
    ON perm_loc.authorised_value = items.permanent_location 
    LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
    ) loc 
    ON loc.authorised_value = items.location 
    LEFT JOIN
  (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
    ) itypes 
    ON itypes.itemtype = items.itype 
    LEFT JOIN
  (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
    ) ccode 
    ON ccode.authorised_value = items.ccode
WHERE
  items.homebranch LIKE <<Choose your library|ZBRAN>> AND
  (
    (
      items.dateaccessioned < <<List items with 0 check-outs and renewals added before|date>> AND
      (Coalesce(items.issues, 0) + Coalesce(items.renewals, 0) = 0)
    ) OR
    (items.datelastborrowed < <<Or items last borrowed before|date>>)
  )
GROUP BY
  items.itemnumber
ORDER BY
  HOME_BRANCH,
  LOCATION,
  ITEM_TYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title,
  items.itemnumber

























