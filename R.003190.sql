/*
R.003190

----------

Name: GHW - Deletion problem
Created by: George Williams

----------

Group: -
     -

Created on: 2019-03-29 10:28:46
Modified on: 2019-03-29 11:45:17
Date last run: 2019-04-03 21:07:04

----------

Public: 0
Expiry: 300

----------

First draft.

----------
*/



SELECT
  Concat(
    "nexthelp@nekls.orgItem deleted at your library that was not owned by your library",
    ",We have some libraries noticing lately that their items are being deleted without their knowledge, so I'm trying to track what's going on.  It doesn't appear to happen often - about 5-10 items a month - but it's upsetting some libraries.So, on ",
    Date_Format(action_logs.timestamp, "%Y.%m.%d"),
    " at ",
    Date_Format(action_logs.timestamp, "%l:%i %p"),
    " staff at ",
    borrowers.branchcode,
    " (logged in as ",
    borrowers.userid,
    ") deleted an item owned by ",
    deleteditems.homebranch,
    ".Specifically, ",
    borrowers.userid,
    " deleted the following item:Item homebranch: ",
    Coalesce(deleteditems.homebranch, " "),
    "Shelving location: ",
    Coalesce(deleteditems.location, " "),
    "Item type: ",
    Coalesce(deleteditems.itype, " "),
    "Collection code: ",
    Coalesce(CCODES.lib, " "),
    "Call number: ",
    Coalesce(deleteditems.itemcallnumber, " "),
    "Author: ",
    Coalesce(biblio.author, deletedbiblio.author, " "),
    "Title: ",
    Coalesce(biblio.title, deletedbiblio.title, " "),
    "Barcode number: ",
    Coalesce(deleteditems.barcode, " "),
    If(Coalesce(LOST.lib, "-") LIKE "-", "", Concat("Lost status at time of deletion: ", Coalesce(LOST.lib, "-"))),
    If(Coalesce(WITHDRAWN.lib, "") LIKE "", "", Concat("Withdrawn status at time of deletion: ", Coalesce(WITHDRAWN.lib, ""))),
    IF(Coalesce(DAMAGED.lib, "") LIKE "", "", CONCAT("Damaged status at time of deletion: ", Coalesce(DAMAGED.lib, ""))),
    "Do you have any idea why you might have deleted this item that was not owned by your library?  Did you contact ",
    deleteditems.homebranch,
    " before you deleted the item?Please let us know,George"
  ) AS INFO
FROM
  action_logs
  LEFT JOIN borrowers
    ON borrowers.borrowernumber = action_logs.user
  LEFT JOIN deleteditems
    ON deleteditems.itemnumber = action_logs.object
  LEFT JOIN biblio
    ON biblio.biblionumber = deleteditems.biblionumber
  LEFT JOIN deletedbiblio
    ON deletedbiblio.biblionumber = deleteditems.biblionumber
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE'
  ) CCODES
    ON CCODES.authorised_value = deleteditems.ccode
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST'
  ) LOST
    ON LOST.authorised_value = deleteditems.itemlost
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'WITHDRAWN'
  ) WITHDRAWN
    ON WITHDRAWN.authorised_value = deleteditems.withdrawn
  LEFT JOIN (
    SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'DAMAGE'
  ) DAMAGED
    ON DAMAGED.authorised_value = deleteditems.damaged
WHERE
  action_logs.module = 'CATALOGUING' AND
  action_logs.action LIKE 'DEL%' AND
  action_logs.info = 'item' AND
  If(borrowers.branchcode LIKE "DONI%", "DONI", If(borrowers.branchcode LIKE "PH%", "PH", borrowers.branchcode))
    <>
  If(borrowers.branchcode LIKE "DONI%", "DONI", If(deleteditems.homebranch LIKE "PH%", "PH", deleteditems.homebranch)) AND
  deleteditems.homebranch <> 'digital'
GROUP BY
  action_logs.action_id,
  deleteditems.itemnumber,
  biblio.biblionumber

























