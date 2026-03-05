/*
R.003801

----------

Name: sandbox
Created by: George Williams

----------

Group: -
     -

Created on: 2024-02-15 15:15:47
Modified on: 2024-02-28 14:08:14
Date last run: 2024-02-28 14:08:14

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT month,
	holds_placed,
    holds_transferred,
    holds_filled,
    checkouts,
    unique_active_patrons,
    enrolled_patrons,
    round(unique_active_patrons/enrolled_patrons*100,2) as percent_active_patrons
FROM
(SELECT 
    DATE_FORMAT(timestamp,'%y %m') as month,
    SUM(IF(module='holds' and action like 'crea%',1,0)) as holds_placed,
    SUM(IF(module='holds' and action='fill',1,0)) as holds_filled,
    SUM(IF(module='circulation' and action='issue',1,0)) as checkouts
	FROM action_logs a
	WHERE date(timestamp) BETWEEN DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 4 month)),interval 1 day) AND LAST_DAY(DATE_SUB(CURDATE(),interval 1 month))
	GROUP BY month) tee
LEFT JOIN
(SELECT DATE_FORMAT(b.datearrived,'%y %m') as month,
	count(b.branchtransfer_id) as holds_transferred 
	FROM branchtransfers b
	WHERE b.reason='reserve' and b.datearrived BETWEEN DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 4 month)),interval 1 day) AND LAST_DAY(DATE_SUB(CURDATE(),interval 1 month))
	GROUP BY month) hee USING (month)
LEFT JOIN
(SELECT date_format(p.datetime,'%y %m') as month,
	count(DISTINCT p.hashed_borrowernumber) as unique_active_patrons
FROM pseudonymized_transactions p
WHERE date(p.datetime) BETWEEN DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 4 month)),interval 1 day) AND LAST_DAY(DATE_SUB(CURDATE(),interval 1 month))
AND p.transaction_type='issue'
GROUP BY month) bee USING (month)
LEFT JOIN
(SELECT DATE_FORMAT(DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 2 month)),interval 1 day),'%y %m') as month,
	SUM(IF(b.dateenrolled <= DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 2 month)),interval 1 day),1,0)) as enrolled_patrons
FROM borrowers b
WHERE b.categorycode not like '%dcsd'

UNION ALL

SELECT DATE_FORMAT(DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 3 month)),interval 1 day),'%y %m') as month,
	SUM(IF(b.dateenrolled <= DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 3 month)),interval 1 day),1,0)) as enrolled_patrons
FROM borrowers b
WHERE b.categorycode not like '%dcsd'

UNION ALL

SELECT DATE_FORMAT(DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 4 month)),interval 1 day),'%y %m') as month,
	SUM(IF(b.dateenrolled <= DATE_ADD(LAST_DAY(DATE_SUB(CURDATE(),interval 4 month)),interval 1 day),1,0)) as enrolled_patrons
FROM borrowers b
WHERE b.categorycode not like '%dcsd') gee USING (month)
ORDER BY month desc

























