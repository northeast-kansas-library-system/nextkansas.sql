/*
R.002609

----------

Name: Orphaned requests
Created by: Heather Braum

----------

Group: Holds-Reserves
     -

Created on: 2015-09-24 17:47:27
Modified on: 2022-09-29 09:30:01
Date last run: 2025-07-22 15:55:33

----------

Public: 0
Expiry: 0

----------

The report returns patron's holds on records where, at the time of the hold placing, the record had items available to fulfill holds, but for a number of reasons, no items remain available at this time to fulfill the holds, due to:

1) Last item available is overdue by 30+ days. 
2) Last item available is marked lost/damaged/withdrawn.
3) Last item available is now not for loan (report ignores items with on-order status)

The report returns a link to your patron's account, the patron's name, when the hold was placed and a link to the record.

Please do the following to clean these up: 

1) Determine if your patron still wants the requested material. 
2) If the patron does still want the item, delete the hold, and either see if another record of the same title, similar format, is available in NExpress or request through ILL.
3) If your patron does not want the item, please delete the hold. 

credit: Jesse Weaver @ ByWater

----------
*/



SELECT 
  Concat( 
    'Link to borrower' 
  ) AS LINK_TO_BORROWER, 
  reserves.biblionumber, 
  Date_Format(reserves.reservedate, "%Y-%m-%d") AS reservedate, 
  Date_Format(reserves.expirationdate, "%Y-%m-%d") AS expirationdate, 
  Date_Format(reserves.reservedate + INTERVAL 1 YEAR, "%Y-%m-%d") AS one_year, 
  Concat( 
    'Link to request' 
  ) AS LINK_TO_BIBLIO 
FROM 
  (SELECT 
      items.biblionumber, 
      Count(DISTINCT items.itemnumber) AS Count_itemnumber, 
      items.notforloan, 
      items.damaged, 
      items.itemlost, 
      items.withdrawn 
    FROM 
      items 
    WHERE 
      (items.notforloan &lt; 1 OR 
        items.notforloan IS NULL) AND 
      (items.damaged = 0 OR 
        items.damaged IS NULL) AND 
      (items.itemlost = 0 OR 
        items.itemlost IS NULL) AND 
      (items.withdrawn = 0 OR 
        items.withdrawn IS NULL) 
    GROUP BY 
      items.biblionumber, 
      items.notforloan, 
      items.damaged, 
      items.itemlost, 
      items.withdrawn) counts RIGHT JOIN 
  reserves ON counts.biblionumber = reserves.biblionumber 
WHERE 
  Coalesce(counts.Count_itemnumber, 0) = 0 AND 
  reserves.branchcode LIKE &lt;&gt; 
ORDER BY 
  expirationdate, 
  one_year DESC 

























