/*
R.003357

----------

Name: Sandbox - Date range test
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-10-09 16:07:02
Modified on: 2020-10-09 16:07:49
Date last run: 2020-10-09 16:09:02

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT  
  branchess.branchname,  
  aa.Count_borrowernumber AS `01`,  
  ab.Count_borrowernumber AS `02`,  
  ac.Count_borrowernumber AS `03`,  
  ad.Count_borrowernumber AS `04`,  
  ae.Count_borrowernumber AS `05`,  
  af.Count_borrowernumber AS `06`,  
  ag.Count_borrowernumber AS `07`,  
  ah.Count_borrowernumber AS `08`,  
  ai.Count_borrowernumber AS `09`,  
  aj.Count_borrowernumber AS `10`,  
  ba.Count_borrowernumber AS `11`,  
  bb.Count_borrowernumber AS `12`,  
  bc.Count_borrowernumber AS `13`,  
  bd.Count_borrowernumber AS `14`,  
  be.Count_borrowernumber AS `15`,  
  bf.Count_borrowernumber AS `16`,  
  bg.Count_borrowernumber AS `17`,  
  bh.Count_borrowernumber AS `18`,  
  bi.Count_borrowernumber AS `19`,  
  bj.Count_borrowernumber AS `20`,  
  ca.Count_borrowernumber AS `21`,  
  cb.Count_borrowernumber AS `22`,  
  cc.Count_borrowernumber AS `23`,  
  cd.Count_borrowernumber AS `24`,  
  ce.Count_borrowernumber AS `25`,  
  cf.Count_borrowernumber AS `26`,  
  cg.Count_borrowernumber AS `27`,  
  ch.Count_borrowernumber AS `28`,  
  ci.Count_borrowernumber AS `29`,  
  da.Count_borrowernumber AS `30`,  
  db.Count_borrowernumber AS `31`,  
  zz.Count_borrowernumber AS MONTHLY_TOTAL  
FROM  
  (SELECT  
      branches.branchcode,  
      branches.branchname  
    FROM  
      branches) branchess LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 1  
    GROUP BY  
      statistics.branch) aa ON aa.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 2  
    GROUP BY  
      statistics.branch) ab ON ab.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 3  
    GROUP BY  
      statistics.branch) ac ON ac.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 4  
    GROUP BY  
      statistics.branch) ad ON ad.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 5  
    GROUP BY  
      statistics.branch) ae ON ae.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 6  
    GROUP BY  
      statistics.branch) af ON af.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 7  
    GROUP BY  
      statistics.branch) ag ON ag.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 8  
    GROUP BY  
      statistics.branch) ah ON ah.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 9  
    GROUP BY  
      statistics.branch) ai ON ai.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 10  
    GROUP BY  
      statistics.branch) aj ON aj.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 11  
    GROUP BY  
      statistics.branch) ba ON ba.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 12  
    GROUP BY  
      statistics.branch) bb ON bb.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 13  
    GROUP BY  
      statistics.branch) bc ON bc.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 14  
    GROUP BY  
      statistics.branch) bd ON bd.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 15  
    GROUP BY  
      statistics.branch) be ON be.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 16  
    GROUP BY  
      statistics.branch) bf ON bf.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 17  
    GROUP BY  
      statistics.branch) bg ON bg.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 18  
    GROUP BY  
      statistics.branch) bh ON bh.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 19  
    GROUP BY  
      statistics.branch) bi ON bi.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 20  
    GROUP BY  
      statistics.branch) bj ON bj.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 21  
    GROUP BY  
      statistics.branch) ca ON ca.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 22  
    GROUP BY  
      statistics.branch) cb ON cb.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 23  
    GROUP BY  
      statistics.branch) cc ON cc.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 24  
    GROUP BY  
      statistics.branch) cd ON cd.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 25  
    GROUP BY  
      statistics.branch) ce ON ce.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 26  
    GROUP BY  
      statistics.branch) cf ON cf.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 27  
    GROUP BY  
      statistics.branch) cg ON cg.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 28  
    GROUP BY  
      statistics.branch) ch ON ch.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 29  
    GROUP BY  
      statistics.branch) ci ON ci.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 30  
    GROUP BY  
      statistics.branch) da ON da.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      Year(statistics.datetime) AS YEAR,  
      Month(statistics.datetime) AS MONTH,  
      Day(statistics.datetime) AS DAY,  
      statistics.branch,  
      Count(DISTINCT statistics.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics  
    WHERE  
      (statistics.type = 'issue' OR  
          statistics.type = 'renew') AND  
      Year(statistics.datetime) = "2020" AND    
      Month(statistics.datetime) = "01" AND  
      Day(statistics.datetime) = 31  
    GROUP BY  
      statistics.branch) db ON db.branch = branchess.branchcode LEFT JOIN  
  (SELECT  
      statisticss.branch,  
      Count(DISTINCT statisticss.borrowernumber) AS Count_borrowernumber  
    FROM  
      statistics statisticss  
    WHERE  
      (statisticss.type = 'issue' OR  
          statisticss.type = 'renew') AND  
      statisticss.datetime BETWEEN (AddDate(Last_Day(SubDate(Now(), INTERVAL 2  
      MONTH)), 1)) AND (AddDate(Last_Day(SubDate(Now(), INTERVAL 1 MONTH)), 1))  
    GROUP BY  
      statisticss.branch) zz ON zz.branch = branchess.branchcode  
UNION  
SELECT  
  Concat(" DATE") AS branchname,  
  Concat("2020", "-", "01", "-01") AS `01`,  
  Concat("2020", "-", "01", "-02") AS `02`,  
  Concat("2020", "-", "01", "-03") AS `03`,  
  Concat("2020", "-", "01", "-04") AS `04`,  
  Concat("2020", "-", "01", "-05") AS `05`,  
  Concat("2020", "-", "01", "-06") AS `06`,  
  Concat("2020", "-", "01", "-07") AS `07`,  
  Concat("2020", "-", "01", "-08") AS `08`,  
  Concat("2020", "-", "01", "-09") AS `09`,  
  Concat("2020", "-", "01", "-10") AS `10`,  
  Concat("2020", "-", "01", "-11") AS `11`,  
  Concat("2020", "-", "01", "-12") AS `12`,  
  Concat("2020", "-", "01", "-13") AS `13`,  
  Concat("2020", "-", "01", "-14") AS `14`,  
  Concat("2020", "-", "01", "-15") AS `15`,  
  Concat("2020", "-", "01", "-16") AS `16`,  
  Concat("2020", "-", "01", "-17") AS `17`,  
  Concat("2020", "-", "01", "-18") AS `18`,  
  Concat("2020", "-", "01", "-19") AS `19`,  
  Concat("2020", "-", "01", "-20") AS `20`,  
  Concat("2020", "-", "01", "-21") AS `21`,  
  Concat("2020", "-", "01", "-22") AS `22`,  
  Concat("2020", "-", "01", "-23") AS `23`,  
  Concat("2020", "-", "01", "-24") AS `24`,  
  Concat("2020", "-", "01", "-25") AS `25`,  
  Concat("2020", "-", "01", "-26") AS `26`,  
  Concat("2020", "-", "01", "-27") AS `27`,  
  Concat("2020", "-", "01", "-28") AS `28`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 28 DAY),  
    Concat("2020", "-", "01", "-29"),  
    "NA"  
  ) AS `29`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 29 DAY),  
    Concat("2020", "-", "01", "-30"),  
    "NA"  
  ) AS `30`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 30 DAY),  
    Concat("2020", "-", "01", "-31"),  
    "NA"  
  ) AS `31`,  
  Concat(Concat("2020", "-", "01", "-01"), ' - ', Last_Day(Concat("2020", "-", "01", "-01"))) AS MONTHLY_TOTAL  
UNION
SELECT  
  Concat(" DAY") AS branchname,  
  DATE_FORMAT(Concat("2020", "-", "01", "-01"), "%W") AS `01`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-02"), "%W") AS `02`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-03"), "%W") AS `03`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-04"), "%W") AS `04`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-05"), "%W") AS `05`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-06"), "%W") AS `06`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-07"), "%W") AS `07`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-08"), "%W") AS `08`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-09"), "%W") AS `09`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-10"), "%W") AS `10`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-11"), "%W") AS `11`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-12"), "%W") AS `12`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-13"), "%W") AS `13`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-14"), "%W") AS `14`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-15"), "%W") AS `15`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-16"), "%W") AS `16`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-17"), "%W") AS `17`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-18"), "%W") AS `18`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-19"), "%W") AS `19`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-20"), "%W") AS `20`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-21"), "%W") AS `21`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-22"), "%W") AS `22`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-23"), "%W") AS `23`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-24"), "%W") AS `24`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-25"), "%W") AS `25`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-26"), "%W") AS `26`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-27"), "%W") AS `27`,  
  DATE_FORMAT(Concat("2020", "-", "01", "-28"), "%W") AS `28`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 28 DAY),  
    DATE_FORMAT(Concat("2020", "-", "01", "-29"), "%W"),  
    "NA"  
  ) AS `29`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 29 DAY),  
    DATE_FORMAT(Concat("2020", "-", "01", "-30"), "%W"),  
    "NA"  
  ) AS `30`,  
  If(  
    Month(Concat("2020", "-", "01", "-01")) = Month(Concat("2020", "-", "01", "-01") + interval 30 DAY),  
    DATE_FORMAT(Concat("2020", "-", "01", "-31"), "%W"),  
    "NA"  
  ) AS `31`,  
  Concat(Concat("2020", "-", "01", "-01"), ' - ', Last_Day(Concat("2020", "-", "01", "-01"))) AS MONTHLY_TOTAL  
ORDER BY  
  branchname



