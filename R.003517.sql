/*
R.003517

----------

Name: GHW - Borrower Categories List
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-06-08 16:41:55
Modified on: 2021-06-08 16:41:55
Date last run: 2021-08-23 12:40:43

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Report version of the patron category summary page</p>
<ul><li>Shows current patron categories</li>
<li>shows all borrower categories system-wide</li>
<li>grouped by category code</li>
<li>sorted by category description</li>
</ul><br />
<p><ins>Notes:</ins></p>
<p></p>
<p></p>
<p></p>
<p class= "notetags" style="display: none;">tag goes here</p>
</div>

----------
*/



SELECT 
  categories.categorycode AS CODE, 
  categories.description AS CATEGORY_NAME, 
  If( 
    categories.category_type = 'A', 'Adult', 
    If( 
      categories.category_type = 'C', 'Minor', 
      If( 
        categories.category_type = 'S', 'Staff', 
        If( 
          categories.category_type = 'I', 'Organization', 
          If( 
            categories.category_type = 'P', 'Professional', 
            If( 
              categories.category_type = 'X', 'Statistical', 
              categories.category_type 
            ) 
          ) 
        ) 
      ) 
    ) 
  ) AS TYPE, 
  If( 
    categories.enrolmentperiod IS NULL, 
    Concat("Until ", categories.enrolmentperioddate), 
    Concat(categories.enrolmentperiod, " months") 
  ) AS ENROLLMENT_PERIOD, 
  If( 
    Concat(categories.dateofbirthrequired, categories.upperagelimit) = 0999, 
    "Any age", 
    If( 
      Concat(categories.dateofbirthrequired, categories.upperagelimit) LIKE "1_999", 
      Concat(categories.dateofbirthrequired, " or older"), 
      Concat_Ws(" -- ", categories.dateofbirthrequired, categories.upperagelimit) 
    ) 
  ) AS AGE_RANGE, 
  categories.enrolmentfee AS ENROLLMENT_FEE, 
  If( 
    categories.overduenoticerequired = 0, 
    "No", 
    "Yes" 
  ) AS OVERDUE, 
  If( 
    categories.hidelostitems = 0, 
    "Shown", 
    "Hidden by default" 
  ) AS LOST_ITEMS, 
  categories.reservefee AS HOLD_FEE, 
  GROUP_CONCAT( 
    DISTINCT messaging_preferences.message 
    ORDER BY messaging_preferences.message_attribute_id 
    SEPARATOR " | " 
  ) AS DEFAULT_MESSAGING, 
  GROUP_CONCAT( 
    DISTINCT categories_branchess.branchcode 
    SEPARATOR " | " 
  ) AS BRANCH_LIMITATIONS, 
  categories.default_privacy AS DEFAULT_PRIVACY 
FROM categories 
  LEFT JOIN 
    (SELECT 
      borrower_message_preferences.categorycode, 
      Concat_Ws(" ", 
        If( 
          message_attributes.message_name = "Item_Checkout", 
          "Email check-out/renewal receipt ", 
          message_attributes.message_name 
        ), 
        Concat( 
          ": ", 
          borrower_message_transport_preferences.message_transport_type), 
          If( 
            borrower_message_preferences.wants_digest = 1, 
            "Digest", 
            "" 
          ), 
          Concat( 
            borrower_message_preferences.days_in_advance, 
            " days in advance" 
          ) 
        ) AS message, 
        borrower_message_preferences.message_attribute_id 
    FROM borrower_message_preferences 
    JOIN borrower_message_transport_preferences 
      ON borrower_message_transport_preferences.borrower_message_preference_id = borrower_message_preferences.borrower_message_preference_id 
    JOIN message_attributes 
      ON borrower_message_preferences.message_attribute_id = message_attributes.message_attribute_id 
    WHERE borrower_message_preferences.borrowernumber IS NULL 
    ORDER BY 
      borrower_message_preferences.categorycode, 
      borrower_message_preferences.message_attribute_id) messaging_preferences 
  ON messaging_preferences.categorycode = categories.categorycode 
  LEFT JOIN 
    (SELECT categories_branches.categorycode, 
            categories_branches.branchcode 
     FROM categories_branches) categories_branchess 
  ON categories_branchess.categorycode = categories.categorycode 
GROUP BY 
  categories.categorycode 
ORDER BY 
  categories.description

























