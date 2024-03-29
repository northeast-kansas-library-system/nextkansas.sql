/*
R.003190

----------

Name: GHW - Deletion problem
Created by: George H Williams

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
    "nexthelp@nekls.org<br /><br />Item deleted at your library that was not owned by your library<br /><br />",
    ",<br /><br />We have some libraries noticing lately that their items are being deleted without their knowledge, so I'm trying to track what's going on.  It doesn't appear to happen often - about 5-10 items a month - but it's upsetting some libraries.<br /><br />So, on ",
    Date_Format(action_logs.timestamp, "%Y.%m.%d"),
    " at ",
    Date_Format(action_logs.timestamp, "%l:%i %p"),
    " staff at ",
    borrowers.branchcode,
    " (logged in as ",
    borrowers.userid,
    ") deleted an item owned by ",
    deleteditems.homebranch,
    ".<br /><br />Specifically, ",
    borrowers.userid,
    " deleted the following item:<br /><br />Item homebranch: ",
    Coalesce(deleteditems.homebranch, " "),
    "<br />Shelving location: ",
    Coalesce(deleteditems.location, " "),
    "<br />Item type: ",
    Coalesce(deleteditems.itype, " "),
    "<br />Collection code: ",
    Coalesce(CCODES.lib, " "),
    "<br />Call number: ",
    Coalesce(deleteditems.itemcallnumber, " "),
    "<br />Author: ",
    Coalesce(biblio.author, deletedbiblio.author, " "),
    "<br />Title: ",
    Coalesce(biblio.title, deletedbiblio.title, " "),
    "<br />Barcode number: ",
    Coalesce(deleteditems.barcode, " "),
    If(Coalesce(LOST.lib, "-") LIKE "-", "", Concat("<br /><br />Lost status at time of deletion: ", Coalesce(LOST.lib, "-"))),
    If(Coalesce(WITHDRAWN.lib, "") LIKE "", "", Concat("<br /><br />Withdrawn status at time of deletion: ", Coalesce(WITHDRAWN.lib, ""))),
    IF(Coalesce(DAMAGED.lib, "") LIKE "", "", CONCAT("<br /><br />Damaged status at time of deletion: ", Coalesce(DAMAGED.lib, ""))),
    "<br /><br />Do you have any idea why you might have deleted this item that was not owned by your library?  Did you contact ",
    deleteditems.homebranch,
    " before you deleted the item?<br /><br />Please let us know,<br /><br />George"
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

























