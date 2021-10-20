/*
R.003259

----------

Name: GHW ADMINREPORT
Created by: George H Williams

----------

Group: -
     -

Created on: 2019-09-06 17:53:26
Modified on: 2019-09-06 17:54:22
Date last run: 2019-09-06 17:55:43

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  If(
    issuingrules.branchcode = "*",
    " All libraries",
    branch_names.branchname
  ) AS LIBRARY,
  Concat_Ws("",
    If(
      issuingrules.categorycode LIKE "*",
      " All patrons",
      borrower_categories.description
    ),
    If(
      borrower_categories.category_type = "A",
      " - (Adult)",
      If(
        borrower_categories.category_type = "C",
        " - (Child)",
        If(
          borrower_categories.category_type = "S",
          " - (Staff)",
          If(
            borrower_categories.category_type = "I",
            " - (Organization)",
            If(
              borrower_categories.category_type = "P",
              " - (Professional)",
              If(
                borrower_categories.category_type = "S",
                " - (Statistical)",
                ""
              )
            )
          )
        )
      )
    )
  ) AS PATRON_CATEGORY,
  If(issuingrules.itemtype LIKE "*", " All item types", item_types.description) AS ITEM_TYPE,
  If(issuingrules.maxissueqty IS NULL, "Unlimited", issuingrules.maxissueqty) AS ITEMS_ALLOWED,
  Concat(issuingrules.issuelength, " ", issuingrules.lengthunit) AS LOAN_PERIOD,
  issuingrules.renewalsallowed AS RENEWALS_ALLOWED,
  Concat(issuingrules.renewalperiod, " ", issuingrules.lengthunit) AS RENEWAL_PERIOD,
  Concat_Ws("",
    If(
      issuingrules.hardduedate IS NULL,
      "",
      If(
        issuingrules.hardduedatecompare = "-1",
        "Items must be returned before ",
        If(
          issuingrules.hardduedatecompare = "0",
          "Items must be turned in before ",
          If(
            issuingrules.hardduedatecompare = "1",
            "Items must be turned in after ",
            "X error X"
          )
        )
      )
    ),
    issuingrules.hardduedate
  ) AS ALL_ITEMS_DUE,
  If(
    issuingrules.auto_renew = "no",
    "",
    Concat_Ws("",
      "Items are set to auto-renew ",
      issuingrules.norenewalbefore,
      " before they are due."
    )
  ) AS auto_renew
FROM
  issuingrules
  LEFT JOIN (
    SELECT
      categories.categorycode,
      categories.description,
      categories.category_type
    FROM
      categories
  ) borrower_categories
    ON borrower_categories.categorycode = issuingrules.categorycode
  LEFT JOIN (
    SELECT
      itemtypes.itemtype,
      itemtypes.description
    FROM
      itemtypes
  ) item_types
    ON item_types.itemtype = issuingrules.itemtype
  LEFT JOIN (
    SELECT
      branches.branchcode,
      branches.branchname
    FROM
      branches
  ) branch_names
    ON branch_names.branchcode = issuingrules.branchcode
WHERE
  (If(issuingrules.branchcode = "*", " All libraries", branch_names.branchname) LIKE "%All lib%" OR
    If(issuingrules.branchcode = "*", " All libraries", issuingrules.branchcode) LIKE <<Select your library|branches>>)
ORDER BY
  LIBRARY,
  If(borrower_categories.category_type = "A", "Adult", If(borrower_categories.category_type = "C", "Child", If(borrower_categories.category_type = "S", "Staff", If(borrower_categories.category_type = "I", "Organization", If(borrower_categories.category_type = "P", "Professional", If(borrower_categories.category_type = "S", "Statistical", "")))))),
  issuingrules.categorycode,
  ITEM_TYPE

























