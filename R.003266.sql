/*
R.003266

----------

Name: Spencer report #1
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-20 10:55:38
Modified on: 2019-09-20 10:55:43
Date last run: -

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
b.title,
ExtractValue(bi.marcxml, '//datafield[@tag="245"]/subfield[@code="b"]') AS "Subtitle",
ExtractValue(bi.marcxml, '//datafield[@tag="546"]/subfield[@code="a"]') AS "Language Note",
ExtractValue (marcxml,'//datafield[@tag="700"]/subfield[@code="a"]') AS "Name",
ExtractValue (marcxml,'//datafield[@tag="100"]/subfield[@code="a"]') AS "Author",
ExtractValue (marcxml,'//datafield[@tag="651"]/subfield[@code="a"]') AS "Geographic Term",
ExtractValue (marcxml,'//datafield[@tag="655" AND @ind2="7"]/subfield[@code="a"]') AS "Genre",
ExtractValue (marcxml,'//datafield[@tag="650"]/subfield[@code="a"]') AS "Topic",
i.itemcallnumber AS 'Callnumber', b. title, i.barcode, i.ccode,
i.itype AS 'Item Type', i.issues, i.renewals, (IFNULL(i.issues, 0)+IFNULL(i.renewals, 0)) AS
Total_Circ, COUNT(CASE WHEN s.type='issue' THEN 0 END) AS 'Checkouts in Time Period', COUNT(CASE
WHEN s.type='renew' THEN 0 END) AS 'Renewals in Time Period', i.datelastborrowed, i.itemlost,
i.damaged, i.dateaccessioned
FROM biblio b
LEFT JOIN items i USING ( biblionumber )
LEFT JOIN biblioitems bi USING ( biblionumber )
LEFT JOIN statistics s USING (itemnumber)
WHERE i.itype=<<Item type|itemtypes>>
AND i.ccode= <<Collection Code|ccode>>
AND s.datetime BETWEEN <<Between (yyyy-mm-dd)|date>> AND <<and (yyyy-mm-dd)|date>>
AND (ExtractValue (marcxml,'//datafield[@tag="651"]/subfield[@code="a"]') LIKE CONCAT('%',
<<Geographic TERM>>, '%')
AND ExtractValue (marcxml,'//datafield[@tag="546"]/subfield[@code="a"]') LIKE CONCAT('%',
<<Language Note>>, '%')
AND ExtractValue (marcxml,'//datafield[@tag="100"]/subfield[@code="a"]') LIKE CONCAT('%',
<<AUTHOR>>, '%')
AND ExtractValue (marcxml,'//datafield[@tag="655" AND @ind2="7"]/subfield[@code="a"]') LIKE
CONCAT('%', <<655 Genre TERM>>, '%')
AND ExtractValue (marcxml,'//datafield[@tag="700"]/subfield[@code="a"]') LIKE CONCAT('%', <<700
Participant NAME>>, '%')
AND ExtractValue (marcxml,'//datafield[@tag="650"]/subfield[@code="a"]') LIKE CONCAT('%', <<Topic
TERM>>, '%'))
GROUP BY i.barcode
ORDER BY b.title



