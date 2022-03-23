/*
R.002894

----------

Name: GHW - Missing In Transit more than 7 days - List
Created by: George H Williams

----------

Group: Circulation
     Transfers

Created on: 2017-02-01 12:29:04
Modified on: 2021-11-24 16:37:15
Date last run: 2022-03-22 15:31:39

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo>
<p>Generates a list of missing in transit items owned by a library, shipped from a library, or shipped to a library</p>
<ul><li>Shows items that have been in transit for more than 7 days</li>
<li>Shows items owned by, shipped from, or shipped to the library you specify</li>
<li>grouped by item barcode</li>
<li>sorted by standard NExpress classification</li>
<li>contains links to the item's bibliographic record</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Use this list to generate a list of items to search for on the shelves at your library</p>
<p>Use report 2945 to generate an e-mail message to send to other libraries</p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=2894&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
</div>

----------
*/



SELECT
  Concat(
    '<a class="btn btn-default noprint" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=',
    biblio.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS 'LINK_TO_TITLE',
  If(
    items.permanent_location = items.location, 
    perm_locs.lib, 
    Concat(perm_locs.lib, ' (', locs.lib, ')')
  ) AS LOCATION,
  itemtypes.description AS ITEM_TYPE,
  ccodes.lib AS CCODE,
  If(
    items.copynumber IS NULL, 
    items.itemcallnumber, 
    Concat(items.itemcallnumber, ' (Copy number: ', items.copynumber, ')')
  ) AS CALL_NUMBER,
  biblio.author,
  biblio.title,
  Concat("-", items.barcode, "-") AS BC,
  items.homebranch AS OWNED_BY,
  branchtransfers.frombranch AS SENT_FROM,
  branchtransfers.datesent AS SHIPPED_DATE,
  branchtransfers.tobranch AS SENT_TO,
  items.datelastseen,
  @SortOrder := <<Sort by|XS_BRANCH>> AS SORTING
FROM
  (items JOIN
  branchtransfers ON items.itemnumber = branchtransfers.itemnumber) JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype
WHERE
  items.datelastseen <= Now() - INTERVAL 7 DAY AND
  branchtransfers.datearrived IS NULL AND
  ((items.homebranch LIKE <<Choose your library|LBRANCH>>) OR
    (branchtransfers.frombranch LIKE <<Choose your library|LBRANCH>>) OR
    (branchtransfers.tobranch LIKE <<Choose your library|LBRANCH>>))
GROUP BY
  items.location,
  items.permanent_location,
  items.itemnumber
ORDER BY
  CASE WHEN SORTING = '1' THEN items.homebranch END ASC,
  CASE WHEN SORTING = '2' THEN perm_locs.lib END ASC,
  perm_locs.lib,
  ITEM_TYPE,
  CCODE,
  CALL_NUMBER,
  biblio.author,
  biblio.title,
  items.barcode

























