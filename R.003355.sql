/*
R.003355

----------

Name: GHW - Monthly 310 Monthly unique borrower usage count by date
Created by: George H Williams

----------

Group: Statistics
     Last month's statistics - Next-wide

Created on: 2020-10-08 22:42:10
Modified on: 2021-07-30 10:53:54
Date last run: 2021-11-01 09:46:02

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Unique patron count last month by day and by month overall</p>
<ul><li>Shows a count of unique patron accounts used to check out materials on each day of the previous calendar month</li>
<li>includes a unique patron account per month in the final column</li>
<li>at all libraries</li>
<li>grouped and sorted by branch name</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>The report will time-out if run live on the server.  The best way to run this report is to use the scheduler to have it e-mailed directly to whomever wants it.</p>
<p></p>
<p id="rquickdown"><a href="/cgi-bin/koha/reports/guided_reports.pl?reports=1&phase=Export&format=csv&report_id=3355">Click here to download as a csv file</a></p>
<p class= "notetags" style="display: none;">tag goes here</p>
<p style="display: none";>george@nekls.org --subject='3355' --format=csv --csv-header -a</p>
</div>

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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
      Year(statistics.datetime) = Year(Now() - INTERVAL 1 MONTH) AND  
      Month(statistics.datetime) = Month(Now() - INTERVAL 1 MONTH) AND  
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
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) AS `01`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY AS `02`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY AS `03`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY AS `04`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY AS `05`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY AS `06`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY AS `07`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY AS `08`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY AS `09`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY AS `10`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY AS `11`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY AS `12`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY AS `13`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY AS `14`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY AS `15`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY AS `16`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY AS `17`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY AS `18`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY AS `19`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY AS `20`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY AS `21`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY AS `22`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY AS `23`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY AS `24`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY AS `25`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY AS `26`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY AS `27`,  
  AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY AS `28`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY,  
    "NA"  
  ) AS `29`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY,  
    "NA"  
  ) AS `30`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY,  
    "NA"  
  ) AS `31`,  
  Concat(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1), ' - ', Last_Day(CURRENT_DATE()) - INTERVAL 1 MONTH) AS MONTHLY_TOTAL  
UNION  
SELECT  
  Concat(" DAY") AS branchname,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1), "%W") AS `01`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 1 DAY, "%W") AS `02`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 2 DAY, "%W") AS `03`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 3 DAY, "%W") AS `04`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 4 DAY, "%W") AS `05`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 5 DAY, "%W") AS `06`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 6 DAY, "%W") AS `07`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 7 DAY, "%W") AS `08`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 8 DAY, "%W") AS `09`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 9 DAY, "%W") AS `10`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 10 DAY, "%W") AS `11`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 11 DAY, "%W") AS `12`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 12 DAY, "%W") AS `13`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 13 DAY, "%W") AS `14`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 14 DAY, "%W") AS `15`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 15 DAY, "%W") AS `16`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 16 DAY, "%W") AS `17`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 17 DAY, "%W") AS `18`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 18 DAY, "%W") AS `19`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 19 DAY, "%W") AS `20`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 20 DAY, "%W") AS `21`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 21 DAY, "%W") AS `22`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 22 DAY, "%W") AS `23`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 23 DAY, "%W") AS `24`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 24 DAY, "%W") AS `25`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 25 DAY, "%W") AS `26`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 26 DAY, "%W") AS `27`,  
  Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 27 DAY, "%W") AS `28`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 28 DAY, "%W"),  
    "NA"  
  ) AS `29`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 29 DAY, "%W"),  
    "NA"  
  ) AS `30`,  
  If(  
    Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY) = Month(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1)),  
    Date_Format(AddDate(Last_Day(SubDate(Now(), INTERVAL 2 MONTH)), 1) + INTERVAL 30 DAY, "%W"),  
    "NA"  
  ) AS `31`,  
  Concat('-') AS MONTHLY_TOTAL  
ORDER BY  
  branchname

























