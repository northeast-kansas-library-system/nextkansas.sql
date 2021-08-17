/*
R.002514

----------

Name: Burlingame Computers Status
Created by: Heather Braum

----------

Group:  BURLINGAME
     -

Created on: 2015-05-26 13:41:59
Modified on: 2021-08-16 13:38:33
Date last run: 2019-12-03 16:39:13

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT 
	CASE 
		WHEN i.itemnumber = '1513837' THEN 'COMPUTER #1'
		WHEN i.itemnumber = '1513838' THEN 'COMPUTER #2'
		WHEN i.itemnumber = '1513839' THEN 'COMPUTER #3'
		WHEN i.itemnumber = '1513841' THEN 'COMPUTER #4'
		WHEN i.itemnumber = '1513842' THEN 'COMPUTER #5'
		WHEN i.itemnumber = '1513844' THEN 'COMPUTER #6'
		END "computers",
i.itemnumber, b.firstname, b.surname, s.issuedate, 30 - TIMESTAMPDIFF(MINUTE,s.issuedate,CURRENT_TIMESTAMP()) 'Minutes remaining',
    IF(TIMESTAMPDIFF(MINUTE,s.issuedate,CURRENT_TIMESTAMP())> 30  ,'YES','') 'Kick off?' FROM borrowers b LEFT JOIN issues s USING(borrowernumber) LEFT JOIN items i USING(itemnumber) WHERE i.itemnumber IN ('1513837','1513838','1513839','1513841','1513842','1513844') GROUP BY computers ORDER BY s.issuedate DESC



