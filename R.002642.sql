/*
R.002642

----------

Name: What's not accounted for in Basehor circ reports (item list)?
Created by: Heather Braum

----------

Group: Library-Specific
     Basehor

Created on: 2015-12-10 15:01:04
Modified on: 2015-12-10 15:02:13
Date last run: -

----------

Public: 0
Expiry: 0

----------

Barcode is linked to the edit item screen, if an edit needs to be made to the barcode. 

----------
*/

SELECT itemcallnumber, ccode, location, CONCAT('<a href=\"/cgi-bin/koha/cataloguing/additem.pl?op=edititem&biblionumber=',biblio.biblionumber,'&itemnumber=',items.itemnumber,'#edititem\" target="_blank">',barcode,'</a>') as "edit item" FROM items left join biblio using(biblionumber) WHERE homebranch='basehor' AND (itemcallnumber NOT LIKE 'F %' AND itemcallnumber NOT LIKE '0%' AND itemcallnumber NOT LIKE '1%' AND itemcallnumber NOT LIKE '2%' AND itemcallnumber NOT LIKE '3%' AND itemcallnumber NOT LIKE '4%' AND itemcallnumber NOT LIKE '5%' AND itemcallnumber NOT LIKE '6%' AND itemcallnumber NOT LIKE '7%' AND itemcallnumber NOT LIKE '8%' AND itemcallnumber NOT LIKE '9%' AND itemcallnumber NOT LIKE 'B%' AND itemcallnumber NOT LIKE 'LP F%' AND itemcallnumber NOT LIKE 'GN F%' AND itemcallnumber NOT LIKE 'GN 0%' AND itemcallnumber NOT LIKE 'GN 1%' AND itemcallnumber NOT LIKE 'GN 2%' AND itemcallnumber NOT LIKE 'GN 3%' AND itemcallnumber NOT LIKE 'GN 4%' AND itemcallnumber NOT LIKE 'GN 5%' AND itemcallnumber NOT LIKE 'GN 6%' AND itemcallnumber NOT LIKE 'GN 7%' AND itemcallnumber NOT LIKE 'GN 8%' AND itemcallnumber NOT LIKE 'GN 9%' AND itemcallnumber NOT LIKE 'pbk %' AND itemcallnumber NOT LIKE 'CDF %' AND itemcallnumber NOT LIKE 'CD0%' AND itemcallnumber NOT LIKE 'CD1%' AND itemcallnumber NOT LIKE 'CD2%' AND itemcallnumber NOT LIKE 'CD3%' AND itemcallnumber NOT LIKE 'CD4%' AND itemcallnumber NOT LIKE 'CD5%' AND itemcallnumber NOT LIKE 'CD6%' AND itemcallnumber NOT LIKE 'CD7%' AND itemcallnumber NOT LIKE 'CD8%' AND itemcallnumber NOT LIKE 'CD9%' AND itemcallnumber NOT LIKE 'CD BIO %' AND itemcallnumber NOT LIKE 'DV0%' AND itemcallnumber NOT LIKE 'DV1%' AND itemcallnumber NOT LIKE 'DV2%' AND itemcallnumber NOT LIKE 'DV3%' AND itemcallnumber NOT LIKE 'DV4%' AND itemcallnumber NOT LIKE 'DV5%' AND itemcallnumber NOT LIKE 'DV6%' AND itemcallnumber NOT LIKE 'DV7%' AND itemcallnumber NOT LIKE 'DV8%' AND itemcallnumber NOT LIKE 'DV9%' AND itemcallnumber NOT LIKE 'DVBIO%' AND itemcallnumber NOT LIKE 'DVF%' AND itemcallnumber NOT LIKE 'EB %' AND itemcallnumber NOT LIKE 'E %' AND itemcallnumber NOT LIKE 'E KIT %' AND itemcallnumber NOT LIKE 'E0%' AND itemcallnumber NOT LIKE 'E1%' AND itemcallnumber NOT LIKE 'E2%' AND itemcallnumber NOT LIKE 'E3%' AND itemcallnumber NOT LIKE 'E4%' AND itemcallnumber NOT LIKE 'E5%' AND itemcallnumber NOT LIKE 'E6%' AND itemcallnumber NOT LIKE 'E7%' AND itemcallnumber NOT LIKE 'E8%' AND itemcallnumber NOT LIKE 'E9%' AND itemcallnumber NOT LIKE 'EBIO %' AND itemcallnumber NOT LIKE 'ER %' AND itemcallnumber NOT LIKE 'ER0%' AND itemcallnumber NOT LIKE 'ER1%' AND itemcallnumber NOT LIKE 'ER2%' AND itemcallnumber NOT LIKE 'ER3%' AND itemcallnumber NOT LIKE 'ER4%' AND itemcallnumber NOT LIKE 'ER5%' AND itemcallnumber NOT LIKE 'ER6%' AND itemcallnumber NOT LIKE 'ER7%' AND itemcallnumber NOT LIKE 'ER8%' AND itemcallnumber NOT LIKE 'ER9%' AND itemcallnumber NOT LIKE 'ERBIO %' AND itemcallnumber NOT LIKE 'JF %' AND itemcallnumber NOT LIKE 'J0%' AND itemcallnumber NOT LIKE 'J1%' AND itemcallnumber NOT LIKE 'J2%' AND itemcallnumber NOT LIKE 'J3%' AND itemcallnumber NOT LIKE 'J4%' AND itemcallnumber NOT LIKE 'J5%' AND itemcallnumber NOT LIKE 'J6%' AND itemcallnumber NOT LIKE 'J7%' AND itemcallnumber NOT LIKE 'J8%' AND itemcallnumber NOT LIKE 'J9%' AND itemcallnumber NOT LIKE 'JBIO %' AND itemcallnumber NOT LIKE 'JGN %' AND itemcallnumber NOT LIKE 'JGN0%' AND itemcallnumber NOT LIKE 'JGN1%' AND itemcallnumber NOT LIKE 'JGN2%' AND itemcallnumber NOT LIKE 'JGN3%' AND itemcallnumber NOT LIKE 'JGN4%' AND itemcallnumber NOT LIKE 'JGN5%' AND itemcallnumber NOT LIKE 'JGN6%' AND itemcallnumber NOT LIKE 'JGN7%' AND itemcallnumber NOT LIKE 'JGN8%' AND itemcallnumber NOT LIKE 'JGN9%' AND itemcallnumber NOT LIKE 'DVJ %' AND itemcallnumber NOT LIKE 'DJ0%' AND itemcallnumber NOT LIKE 'DJ1%' AND itemcallnumber NOT LIKE 'DJ2%' AND itemcallnumber NOT LIKE 'DJ3%' AND itemcallnumber NOT LIKE 'DJ4%' AND itemcallnumber NOT LIKE 'DJ5%' AND itemcallnumber NOT LIKE 'DJ6%' AND itemcallnumber NOT LIKE 'DJ7%' AND itemcallnumber NOT LIKE 'DJ8%' AND itemcallnumber NOT LIKE 'DJ9%' AND itemcallnumber NOT LIKE 'E KIT %' AND itemcallnumber NOT LIKE 'CDE %' AND itemcallnumber NOT LIKE 'CDJ %' AND itemcallnumber NOT LIKE 'CDJ MUSIC%' AND itemcallnumber NOT LIKE 'CDJ0%' AND itemcallnumber NOT LIKE 'CDJ1%' AND itemcallnumber NOT LIKE 'CDJ2%' AND itemcallnumber NOT LIKE 'CDJ3%' AND itemcallnumber NOT LIKE 'CDJ4%' AND itemcallnumber NOT LIKE 'CDJ5%' AND itemcallnumber NOT LIKE 'CDJ6%' AND itemcallnumber NOT LIKE 'CDJ7%' AND itemcallnumber NOT LIKE 'CDJ8%' AND itemcallnumber NOT LIKE 'CDJ9%' AND itemcallnumber NOT LIKE 'CDJ MUSIC%' AND itemcallnumber NOT LIKE 'VGJ PS%' AND itemcallnumber NOT LIKE 'VGJ Wii %' AND itemcallnumber NOT LIKE 'VGJ XB%' AND itemcallnumber NOT LIKE 'YF %' AND itemcallnumber NOT LIKE 'Y0%' AND itemcallnumber NOT LIKE 'Y1%' AND itemcallnumber NOT LIKE 'Y2%' AND itemcallnumber NOT LIKE 'Y3%' AND itemcallnumber NOT LIKE 'Y4%' AND itemcallnumber NOT LIKE 'Y5%' AND itemcallnumber NOT LIKE 'Y6%' AND itemcallnumber NOT LIKE 'Y7%' AND itemcallnumber NOT LIKE 'Y8%' AND itemcallnumber NOT LIKE 'Y9%' AND itemcallnumber NOT LIKE 'YBIO %' AND itemcallnumber NOT LIKE 'LP YF %' AND itemcallnumber NOT LIKE 'YGN %' AND itemcallnumber NOT LIKE 'YGN0%' AND itemcallnumber NOT LIKE 'YGN1%' AND itemcallnumber NOT LIKE 'YGN2%' AND itemcallnumber NOT LIKE 'YGN3%' AND itemcallnumber NOT LIKE 'YGN4%' AND itemcallnumber NOT LIKE 'YGN5%' AND itemcallnumber NOT LIKE 'YGN6%' AND itemcallnumber NOT LIKE 'YGN7%' AND itemcallnumber NOT LIKE 'YGN8%' AND itemcallnumber NOT LIKE 'YGN9%' AND itemcallnumber NOT LIKE 'CDY %' AND itemcallnumber NOT LIKE 'CSY %' AND itemcallnumber NOT LIKE 'VGY PS%' AND itemcallnumber NOT LIKE 'VGY Wii %' AND itemcallnumber NOT LIKE 'VGY XB%') ORDER BY ccode, location, itemcallnumber



