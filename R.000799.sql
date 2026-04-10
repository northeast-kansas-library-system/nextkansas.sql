/*
R.000799

----------

Name: Titles of intra consortial ILLs for the Prior Month
Created by:  Tongie Book Club

----------

Group: Acquisitions
     Collection Development

Created on: 2010-01-26 14:52:22
Modified on: 2026-04-10 11:36:07
Date last run: 2026-04-10 11:36:26

----------

Public: 0
Expiry: 0

----------

Enhanced - Pick your Branch, run and get a list of items checked out at your branch that belonged to another library.  Useful for Collection DEVELOPMENT.   

<p><span>Has potential</p>

<p><span>virtually line by line identical to report 684 - merge two to make one report</p>

<p>group/sort/organize by classification order / link to deleteditsms/biblios</p>

----------
*/



SELECT
  checkout_branch.branchname AS CKO_AT,
  owning_branch.branchname AS OWNED_BY,
  permanent_location.lib AS LOC,
  itemtypess.description AS ITYPE,
  ccodes.lib AS CCODE,
  biblio.author,
  biblio.title,
  items.itemcallnumber
FROM
  statistics
  LEFT JOIN items ON statistics.itemnumber = items.itemnumber
  LEFT JOIN biblio ON items.biblionumber = biblio.biblionumber
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) checkout_branch ON checkout_branch.branchcode = statistics.branch
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) owning_branch ON owning_branch.branchcode = items.homebranch
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC'
  ) permanent_location ON permanent_location.authorised_value = items.permanent_location
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) itemtypess ON itemtypess.itemtype = statistics.itemtype
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) ccodes ON ccodes.authorised_value = statistics.ccode
WHERE
  statistics.branch != items.homebranch AND
  statistics.branch = <<Choose checkout library|branches>> AND
  statistics.type IN ('issue', 'renew') AND
  Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND
  Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH)
ORDER BY
  biblio.title

























