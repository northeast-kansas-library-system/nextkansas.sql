/*
R.003006

----------

Name: GHW - Prioritized Holds Queue
Created by: George Williams

----------

Group: -
     -

Created on: 2017-10-12 12:11:36
Modified on: 2017-12-19 09:38:38
Date last run: 2021-07-03 11:09:19

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat_Ws('',
    hold_fill_targets.source_branchcode,
    items.homebranch,
    (Concat('Go to biblio')),
    If(localonly.Count_itemnumber &gt; 0, "TOP PRIORITYONLY COPY AVAILABLE",
    If(availablecount.Count_itemnumber &lt; 3, "PriorityAll other copies checked out", "-"))) AS CURRENT_OWNING,
  Concat_Ws('', items.location, authorised_values.lib, items.itemcallnumber) AS CALL_NUMBER,
  Concat_Ws('',
    biblio.author,
    (Concat_Ws('',
      biblio.title,
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),
      ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))) AS AUTHOR_TITLE,
  Concat_Ws('', (Concat('')),
    items.barcode) AS BARCODE
FROM
  biblio
  LEFT JOIN ((hold_fill_targets
  LEFT JOIN items ON hold_fill_targets.itemnumber = items.itemnumber)
  LEFT JOIN biblioitems ON items.biblioitemnumber = biblioitems.biblioitemnumber) ON biblio.biblionumber =
    biblioitems.biblionumber
  LEFT JOIN authorised_values ON items.ccode = authorised_values.authorised_value
  INNER JOIN (SELECT
        hold_fill_targets.biblionumber,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber
      FROM
        hold_fill_targets
        JOIN items ON hold_fill_targets.biblionumber = items.biblionumber
      WHERE
        items.onloan IS NULL AND
        (items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL)
      GROUP BY
        hold_fill_targets.biblionumber) availablecount ON hold_fill_targets.biblionumber = availablecount.biblionumber
  LEFT JOIN (SELECT
        hold_fill_targets.biblionumber,
        Count(DISTINCT items.itemnumber) AS Count_itemnumber,
        Group_Concat(DISTINCT items.holdingbranch) AS Group_Concat_holdingbranch
      FROM
        hold_fill_targets
        JOIN items ON hold_fill_targets.biblionumber = items.biblionumber
      WHERE
        ((items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL)) OR
        ((items.notforloan = 0 OR
          items.notforloan IS NULL) AND
        (items.damaged = 0 OR
          items.damaged IS NULL) AND
        (items.itemlost = 0 OR
          items.itemlost IS NULL) AND
        (items.withdrawn = 0 OR
          items.withdrawn IS NULL))
      GROUP BY
        hold_fill_targets.biblionumber
      HAVING
        Count(DISTINCT items.itemnumber) = 1 AND
        Group_Concat(DISTINCT items.holdingbranch) LIKE &lt;&gt;) localonly ON
    hold_fill_targets.biblionumber = localonly.biblionumber
  LEFT JOIN biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber AND items.biblioitemnumber =
    biblio_metadata.biblionumber
WHERE
  authorised_values.category = "ccode" AND
  hold_fill_targets.source_branchcode LIKE &lt;&gt;
GROUP BY
  Concat_Ws('', items.location, authorised_values.lib, items.itemcallnumber), Concat_Ws('', biblio.author, (Concat_Ws('', biblio.title, ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'), ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')))), If(localonly.Count_itemnumber &gt; 0, "TOP PRIORITY", If(availablecount.Count_itemnumber &lt; 3, "Priority", "-")),
  items.holdingbranch,
  biblio.author,
  biblio.title
ORDER BY
  If(localonly.Count_itemnumber &gt; 0, "TOP PRIORITY", If(availablecount.Count_itemnumber &lt; 3, "Priority", "-")) DESC,
  CALL_NUMBER,
  AUTHOR_TITLE

























