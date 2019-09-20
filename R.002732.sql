/*
R.002732

----------

Name: GHW - Local Holds and Walkins
Created by: George H Williams

----------

Group: Holds-Reserves
     -

Created on: 2016-08-12 11:32:33
Modified on: 2016-08-23 16:05:46
Date last run: 2019-09-16 12:39:47

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT
  CONCAT( '<a href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', biblio.biblionumber,'\" target="_blank">', biblio.biblionumber, '</a>' ) AS 'LINK_TO_BIBLIO',
  biblio.biblionumber,
  items.homebranch,
  items.itemcallnumber,
  biblio.title,
  items.itype,
  Count(items.itype) AS Count_itype,
  GROUP_CONCAT(items.barcode SEPARATOR ' / ') AS BC,
  GROUP_CONCAT(items.dateaccessioned SEPARATOR ' / ') AS DATE_ADDED,
  GROUP_CONCAT(items.itemlost SEPARATOR ' / ') AS LOST_STATUS
FROM
  biblio INNER JOIN
  items
    ON biblio.biblionumber = items.biblionumber
WHERE
  biblio.biblionumber IN (SELECT
    items.biblionumber
  FROM
    items
  WHERE
    (items.itype LIKE 'LOCALHOLD1') AND
    (items.homebranch LIKE <<Enter branch name|lbranch>>)) AND
  (items.homebranch LIKE <<Enter branch name again|lbranch>>) AND
  biblio.title NOT LIKE '%ILL%'
GROUP BY
  biblio.biblionumber, biblio.title, items.itype, items.homebranch
ORDER BY
  biblio.title, items.homebranch ASC



