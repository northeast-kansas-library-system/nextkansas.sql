/*
R.003624

----------

Name: GHW - Fish Heads
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-11-22 17:50:31
Modified on: 2021-11-29 10:09:50
Date last run: 2022-12-14 11:51:29

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  return_claims.id,
  issues.branchcode AS CHECKOUT_BRANCH,
  items.barcode,
  Concat_Ws('<br />', 
    items.homebranch, 
    locs.lib, 
    itemtypes.description,
    ccodes.lib, 
    Concat_Ws(' ', items.itemcallnumber, items.copynumber),
    biblio.author, 
    Concat_Ws(' ', biblio.title, biblio.medium, biblio.subtitle, biblioitems.number, biblio.part_name)
  ) AS ITEM_INFO,
  items.onloan,
  borrowers.cardnumber AS CLAIMS_RETURNED_BY,
  return_claims.notes,
  Concat_Ws(' ', staff.firstname, staff.surname) AS MARKED_CR_BY,
  return_claims.created_on,
  If(return_claims.borrowernumber <> currentissues.borrowernumber,
  'Item is checked out to a different borrower', '') AS CKO_TO_OTHER,
  If(return_claims.resolved_on IS NULL, 'Unresolved', Concat('Resolved on ',
  return_claims.resolved_on)) AS resolved_on,
  If(return_claims.resolved_on IS NULL, "No", "Yes")
FROM
  return_claims LEFT JOIN
  items ON return_claims.itemnumber = items.itemnumber INNER JOIN
  biblio ON items.biblionumber = biblio.biblionumber INNER JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.permanent_location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
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
  issues ON return_claims.issue_id = issues.issue_id LEFT JOIN
  borrowers ON return_claims.borrowernumber = borrowers.borrowernumber LEFT JOIN
  borrowers staff ON staff.borrowernumber = return_claims.created_by LEFT JOIN
  issues currentissues ON currentissues.itemnumber = items.itemnumber
GROUP BY
  return_claims.id,
  return_claims.notes,
  return_claims.issue_id,
  return_claims.resolved_on,
  If(return_claims.resolved_on IS NULL, 'Unresolved', 'Resolved')
ORDER BY
  return_claims.id DESC

























