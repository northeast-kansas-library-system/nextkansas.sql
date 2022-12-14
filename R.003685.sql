/*
R.003685

----------

Name: quickfix
Created by: George H Williams

----------

Group: -
     -

Created on: 2022-12-05 14:22:01
Modified on: 2022-12-05 14:22:01
Date last run: 2022-12-05 14:22:17

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  biblio.biblionumber,
  biblioitems.agerestriction,
  bib_locations.PERM,
  bib_locations.Count_itemnumber
FROM
  biblio JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber JOIN
  (SELECT
      items.biblionumber,
      GROUP_CONCAT(
        DISTINCT If(items.permanent_location LIKE '%AD%', 'L_AD', If(items.permanent_location LIKE '%JU%', 'L_JU', If(items.permanent_location LIKE '%YA%', 'L_YA', items.permanent_location))) ORDER BY If(items.permanent_location LIKE '%AD%', 'L_AD', If(items.permanent_location LIKE '%JU%', 'L_JU', If(items.permanent_location LIKE '%YA%', 'L_YA', items.permanent_location)))
      ) AS PERM,
      Count(DISTINCT items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber
    ORDER BY
      PERM) bib_locations ON bib_locations.biblionumber = biblio.biblionumber
WHERE
  biblioitems.agerestriction NOT LIKE 'L_AD' AND
  bib_locations.PERM LIKE 'L_AD' AND
  bib_locations.Count_itemnumber = 1
GROUP BY
  biblio.biblionumber,
  biblioitems.agerestriction,
  bib_locations.PERM,
  bib_locations.Count_itemnumber

























