/*
R.003267

----------

Name: GHW - ISBN errors
Created by: George Williams

----------

Group: -
     -

Created on: 2019-09-25 09:45:18
Modified on: 2024-01-17 12:09:03
Date last run: 2019-11-04 15:52:00

----------

Public: 0
Expiry: 300

----------

 
Generates a list of bibliographic records with parentheses in the 020$a field
Shows records where the ISBN contains data that should go in the 020$q field rather than the $a field
lists records at all libraries
grouped and sorted by biblionumber


Click here to run in a new window
Click here to download as a csv file


----------
*/



SELECT
  biblio.biblionumber,
  biblio.author,
  biblio.title,
  biblioitems.isbn,
  biblioitems.itemtype
FROM
  biblio
  JOIN biblioitems
    ON biblioitems.biblionumber = biblio.biblionumber
WHERE
  biblioitems.isbn LIKE '%(%' AND
  biblioitems.itemtype &lt;&gt; 'DIGITAL'
GROUP BY
  biblio.biblionumber
ORDER BY
  biblio.biblionumber DESC

























