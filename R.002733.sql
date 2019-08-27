/*
R.002733

----------

Name: GHW - Expiration Query
Created by: George H Williams

----------

Group: Administrative Reports
     -

Created on: 2016-08-12 18:20:41
Modified on: 2016-08-12 18:24:22
Date last run: -

----------

Public: 0
Expiry: 0

----------



----------
*/

SELECT @1:="2003" AS "expiry year",  Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2003%'
UNION
SELECT @1:="2004", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2004%'
UNION
SELECT @1:="2005", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2005%'
UNION
SELECT @1:="2006", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2006%'
UNION
SELECT @1:="2007", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2007%'
UNION
SELECT @1:="2008", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2008%'
UNION
SELECT @1:="2009", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2009%'
UNION
SELECT @1:="2010", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2010%'
UNION
SELECT @1:="2011", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2011%'
UNION
SELECT @1:="2012", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2012%'
UNION
SELECT @1:="2013", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2013%'
UNION
SELECT @1:="2014", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2014%'
UNION
SELECT @1:="2015", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2015%'
UNION
SELECT @1:="2016", Count(DISTINCT borrowers.borrowernumber) AS Count_borrowernumber FROM borrowers WHERE borrowers.dateexpiry LIKE '%2016%'



