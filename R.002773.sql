/*
R.002773

----------

Name: GHW - Card prefix report part 2
Created by: George H Williams

----------

Group: -
     -

Created on: 2016-09-14 09:19:42
Modified on: 2018-04-16 11:02:40
Date last run: 2020-03-24 14:43:46

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo>
<p>Attempts to discern which libraries are using a specified card prefix</p>
<ul><li>reports on current cards in NExpress</li>
<li>shows a count of how many cards with the specified prefix exist at all NExpress libraries</li>
<li>grouped and sorted by patron home library</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p>Report 2771 is the companion to this report</p>
<p>Report created at the request of Robin Hastings.</p>
<p>Report created by George Williams.</p>
</div>

----------
*/

SELECT
  borrowers.branchcode AS BORROWERS_HOME_LIBRARY,
  Count(borrowers.cardnumber) AS CARD_COUNT
FROM
  borrowers
WHERE
  borrowers.cardnumber LIKE CONCAT((<<Card prefix>>),'%')
GROUP BY
  borrowers.branchcode
  WITH ROLLUP



