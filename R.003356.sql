/*
R.003356

----------

Name: Sandbox - Date testing with date variables
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-09 15:11:29
Modified on: 2020-10-09 15:54:37
Date last run: 2020-10-09 15:54:51

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  
  Concat(" DATE") AS branchname,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") AS `01`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-02") AS `02`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-03") AS `03`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-04") AS `04`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-05") AS `05`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-06") AS `06`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-07") AS `07`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-08") AS `08`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-09") AS `09`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-10") AS `10`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-11") AS `11`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-12") AS `12`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-13") AS `13`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-14") AS `14`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-15") AS `15`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-16") AS `16`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-17") AS `17`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-18") AS `18`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-19") AS `19`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-20") AS `20`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-21") AS `21`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-22") AS `22`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-23") AS `23`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-24") AS `24`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-25") AS `25`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-26") AS `26`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-27") AS `27`,  
  Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-28") AS `28`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 28 DAY),  
    Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-29"),  
    "NA"  
  ) AS `29`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 29 DAY),  
    Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-30"),  
    "NA"  
  ) AS `30`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 30 DAY),  
    Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-31"),  
    "NA"  
  ) AS `31`,  
  Concat(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01"), ' - ', Last_Day(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01"))) AS MONTHLY_TOTAL  
UNION
SELECT  
  Concat(" DAY") AS branchname,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01"), "%W") AS `01`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-02"), "%W") AS `02`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-03"), "%W") AS `03`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-04"), "%W") AS `04`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-05"), "%W") AS `05`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-06"), "%W") AS `06`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-07"), "%W") AS `07`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-08"), "%W") AS `08`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-09"), "%W") AS `09`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-10"), "%W") AS `10`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-11"), "%W") AS `11`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-12"), "%W") AS `12`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-13"), "%W") AS `13`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-14"), "%W") AS `14`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-15"), "%W") AS `15`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-16"), "%W") AS `16`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-17"), "%W") AS `17`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-18"), "%W") AS `18`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-19"), "%W") AS `19`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-20"), "%W") AS `20`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-21"), "%W") AS `21`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-22"), "%W") AS `22`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-23"), "%W") AS `23`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-24"), "%W") AS `24`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-25"), "%W") AS `25`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-26"), "%W") AS `26`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-27"), "%W") AS `27`,  
  DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-28"), "%W") AS `28`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 28 DAY),  
    DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-29"), "%W"),  
    "NA"  
  ) AS `29`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 29 DAY),  
    DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-30"), "%W"),  
    "NA"  
  ) AS `30`,  
  If(  
    Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01")) = Month(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01") + interval 30 DAY),  
    DATE_FORMAT(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-31"), "%W"),  
    "NA"  
  ) AS `31`,  
  Concat(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01"), ' - ', Last_Day(Concat(<<Enter the year>>, "-", <<Enter the Month>>, "-01"))) AS MONTHLY_TOTAL  



