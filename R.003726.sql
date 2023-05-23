/*
R.003726

----------

Name: Borrowers by messaging preference
Created by: George H Williams

----------

Group: -
     -

Created on: 2023-04-20 13:37:58
Modified on: 2023-04-20 14:05:12
Date last run: 2023-04-20 14:06:36

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  branches.branchname,
  borrowers.cardnumber,
  If(due.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS DUE,
  If(predue.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS PREDUE,
  If(hold.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS HOLD,
  If(checkin.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS CHECKIN,
  If(checkout.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS CHECKOUT,
  If(hold_reminder.borrower_message_preference_id IS NULL, 'Disabled', 'X') AS
  HOLD_REMINDER
FROM
  borrowers LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 1) due ON
      due.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 2) predue ON
      predue.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 4) hold ON
      hold.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 5) checkin ON
      checkin.borrower_message_preference_id = borrowers.borrowernumber
  LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 6) checkout ON
      checkout.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest
    FROM
      borrower_message_preferences
    WHERE
      borrower_message_preferences.message_attribute_id = 10) hold_reminder ON
      hold_reminder.borrowernumber = borrowers.borrowernumber LEFT JOIN
  branches ON borrowers.branchcode = branches.branchcode
WHERE
  borrowers.branchcode LIKE <<Select borrower home library|branches:all>> AND
  If(due.borrower_message_preference_id IS NULL, '0', If(due.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Item due" enabled|YES_NO:all>> AND
  If(predue.borrower_message_preference_id IS NULL, '0', If(predue.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Advance notice" enabled|YES_NO:all>> AND
  If(hold.borrower_message_preference_id IS NULL, '0', If(hold.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Hold filled" enabled|YES_NO:all>> AND
  If(checkin.borrower_message_preference_id IS NULL, '0', If(checkin.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Email check-in receipt " enabled|YES_NO:all>> AND
  If(checkout.borrower_message_preference_id IS NULL, '0', If(checkout.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Email check-out/renewal receipt and renewa" enabled|YES_NO:all>> AND
  If(hold_reminder.borrower_message_preference_id IS NULL, '0', If(hold_reminder.borrower_message_preference_id = '', '0', '1')) LIKE <<Is "Hold reminder" enabled|YES_NO:all>>
GROUP BY
  borrowers.borrowernumber

























