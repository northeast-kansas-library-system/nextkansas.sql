/*
R.003360

----------

Name: GHW - Borrowers who may owe money on lost items checked out at your library
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-28 17:01:35
Modified on: 2020-10-28 17:10:07
Date last run: 2022-08-24 17:37:03

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Generates a list of borrowers who may owe money on lost items that were checked out at your library</p>
<ul><li>Shows borrowers who may owe money now</li>
<li>on lost items that were checked out at the library you select</li>
<li>grouped by borrowernumber and item number</li>
<li>sorted by borrower name and normal Next classification scheme</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=3360&phase=Run%20this%20report"  target="_blank">Click here to run in a new window</a></p>
<p class= "notetags" style="display: none;">#lost #fees #borrowers</p>
</div>

----------
*/



SELECT
  items.holdingbranch AS CKO_BRANCH,
  borrowers.cardnumber,
  CONCAT(
    If(borrowers.firstname <> '', Concat_Ws(', ', borrowers.surname, borrowers.firstname), borrowers.surname), 
    If(borrowers.othernames = '', '', Concat(', (', borrowers.othernames, ')'))
  ) AS NAME,
  CONCAT_WS(' | ', 
    borrowers.address, 
    borrowers.address2, 
    borrowers.city, 
    borrowers.state, 
    borrowers.zipcode
  ) AS ADDRESS,
  borrowers.phone,
  borrowers.email,
  FORMAT(borroweraccountlines.Sum_amountoutstanding, 2) AS TOTAL_FEES_DUE,
  FORMAT(itemaccountlines.amountoutstanding, 2) AS DUE_THIS_ITEM,
  items.barcode AS ITEM_BARCODE,
  CONCAT_WS(' | ', 
    items.homebranch, 
    locs.lib, 
    itemtypes.description, 
    ccodes.lib, 
    items.itemcallnumber, 
    biblio.author, 
    CONCAT_WS(' ', 
      biblio.title, 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
    )
  ) AS ITEM_INFO,
  losts.lib AS LOST_STATUS,
  items.replacementprice
FROM
  items JOIN
  biblio ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = "CCODE") ccodes ON items.ccode =
      ccodes.authorised_value LEFT JOIN
  (SELECT
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOST') losts ON items.itemlost =
      losts.authorised_value JOIN
  biblio_metadata ON biblio.biblionumber = biblio_metadata.biblionumber
  LEFT JOIN
  items_last_borrower ON items_last_borrower.itemnumber = items.itemnumber
  LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype JOIN
  borrowers ON items_last_borrower.borrowernumber = borrowers.borrowernumber
  JOIN
  (SELECT
      accountlines.borrowernumber,
      Sum(accountlines.amountoutstanding) AS Sum_amountoutstanding,
      accountlines.itemnumber
    FROM
      accountlines
    GROUP BY
      accountlines.borrowernumber
    HAVING
      Sum(accountlines.amountoutstanding) <> 0) borroweraccountlines ON
      borroweraccountlines.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') locs ON locs.authorised_value =
      items.permanent_location LEFT JOIN
  (SELECT
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.amountoutstanding,
      accountlines.debit_type_code,
      accountlines.status
    FROM
      accountlines
    WHERE
      accountlines.amountoutstanding <> 0
    GROUP BY
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.amountoutstanding,
      accountlines.debit_type_code,
      accountlines.status) itemaccountlines ON itemaccountlines.borrowernumber =
      borrowers.borrowernumber AND
      itemaccountlines.itemnumber = items.itemnumber
WHERE
  items.holdingbranch LIKE <<Check-out branch|ZBRAN>>
GROUP BY
  borrowers.borrowernumber,
  items.itemnumber
HAVING
  LOST_STATUS LIKE <<Choose lost status|ZLOST_ONLY>>
ORDER BY
  borrowers.surname DESC,
  borrowers.firstname,
  items.homebranch,
  locs.lib,
  itemtypes.description,
  ccodes.lib,
  items.itemcallnumber,
  biblio.author,
  biblio.title,
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
  ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')

























