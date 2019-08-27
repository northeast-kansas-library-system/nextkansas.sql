/*
R.002656

----------

Name: Custom Basehor cardholder prefix report
Created by: Heather Braum

----------

Group: Library-Specific
     Basehor

Created on: 2016-01-21 13:32:02
Modified on: 2016-01-21 13:32:02
Date last run: 2018-10-07 16:07:58

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT @1:="Basehor Cardholders Prefixes" AS "Prefixes", substring(cardnumber,1,9), count(*) FROM borrowers WHERE branchcode='basehor' GROUP BY substring(cardnumber,1,9)
UNION ALL 
SELECT @1:="Non-Basehor Cardholders Prefixes", substring(cardnumber,1,9), count(*) FROM borrowers WHERE branchcode !='basehor' and substring(cardnumber,1,9) IN ('100300100','100300600','100300800','100300801','100300802','100300803','100300804','100300900','100300901','100301200','456133','BASECIRC','BASEDIREC','BASETABLE','BASETECH','cityofbas','FURYTEST7','PLEA00004','PLEA00006','PLEA00009','PLEA00010','PLEA00011','PLEA00012','REPAIR-BA','sipterm1','sipterm2','sipterm3','sipterm4','sipuser_b') GROUP BY substring(cardnumber,1,9)



