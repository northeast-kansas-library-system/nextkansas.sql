/*
R.000803

----------

Name: Requested titles sorted from greatest number of requests to lowest number of requests
Created by:  Tongie Book Club

----------

Group: Popular Reports
     -

Created on: 2010-02-03 11:08:36
Modified on: 2021-04-02 16:08:09
Date last run: 2022-11-09 14:52:23

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Generates a list of all bibliographic records with requests sorted by the number of requests on each record</p>
<ul><li>Shows records with unfilled reqeusts on them</li>
<li>at all Next Search Catalog libraries</li>
<li>grouped by biblionumber</li>
<li>sorted by number of reqeusts</li>
<li>links to the bibliographic records</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Formerly titled "Most Reserved Titles"</p>
<p></p>
<p>Updated by GHW on 2021.04.02</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=803">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">requests</p>
</div>

----------
*/



SELECT 
  reservess.Count_reserve_id AS UNFILLED_REQUESTS, 
  item_counts.Count_itemnumber AS ITEMS_IN_SYSTEM, 
  biblio.author, 
  Concat_Ws(" ", 
    biblio.title, 
    biblio.subtitle, 
    biblioitems.number, 
    biblio.part_name 
  ) AS FULL_TITLE, 
  locs.lib AS BIB_LOCATION, 
  itypess.description AS BIB_ITYPE, 
  ccodes.lib AS CCODE, 
  Date_Format(biblio.datecreated, "%Y.%m.%d") AS DATE_ADDED, 
  item_counts.Group_Concat_replacementprice AS ITEM_COUNT, 
  old_reservess.Count_reserve_id AS PREVIOUSLY_FILLED_REQUESTS, 
  biblio.biblionumber AS BIBLIO_NUMBER, 
  Concat( 
    '<a class= "clicked" href=\"/cgi-bin/koha/catalogue/detail.pl?biblionumber=', 
    biblio.biblionumber, 
    '\" target="_blank">Go to title</a>' 
  ) AS LINK_TO_TITLE 
FROM 
  biblio JOIN 
  biblioitems ON biblioitems.biblionumber = biblio.biblionumber LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'LOC') locs ON locs.authorised_value = 
      biblioitems.agerestriction LEFT JOIN 
  (SELECT 
      itemtypes.itemtype, 
      itemtypes.description 
    FROM 
      itemtypes) itypess ON itypess.itemtype = biblioitems.itemtype LEFT JOIN 
  (SELECT 
      authorised_values.category, 
      authorised_values.authorised_value, 
      authorised_values.lib, 
      authorised_values.lib_opac 
    FROM 
      authorised_values 
    WHERE 
      authorised_values.category = 'ccode') ccodes ON ccodes.authorised_value = 
      biblioitems.cn_class  JOIN 
  (SELECT 
      items.biblionumber, 
      Count(items.itemnumber) AS Count_itemnumber, 
      GROUP_CONCAT( 
        DISTINCT items.replacementprice 
        ORDER BY items.replacementprice 
        DESC SEPARATOR ' / ' 
      ) AS Group_Concat_replacementprice 
    FROM 
      items 
    GROUP BY 
      items.biblionumber) item_counts ON item_counts.biblionumber = 
      biblio.biblionumber  JOIN 
  (SELECT 
      reserves.biblionumber, 
      Count(reserves.reserve_id) AS Count_reserve_id 
    FROM 
      reserves 
    GROUP BY 
      reserves.biblionumber) reservess ON reservess.biblionumber = 
      biblio.biblionumber LEFT JOIN 
  (SELECT 
      old_reserves.biblionumber, 
      Count(old_reserves.reserve_id) AS Count_reserve_id 
    FROM 
      old_reserves 
    WHERE 
      old_reserves.cancellationdate IS NULL 
    GROUP BY 
      old_reserves.biblionumber) old_reservess ON old_reservess.biblionumber = 
      biblio.biblionumber 
GROUP BY 
  reservess.Count_reserve_id,
  biblio.biblionumber
ORDER BY 
  UNFILLED_REQUESTS DESC

























