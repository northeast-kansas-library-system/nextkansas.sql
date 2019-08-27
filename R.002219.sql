/*
R.002219

----------

Name: Records with Existing Placed Holds that are Now Item Level Holds 
Created by: Heather Braum

----------

Group: Administrative Reports
     Holds-admin

Created on: 2014-03-18 21:47:13
Modified on: 2014-03-18 21:57:10
Date last run: -

----------

Public: 0
Expiry: 0

----------

This report watches to see if hold revert to item level; as of 3/18/14, reserve_id 1021643 is the newest one... will have to periodically update this number. it ignores several ILL borrowers and already known item level holds)

----------
*/

SELECT r.reserve_id, r.reservedate, r.borrowernumber, p.firstname, p.surname, r.reservenotes, r.branchcode as pickup, p.branchcode as home, p.categorycode, CONCAT('<a href=\"/cgi-bin/koha/reserve/request.pl?biblionumber=',r.biblionumber,'\" target="_blank">',r.biblionumber,'</a>') AS "Link to Reserves", b.title FROM biblio b LEFT JOIN reserves r USING(biblionumber) LEFT JOIN borrowers p USING(borrowernumber) WHERE r.priority <> '0' AND r.itemnumber IS NOT NULL AND r.borrowernumber NOT IN ('192180','136926','29170','7857','34095','42724') AND reserve_id NOT IN ('784554','784601','784768','785027','852014','852071','852091','884774','919371','940083','958575','962380','976194','986139','991863','994688','995038','996270','996446','996473','996474','1000344','1002058','1003471','1004119','1004126','1004148','1004172','1004547','1004998','1005106','1006093','1006640','1007429','1010308','1014484','1014637','1014639','1014765','1014935','1015048','1015711','1015938','1015968','1016514','1016608','1016614','1018889','1018957','1019474','1019479','1019853','1020240','1020276','1020277','1020280','1020282','1020283','1020284','1020286','1020320','1020332','1020353','1021015','1021057','1021205','1021243') AND r.reservenotes = '' ORDER BY p.branchcode, p.categorycode



