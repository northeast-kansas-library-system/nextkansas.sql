/*
R.003238

----------

Name: aa
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-07-31 22:07:50
Modified on: 2019-07-31 22:07:50
Date last run: 2019-07-31 22:09:11

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
    CONCAT( p.firstname, ' ', p.surname, ' (', p.branchcode, ')' ) AS 'patron (homebranch)',
    CONCAT( 
        '<img src="/cgi-bin/koha/svc/barcode?barcode=',
         cardnumber, 
        '&type=',
        <<Barcode type>>,
        '"></img>') AS cardnumber,
    cardnumber AS 'cardnumber text' 
FROM
    borrowers p



