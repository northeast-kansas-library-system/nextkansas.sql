/*
R.002937

----------

Name: GHW Flex 99
Created by: George H Williams

----------

Group: Administrative Reports
     Testing

Created on: 2017-05-01 10:36:27
Modified on: 2017-12-19 09:32:37
Date last run: 2017-09-11 13:41:38

----------

Public: 0
Expiry: 0

----------

<p><span style="background-color: darkred; color: white">Needs metadata conversion post 17.05</p>

----------
*/



SELECT
  items.holdingbranch AS CKO_BRANCH,
  items.barcode AS ITEM_BARCODE,
  items.homebranch AS ITEM_HOME,
  items.location AS LOCATION,
  items.itype AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber AS CALL_NUMBER,
  biblio.author,
  Concat_Ws(' ', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')) AS FULL_TITLE,
  losts.lib AS LOST_STATUS,
  Date_Format(old_issues.returndate, '%m/%d/%Y') AS LOST_ON,
  borrowers.cardnumber AS LAST_PATRON_CARD,
  borrowers.surname AS LAST_PATRON_NAME,
  items.replacementprice
FROM
  items INNER JOIN
  biblio
    ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = "CCODE") ccodes
    ON items.ccode = ccodes.authorised_value LEFT JOIN
  (SELECT
    authorised_values.authorised_value,
    authorised_values.lib
  FROM
    authorised_values
  WHERE
    authorised_values.category = 'LOST') losts
    ON items.itemlost = losts.authorised_value INNER JOIN
  biblio_metadata
    ON biblio.biblionumber = biblio_metadata.biblionumber INNER JOIN
  old_issues
    ON old_issues.itemnumber = items.itemnumber INNER JOIN
  borrowers
    ON old_issues.borrowernumber = borrowers.borrowernumber
WHERE
  Date_Format(old_issues.returndate, '%m/%d/%Y') =
  Date_Format(items.itemlost_on, '%m/%d/%Y') AND
  items.holdingbranch LIKE <<Check-out branch|ZBRAN>>
GROUP BY
  items.barcode, Date_Format(old_issues.returndate, '%m/%d/%Y'),
  borrowers.cardnumber, borrowers.surname
HAVING
 LOST_STATUS LIKE <<Choose check-out library|ZLOST>>
ORDER BY
  CKO_BRANCH,
  LOCATION,
  ITYPE,
  CCODE,
  CALL_NUMBER,
  FULL_TITLE,
  biblio.author,
  old_issues.borrowernumber,
  LAST_PATRON_CARD,
  LAST_PATRON_NAME

























