/*
R.003017

----------

Name: Days since hold waiting date
Created by: Bywater bwssupport

----------

Group: -
     -

Created on: 2017-12-12 17:39:27
Modified on: 2017-12-12 17:39:27
Date last run: 2017-12-12 17:39:38

----------

Public: 0
Expiry: 300

----------



----------
*/

SELECT
    reserve_id,
    borrowernumber,
    cardnumber,
    firstname,
    surname,
    itemnumber,
    biblio.title,
    barcode,
    datediff(CURRENT_DATE, waitingdate) AS 'days waiting',
    expirationdate,
    reserves.branchcode as 'holdingbranch'
FROM
    reserves
    left join biblio using (biblionumber)
    left join borrowers using (borrowernumber)
    left join items using (itemnumber)
WHERE
    found = 'w'
ORDER BY
    holdingbranch,
    waitingdate asc



