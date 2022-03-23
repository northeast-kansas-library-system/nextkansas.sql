/*
R.002527

----------

Name: 25 month circulaiton history for a borrower
Created by: Heather Braum

----------

Group: Borrowers
     -

Created on: 2015-06-24 17:10:01
Modified on: 2022-02-07 21:31:27
Date last run: 2022-02-07 22:24:01

----------

Public: 0
Expiry: 0

----------

<div id=reportinfo class=noprint>
<p>Shows borrower history from the statistics table (goes back 25 months)</p>
<ul><li>Shows history for the previous 25 months</li>
<li>for the borrower you specify</li>
<li>grouped by itemnumber</li>
<li>sorted by statistics date</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p>Updated in February of 2022</p>
<p></p>
<p class= "notetags" style="display: none;">#borrowers #circulation_history</p>
</div>

----------
*/



SELECT 
  borrowers.cardnumber, 
  If(borrowers.privacy = 2, 'History', cko_branch.branchname) AS branchname, 
  If(borrowers.privacy = 2, 'set to', statistics.datetime) AS CKO_RENEW_DATE, 
  If( 
    borrowers.privacy = 2, 
    'anonymous', 
    Concat_Ws('<br />', 
      branches.branchname, 
      locs.lib, 
      itemtypes.description, 
      ccodes.lib, 
      biblio.author, 
      biblio.title, 
      biblio.subtitle, 
      items.itemcallnumber, 
      items.copynumber, 
      items.barcode 
    ) 
  ) AS INFO 
FROM 
  statistics JOIN 
  borrowers ON borrowers.borrowernumber = statistics.borrowernumber JOIN 
  items ON items.itemnumber = statistics.itemnumber JOIN 
  branches cko_branch ON cko_branch.branchcode = statistics.branch JOIN 
  branches ON branches.branchcode = items.homebranch LEFT JOIN 
  (SELECT 
     authorised_values.category, 
     authorised_values.authorised_value, 
     authorised_values.lib, 
     authorised_values.lib_opac 
   FROM 
     authorised_values 
   WHERE 
     authorised_values.category = 'loc') locs ON locs.authorised_value = 
      items.permanent_location LEFT JOIN 
  itemtypes ON itemtypes.itemtype = items.itype LEFT JOIN 
  (SELECT 
     authorised_values.category, 
     authorised_values.authorised_value, 
     authorised_values.lib, 
     authorised_values.lib_opac 
   FROM 
     authorised_values 
   WHERE 
     authorised_values.category = 'ccode') ccodes ON 
       ccodes.authorised_value = items.ccode JOIN 
  biblio ON items.biblionumber = biblio.biblionumber 
WHERE 
  (statistics.type = 'issue' OR 
      statistics.type = 'renew') AND 
  borrowers.cardnumber = <<Enter card number>> 
GROUP BY 
  borrowers.cardnumber, 
  If(borrowers.privacy = 2, 'History', cko_branch.branchname), 
  If(borrowers.privacy = 2, 'set to', statistics.datetime), 
  If( 
    borrowers.privacy = 2, 
    'anonymous', 
    Concat_Ws('<br />', 
      branches.branchname, 
      locs.lib, 
      itemtypes.description, 
      ccodes.lib, 
      biblio.author, 
      biblio.title, 
      biblio.subtitle, 
      items.itemcallnumber, 
      items.copynumber, 
      items.barcode 
    ) 
  ) 
ORDER BY 
  CKO_RENEW_DATE DESC

























