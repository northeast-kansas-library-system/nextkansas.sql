/*
R.003328

----------

Name: GHW - School District Email Generator
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-05-15 15:47:47
Modified on: 2020-05-15 20:33:40
Date last run: 2021-08-13 13:11:51

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
  borrowers.cardnumber,
  If(borrowers.email = "", branchess.branchemail, borrowers.email) AS email,
  branchess.branchname,
  If(borrowers.email = "", " // NO EMAIL ADDRESS ON RECORD FOR THIS BORROWER // ", "") AS nomail,
  borrowers.firstname,
  borrowers.surname,
  GROUP_CONCAT(bibliossitemss.item_info SEPARATOR "<br />") AS CKOS,
  Count(issues.issue_id) AS COUNT,
  If(Count(issues.issue_id) = 1, "item", "items") AS ITEMSSS,
  branchess.branchemail
FROM
  (SELECT
      branches.branchcode,
      branches.branchname,
      branches.branchemail
    FROM
      branches) branchess JOIN
  borrowers ON branchess.branchcode = borrowers.branchcode JOIN
  issues ON issues.borrowernumber = borrowers.borrowernumber JOIN
  (SELECT
      Concat_Ws(" ", 
        "TITLE:", 
        biblio.title, 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]'), 
        ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), 
        " | AUTHOR:", 
        biblio.author, 
        " | LIBRARY BARCODE NUMBER:", 
        items.barcode
      ) AS item_info,
      items.itemnumber
    FROM
      biblio JOIN
      biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
      items ON items.biblionumber = biblio.biblionumber) bibliossitemss ON bibliossitemss.itemnumber = issues.itemnumber
WHERE
  branchess.branchcode LIKE <<Choose your library|ZPHSD>>
GROUP BY
  borrowers.cardnumber,
  branchess.branchemail,
  borrowers.email



