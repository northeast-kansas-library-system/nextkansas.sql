/*
R.003585

----------

Name: GHW - All borrower messaging preferences
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-10-12 15:37:55
Modified on: 2021-10-12 15:44:05
Date last run: 2021-10-12 20:44:31

----------

Public: 0
Expiry: 300

----------

Shows messaging preferences for all borrowers in simple spreadsheet layout.  Includes email and SMS preferences.

----------
*/



SELECT
  borrowers.cardnumber,
  borrowers.branchcode,
  Coalesce(
    If(
      If(borrowers.email = "", borrowers.emailpro, borrowers.email) = "", 
      "-", 
      due_email.DUE
    ), 
    "-"
  ) AS DUE_EMAIL,
  Coalesce(
    If(
      If(borrowers.email = "", borrowers.emailpro, borrowers.email) = "", 
      "-", 
      predue_email.PREDUE
    ), 
    "-"
  ) AS PREDUE_EMAIL,
  Coalesce(
    If(
      If(borrowers.email = "", borrowers.emailpro, borrowers.email) = "", 
      "-", 
      hold_email.HOLD
    ), 
    "-"
  ) AS HOLD_EMAIL,
  Coalesce(
    If(
      If(borrowers.email = "", borrowers.emailpro, borrowers.email) = "", 
      "-", 
      checkin_email.CHECKIN
    ), 
    "-"
  ) AS CHECKIN_EMAIL,
  Coalesce(
    If(
      If(borrowers.email = "", borrowers.emailpro, borrowers.email) = "", 
      "-", 
      checkout_email.CHECKOUT
    ), 
    "-"
  ) AS CHECKOUT_EMAIL,
  Coalesce(due_sms.DUE, "-") AS DUE_SMS,
  Coalesce(predue_sms.PREDUE, "-") AS PREDUE_SMS,
  Coalesce(hold_sms.HOLD, "-") AS HOLD_SMS,
  Coalesce(checkin_sms.CHECKIN, "-") AS CHECKIN_SMS,
  Coalesce(checkout_sms.CHECKOUT, "-") AS CHECKOUT_SMS
FROM
  borrowers LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "HOLD" AS HOLD
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 4 AND
      borrower_message_transport_preferences.message_transport_type = 'email'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) hold_email ON
      hold_email.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      If(borrower_message_preferences.wants_digest = 1, "DUEDGST", "DUE") AS DUE
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 1 AND
      borrower_message_transport_preferences.message_transport_type = 'email'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) due_email ON
      due_email.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      If(
        borrower_message_preferences.wants_digest = 1, 
        Concat("PREDUEDGST: ", borrower_message_preferences.days_in_advance, " day advance"), 
        Concat("PREDUE: ", borrower_message_preferences.days_in_advance, " day advance")
      ) AS PREDUE
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 2 AND
      borrower_message_transport_preferences.message_transport_type = 'email'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) predue_email
    ON predue_email.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "CHECKIN" AS CHECKIN
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 5 AND
      borrower_message_transport_preferences.message_transport_type = 'email'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) checkin_email
    ON checkin_email.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "CHECKOUT" AS CHECKOUT
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 6 AND
      borrower_message_transport_preferences.message_transport_type = 'email'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id)
  checkout_email ON checkout_email.borrowernumber = borrowers.borrowernumber
  LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      If(borrower_message_preferences.wants_digest = 1, "DUEDGST", "DUE") AS DUE
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 1 AND
      borrower_message_transport_preferences.message_transport_type = 'SMS'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) due_sms ON
      due_sms.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      If(
        borrower_message_preferences.wants_digest = 1, 
        Concat("PREDUEDGST: ", borrower_message_preferences.days_in_advance, " day advance"), 
        Concat("PREDUE: ", borrower_message_preferences.days_in_advance, " day advance")
      ) AS PREDUE
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 2 AND
      borrower_message_transport_preferences.message_transport_type = 'SMS'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) predue_sms ON
      predue_sms.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "HOLD" AS HOLD
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 4 AND
      borrower_message_transport_preferences.message_transport_type = 'sms'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) hold_sms ON
      hold_sms.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "CHECKIN" AS CHECKIN
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 5 AND
      borrower_message_transport_preferences.message_transport_type = 'sms'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) checkin_sms
    ON checkin_sms.borrowernumber = borrowers.borrowernumber LEFT JOIN
  (SELECT
      borrower_message_preferences.borrower_message_preference_id,
      borrower_message_preferences.borrowernumber,
      borrower_message_preferences.categorycode,
      borrower_message_preferences.message_attribute_id,
      borrower_message_preferences.days_in_advance,
      borrower_message_preferences.wants_digest,
      borrower_message_transport_preferences.message_transport_type,
      "CHECKOUT" AS CHECKOUT
    FROM
      borrower_message_preferences JOIN
      borrower_message_transport_preferences ON
          borrower_message_transport_preferences.borrower_message_preference_id
          = borrower_message_preferences.borrower_message_preference_id
    WHERE
      borrower_message_preferences.message_attribute_id = 6 AND
      borrower_message_transport_preferences.message_transport_type = 'SMS'
    GROUP BY
      borrower_message_preferences.borrower_message_preference_id) checkout_sms
    ON checkout_sms.borrowernumber = borrowers.borrowernumber
WHERE
  borrowers.branchcode LIKE <<Choose your library|branches:all>>
GROUP BY
  borrowers.borrowernumber
ORDER BY
  borrowers.borrowernumber

























