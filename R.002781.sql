/*
R.002781

----------

Name: Sandbox 2731 fixing
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-28 11:45:44
Modified on: 2021-11-16 16:45:54
Date last run: 2021-11-16 16:49:20

----------

Public: 0
Expiry: 0

----------



----------
*/



SELECT
  Concat(
    '<a class="btn btn-default" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    items.biblionumber, 
    '\" target="_blank">Go to title</a>'
  ) AS LINK_TO_TITLE,
  biblio.biblionumber AS BIBLIO_NUMBER,
  items.itemnumber AS ITEM_NUMBER,
  Concat('-', items.barcode, '-') AS BARCODE,
  items.homebranch,
  items.holdingbranch,
  perm_locs.lib AS PERMANENT_LOCATION,
  current_locs.lib AS LOCATION,
  itemtypes.description AS ITYPE,
  ccodes.lib AS CCODE,
  items.itemcallnumber,
  biblio.author,
  Concat_Ws(" ", 
    biblio.title, 
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="h"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="b"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="p"]'),  
    ExtractValue(biblio_metadata.metadata, '//datafield[@tag="245"]/subfield[@code="n"]')
  ) AS FULL_TITLE,
  biblioitems.publicationyear,
  items.dateaccessioned,
  items.datelastborrowed,
  items.datelastseen,
  items.issues,
  items.renewals,
  Sum((Coalesce(items.issues, 0)) + (Coalesce(items.renewals, 0))) AS
  CHECKOUTS_PLUS_RENEWALS,
  If(items.onloan IS NULL, 'No', 'Yes') AS CHECKED_OUT_NOW,
  not_loans.lib AS NOT_FOR_LOAN,
  If(Sum(Coalesce(items.damaged, 0) + Coalesce(items.itemlost, 0) +
  Coalesce(items.withdrawn, 0)) = 0, 'No', 'Yes') AS STATUS_PROBLEMS,
  Concat_Ws('', 
    If(Coalesce(damageds.lib, 0) = '', '', Concat(damageds.lib, ' (', Date_Format(items.damaged_on, "%Y.%m.%d"), ') / ')), 
    If(Coalesce(losts.lib, 0) = '', '', Concat(losts.lib, ' (', Date_Format(items.itemlost_on, "%Y.%m.%d"), ') / ')), 
    If(Coalesce(withdrawns.lib, 0) = '', '', Concat(withdrawns.lib, ' (', Date_Format(items.withdrawn_on, "%Y.%m.%d"), ')'))
  ) AS STATUSSES,
  items.itemnotes,
  items.itemnotes_nonpublic,
  items.copynumber,
  items.replacementprice,
  localcounts.Count_itemnumber AS LOCAL_COPIES,
  systemcounts.Count_itemnumber AS SYSTEM_COPIES,
  Concat(
    '<a class="btn btn-default" href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=', 
    items.biblionumber, 
    '&itemnumber=', 
    items.itemnumber, 
    '#edititem\" target="_blank">Edit item</a>'
  ) AS EDIT_ITEM
FROM
  biblio JOIN
  biblio_metadata ON biblio_metadata.biblionumber = biblio.biblionumber JOIN
  items ON items.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') perm_locs ON
      perm_locs.authorised_value = items.permanent_location LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'LOC') current_locs ON
      current_locs.authorised_value = items.location LEFT JOIN
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'CCODE') ccodes ON ccodes.authorised_value =
      items.ccode JOIN
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'NOT_LOAN') not_loans ON
      not_loans.authorised_value = items.notforloan LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'damaged') damageds ON
      damageds.authorised_value = items.damaged LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'lost') losts ON losts.authorised_value =
      items.itemlost LEFT JOIN
  (SELECT
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    FROM
      authorised_values
    WHERE
      authorised_values.category = 'withdrawn') withdrawns ON
      withdrawns.authorised_value = items.withdrawn LEFT JOIN
  (SELECT
      items.biblionumber,
      items.homebranch,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    WHERE
      items.homebranch LIKE <<Choose your library|ZBRAN>>
    GROUP BY
      items.biblionumber,
      items.homebranch) localcounts ON localcounts.biblionumber =
      items.biblionumber AND
      localcounts.homebranch = items.homebranch LEFT JOIN
  (SELECT
      items.biblionumber,
      Count(items.itemnumber) AS Count_itemnumber
    FROM
      items
    GROUP BY
      items.biblionumber) systemcounts ON systemcounts.biblionumber =
      items.biblionumber
WHERE
  items.homebranch LIKE <<Choose your library|ZBRAN>> AND
  Coalesce(items.permanent_location, "-") LIKE <<Item permanent shelving location|LLOC>> AND
  Coalesce(items.itype, "PUNC") LIKE <<Item type|LITYPES>> AND
  Coalesce(items.ccode, "XXX") LIKE <<Item collection code|LCCODE>> AND
  Coalesce(items.itemcallnumber, "-") LIKE Concat(<<Enter first part of call number or a % symbol>>, "%") AND
  Coalesce(not_loans.lib, "-") LIKE <<Not for loan status|LNOT_LOAN>> AND
  (If(
    Coalesce(Year(Coalesce(items.dateaccessioned)), '1999') < '2000', 
    '2000-01-02', 
    items.dateaccessioned
  ) BETWEEN <<Item added between date1|date>> AND <<and date2|date>>) AND
  If(items.onloan IS NULL, 'No', 'Yes') LIKE '%' AND
  (If(
    Coalesce(Year(Coalesce(items.datelastborrowed)), '1999') < '2000', 
    '2000-01-02', 
    items.datelastborrowed
  ) BETWEEN <<Item last borrowed between date1|date>> AND <<and  date2|date>>) AND
  (If(
    Coalesce(Year(Coalesce(items.datelastseen)), '1999') < '2000', 
    '2000-01-02', 
    items.datelastseen
  ) BETWEEN <<Item last seen between date1|date>> AND <<and   date2|date>>) AND
  localcounts.Count_itemnumber >= 0 AND
  systemcounts.Count_itemnumber >= 0
GROUP BY
  biblio.biblionumber,
  items.itemnumber
HAVING
  CHECKOUTS_PLUS_RENEWALS <= <<With X or fewer checkouts|ZNUMBERS>> AND
  CHECKED_OUT_NOW LIKE <<Display checked out items|ZYES_NO>> AND
  STATUS_PROBLEMS LIKE <<Display lost, missing, and withdrawn items|ZYES_NO>> AND
  LOCAL_COPIES >= <<With X or more copies at this library|YNUMBER>> AND
  SYSTEM_COPIES >= <<With X or more copies at throughout the catalog|YNUMBER>>
ORDER BY
  items.homebranch,
  PERMANENT_LOCATION,
  ITYPE,
  CCODE,
  items.itemcallnumber,
  biblio.author,
  FULL_TITLE

























