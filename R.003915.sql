/*
R.003915

----------

Name: Who renewed report
Created by: George Williams

----------

Group: -
     -

Created on: 2025-09-07 11:44:47
Modified on: 2025-09-07 12:09:18
Date last run: 2025-10-28 21:44:49

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT 
  action_logs.timestamp, 
  Coalesce( 
    active_staff.cardnumber, 
    deleted_staff.cardnumber, 
    '--' 
  ) AS STAFF_MEMBER_WHO_RENEWED_ITEM, 
  Concat_Ws(' / ', 
    items.barcode, 
    items.itemcallnumber, 
    biblio.author, 
    biblio.title 
  ) AS ITEM_RENEWED, 
  Coalesce( 
    borrowers.cardnumber, 
    '--' 
  ) AS BORROWERS_CARD_NUMBER, 
  action_logs.interface AS RENEWAL_INTERFACE 
FROM 
  action_logs 
  LEFT JOIN borrowers active_staff 
    ON active_staff.borrowernumber = action_logs.user 
  LEFT JOIN deletedborrowers deleted_staff 
    ON deleted_staff.borrowernumber = action_logs.user 
  LEFT JOIN items 
    ON items.itemnumber = action_logs.info 
  LEFT JOIN biblio 
    ON biblio.biblionumber = items.biblionumber 
  LEFT JOIN borrowers 
    ON borrowers.borrowernumber = action_logs.object 
WHERE 
  action_logs.module = 'CIRCULATION' AND 
  action_logs.action = 'RENEWAL' AND 
  Coalesce(active_staff.cardnumber, deleted_staff.cardnumber, '--') 
    LIKE Concat('%', &lt;&lt;(Optional) Enter staff member barcode number or "--" for OPAC renewals&gt;&gt;, '%') AND 
  items.barcode 
    LIKE Concat('%', &lt;&lt;(Optional) Enter the barcode number of the item renewed&gt;&gt;, '%') AND 
  borrowers.cardnumber 
    LIKE Concat('%', &lt;&lt;(Optional) Enter the library card number of the borrower who renewed the item&gt;&gt;, '%') AND 
  action_logs.timestamp BETWEEN 
    (Coalesce(&lt;&lt;(Optional) Start of day on date1|date&gt;&gt;, '1900-01-01')) AND 
    (Coalesce(&lt;&lt;(Optional) End of day on date2|date&gt;&gt; + INTERVAL 1 DAY, CurDate() + INTERVAL 1 DAY)) 
GROUP BY 
  action_logs.action_id 
ORDER BY 
  action_logs.timestamp DESC 

























