/*
R.003672

----------

Name: GHW - Items till in transit shipped during a date range
Created by: George Williams

----------

Group: -
     -

Created on: 2022-10-24 17:38:06
Modified on: 2024-01-17 11:29:34
Date last run: 2024-03-19 11:03:25

----------

Public: 0
Expiry: 300

----------

<div class="reportinfo noprint"> 
  <p>Displays a list of items shipped during a specific date range that are still "in transit."</p>
  <ul>
    <li>Shows items that are still in transit during the date range you specify</li>
    <li>at all Next libraries</li>
    <li>grouped by biblio and item number</li>
    <li>sorted in the standard Next Search Catalog classification order</li>
    <li>links to the bibliographic record and a mailto link to contact all libraries involved in the transfer</li>
  </ul><br />
  <p><ins>Notes:</ins></p>
  <p></p>
  <p>Designed to help libraries track items that are missing in transit.</p>
  <p></p>
  <p class= "notetags" style="display: none;">#transfers #missing_in_transit #courier</p>
  <!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes -->
</div>

----------
*/



SELECT
  Concat(
    'BIBLIO'
  ) AS 'LINK',
  item_info.HOME_LIBRARY,
  item_info.branchname AS CURRENTLY_AT,
  item_info.LOCATION,
  item_info.ITYPE,
  item_info.CCODE,
  item_info.CALL_NUMBER,
  item_info.author,
  item_info.TITLE,
  item_info.datelastseen,
  item_info.barcode1,
  item_info.homebranch AS OWNED_BY,
  frombranches.branchname AS SENT_FROM,
  branchtransfers.datesent AS SENT_DATE,
  tobranches.branchname AS SENT_TO,
  branchtransfers.reason AS TRANSFER_REASON,
  Concat_Ws('', 
    'Send e-mail'
  ) AS MAILTO_LINK
FROM
  branchtransfers JOIN
  branches frombranches ON branchtransfers.frombranch = frombranches.branchcode JOIN
  branches tobranches ON branchtransfers.tobranch = tobranches.branchcode JOIN
  (
    SELECT
      items.biblionumber,
      items.itemnumber,
      items.barcode,
      home.branchname AS HOME_LIBRARY,
      holding.branchname,
      perm_locs.lib AS PERM_LOCATION,
      Concat_Ws('', perm_locs.lib, If(locs.lib = 'Recently returned',
      ' (Recently returned)', '')) AS LOCATION,
      itemtypes.description AS ITYPE,
      ccodes.lib AS CCODE,
      items.itemcallnumber,
      Concat_Ws('', items.itemcallnumber, If(items.copynumber IS NULL,
      '', Concat(' (Copy number: ', items.copynumber, ')'))) AS CALL_NUMBER,
      biblio.author,
      Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle,
      biblioitems.number, biblio.part_name) AS TITLE,
      items.datelastseen,
      items.copynumber,
      Concat('-', items.barcode, '-') AS barcode1,
      items.homebranch,
      home.branchemail
    FROM
      items JOIN
      biblio ON items.biblionumber = biblio.biblionumber JOIN
      biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
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
        ) perm_locs ON perm_locs.authorised_value = items.permanent_location LEFT JOIN
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
        ) locs ON locs.authorised_value = items.location LEFT JOIN
      itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
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
      ) ccodes ON ccodes.authorised_value = items.ccode LEFT JOIN
      branches home ON home.branchcode = items.homebranch LEFT JOIN
      branches holding ON holding.branchcode = items.holdingbranch
    GROUP BY
      items.biblionumber,
      items.itemnumber
  ) item_info ON item_info.itemnumber = branchtransfers.itemnumber
WHERE
  branchtransfers.datearrived IS NULL AND
  branchtransfers.datecancelled IS NULL AND
  branchtransfers.datesent BETWEEN <> AND (<> + INTERVAL 1 DAY)
GROUP BY
  item_info.biblionumber,
  item_info.itemnumber
ORDER BY
  SENT_DATE,
  item_info.HOME_LIBRARY,
  item_info.PERM_LOCATION,
  item_info.ITYPE,
  item_info.CCODE,
  item_info.itemcallnumber,
  item_info.author,
  item_info.TITLE,
  item_info.barcode1,
  item_info.copynumber

























