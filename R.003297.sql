/*
R.003297

----------

Name: GHW - Patron receiving SMS messages with an account updated in the previous month
Created by: George H Williams

----------

Group: -
     -

Created on: 2020-01-09 13:43:08
Modified on: 2020-01-09 13:43:08
Date last run: 2022-10-06 14:31:31

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  borrowers.branchcode,
  borrowers.cardnumber,
  borrower_message_transport_preferences.message_transport_type,
  borrowers.updated_on
FROM
  borrowers
  INNER JOIN borrower_message_preferences
    ON borrower_message_preferences.borrowernumber = borrowers.borrowernumber
  INNER JOIN borrower_message_transport_preferences
    ON borrower_message_transport_preferences.borrower_message_preference_id = borrower_message_preferences.borrower_message_preference_id
WHERE
  borrowers.branchcode = <<Choose your library|branches>> AND
  borrower_message_transport_preferences.message_transport_type = 'SMS' AND
  borrowers.updated_on > Now() - INTERVAL 1 MONTH
GROUP BY
  borrowers.branchcode,
  borrowers.cardnumber,
  borrower_message_transport_preferences.message_transport_type,
  borrowers.updated_on
ORDER BY
  borrowers.updated_on DESC

























