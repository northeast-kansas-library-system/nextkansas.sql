/*
R.003555

----------

Name: GHW - Oldest/newest in progress
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-07 00:47:08
Modified on: 2021-09-13 19:56:26
Date last run: 2021-10-11 09:10:04

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  Concat("-FINES_FEES-") AS TABLE_NAME,
  Concat("-FINES_FEES-") AS SUB_FIELD,
  Concat("-FINES_FEES-") AS OLDEST,
  Concat("-FINES_FEES-") AS NEWEST
UNION
SELECT
  Concat("accountlines") AS TABLE_NAME,
  Concat("date") AS SUB_FIELD,
  Date_Format(Min(accountlines.date), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(accountlines.date), "%Y - %m - %d") AS NEWEST
FROM accountlines
UNION
SELECT
  Concat("accountlines") AS TABLE_NAME,
  Concat("timestamp") AS SUB_FIELD,
  Date_Format(Min(accountlines.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(accountlines.timestamp), "%Y - %m - %d") AS NEWEST
FROM accountlines
UNION
SELECT
  Concat("account_offsets") AS TABLE_NAME,
  Concat("created_on") AS SUB_FIELD,
  Date_Format(Min(account_offsets.created_on), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(account_offsets.created_on), "%Y - %m - %d") AS NEWEST
FROM account_offsets
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("-") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("action_logs") AS TYPE,
  action_logs.module,
  Date_Format(Min(action_logs.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(action_logs.timestamp), "%Y - %m - %d") AS NEWEST
FROM action_logs
GROUP BY action_logs.module
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("--") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("-ACQUISITIONS-") AS Column1,
  Concat("-ACQUISITIONS-") AS Column2,
  Concat("-ACQUISITIONS-") AS Column3,
  Concat("-ACQUISITIONS-") AS Column4
UNION
SELECT
  Concat("aqbasket") AS TABLE_NAME,
  Concat("creationdate") AS SUB_FIELD,
  Date_Format(Min(aqbasket.creationdate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqbasket.creationdate), "%Y - %m - %d") AS NEWEST
FROM aqbasket
UNION
SELECT
  Concat("aqbasket") AS TABLE_NAME,
  Concat("closedate") AS SUB_FIELD,
  Date_Format(Min(aqbasket.closedate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqbasket.closedate), "%Y - %m - %d") AS NEWEST
FROM aqbasket
UNION
SELECT
  Concat("aqbudgets") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(aqbudgets.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqbudgets.timestamp), "%Y - %m - %d") AS NEWEST
FROM aqbudgets
UNION
SELECT
  Concat("aqinvoice_adjustments") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(aqinvoice_adjustments.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqinvoice_adjustments.timestamp), "%Y - %m - %d") AS NEWEST
FROM aqinvoice_adjustments
UNION
SELECT
  Concat("aqinvoices") AS TABLE_NAME,
  Concat("shipmentdate") AS SUB_FIELD,
  Date_Format(Min(aqinvoices.shipmentdate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqinvoices.shipmentdate), "%Y - %m - %d") AS NEWEST
FROM aqinvoices
UNION
SELECT
  Concat("aqinvoices") AS TABLE_NAME,
  Concat("billingdate") AS SUB_FIELD,
  Date_Format(Min(aqinvoices.billingdate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqinvoices.billingdate), "%Y - %m - %d") AS NEWEST
FROM aqinvoices
UNION
SELECT
  Concat("aqinvoices") AS TABLE_NAME,
  Concat("closedate") AS SUB_FIELD,
  Date_Format(Min(aqinvoices.closedate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqinvoices.closedate), "%Y - %m - %d") AS NEWEST
FROM aqinvoices
UNION
SELECT
  Concat("aqorders") AS TYPE,
  Concat("entrydate") AS Column1,
  Date_Format(Min(aqorders.entrydate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders.entrydate), "%Y - %m - %d") AS NEWEST
FROM aqorders
UNION
SELECT
  Concat("aqorders") AS TYPE,
  Concat("datereceived") AS Column1,
  Date_Format(Min(aqorders.datereceived), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders.datereceived), "%Y - %m - %d") AS NEWEST
FROM aqorders
UNION
SELECT
  Concat("aqorders") AS TYPE,
  Concat("datecancellationprinted") AS Column1,
  Date_Format(Min(aqorders.datecancellationprinted), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders.datecancellationprinted), "%Y - %m - %d") AS NEWEST
FROM aqorders
UNION
SELECT
  Concat("aqorders") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(aqorders.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders.timestamp), "%Y - %m - %d") AS NEWEST
FROM aqorders
UNION
SELECT
  Concat("aqorders") AS TYPE,
  Concat("budgetdate") AS Column1,
  Date_Format(Min(aqorders.budgetdate), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders.budgetdate), "%Y - %m - %d") AS NEWEST
FROM aqorders
UNION
SELECT
  Concat("aqorders_claims") AS TYPE,
  Concat("claimed_on") AS Column1,
  Date_Format(Min(aqorders_claims.claimed_on), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders_claims.claimed_on), "%Y - %m - %d") AS NEWEST
FROM aqorders_claims
UNION
SELECT
  Concat("aqorders_items") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(aqorders_items.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders_items.timestamp), "%Y - %m - %d") AS NEWEST
FROM aqorders_items
UNION
SELECT
  Concat("aqorders_transfers") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(aqorders_transfers.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(aqorders_transfers.timestamp), "%Y - %m - %d") AS NEWEST
FROM aqorders_transfers
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("---") AS Column3,
  Concat("-") AS Column4
  UNION
SELECT
    Concat("ARTICLE_REQUESTS") AS Column1,
    Concat("ARTICLE_REQUESTS") AS Column2,
    Concat("ARTICLE_REQUESTS") AS Column3,
    Concat("ARTICLE_REQUESTS") AS Column4
UNION
SELECT
  Concat("article_requests") AS TYPE,
  Concat("created_on") AS BLANK,
  Date_Format(Min(article_requests.created_on), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(article_requests.created_on), "%Y - %m - %d") AS NEWEST
FROM article_requests
UNION
SELECT
  Concat("article_requests") AS TYPE,
  Concat("updated_on") AS BLANK,
  Date_Format(Min(article_requests.updated_on), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(article_requests.updated_on), "%Y - %m - %d") AS NEWEST
FROM article_requests
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("----") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("auth_header") AS TABLE_NAME,
  Concat("datecreated") AS SUB_FIELD,
  Date_Format(Min(auth_header.datecreated), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(auth_header.datecreated), "%Y - %m - %d") AS NEWEST
FROM auth_header
UNION
SELECT
  Concat("auth_header") AS TABLE_NAME,
  Concat("modification_time") AS SUB_FIELD,
  Date_Format(Min(auth_header.modification_time), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(auth_header.modification_time), "%Y - %m - %d") AS NEWEST
FROM auth_header
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("-----") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("-BIBLIO_RECORDS-") AS Column1,
  Concat("-BIBLIO_RECORDS-") AS Column2,
  Concat("-BIBLIO_RECORDS-") AS Column3,
  Concat("-BIBLIO_RECORDS-") AS Column4
UNION
SELECT
  Concat("biblio") AS TABLE_NAME,
  Concat("timestamp") AS SUB_FIELD,
  Date_Format(Min(biblio.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(biblio.timestamp), "%Y - %m - %d") AS NEWEST
FROM biblio
UNION
SELECT
  Concat("biblio") AS TABLE_NAME,
  Concat("datecreated") AS SUB_FIELD,
  Date_Format(Min(biblio.datecreated), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(biblio.datecreated), "%Y - %m - %d") AS NEWEST
FROM biblio
UNION
SELECT
  Concat("biblio_metadata") AS TABLE_NAME,
  Concat("timestamp") AS SUB_FIELD,
  Date_Format(Min(biblio_metadata.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(biblio_metadata.timestamp), "%Y - %m - %d") AS NEWEST
FROM biblio_metadata
UNION
SELECT
  Concat("biblioimages") AS TABLE_NAME,
  Concat("timestamp") AS SUB_FIELD,
  Date_Format(Min(biblioimages.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(biblioimages.timestamp), "%Y - %m - %d") AS NEWEST
FROM biblioimages
UNION
SELECT
  Concat("biblioitems") AS TABLE_NAME,
  Concat("timestamp") AS SUB_FIELD,
  Date_Format(Min(biblioitems.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(biblioitems.timestamp), "%Y - %m - %d") AS NEWEST
FROM biblioitems
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("------") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("-BORROWERS-") AS Column1,
  Concat("-BORROWERS-") AS Column2,
  Concat("-BORROWERS-") AS Column3,
  Concat("-BORROWERS-") AS Column4
UNION
SELECT
  Concat("borrower_debarments") AS TYPE,
  Concat("created") AS Column1,
  Date_Format(Min(borrower_debarments.created), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_debarments.created), "%Y - %m - %d") AS NEWEST
FROM borrower_debarments
UNION
SELECT
  Concat("borrower_debarments") AS TYPE,
  Concat("expiration") AS Column1,
  Date_Format(Min(borrower_debarments.expiration), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_debarments.expiration), "%Y - %m - %d") AS NEWEST
FROM borrower_debarments
UNION
SELECT
  Concat("borrower_debarments") AS TYPE,
  Concat("created") AS Column1,
  Date_Format(Min(borrower_debarments.created), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_debarments.created), "%Y - %m - %d") AS NEWEST
FROM borrower_debarments
UNION
SELECT
  Concat("borrower_debarments") AS TYPE,
  Concat("updated") AS Column1,
  Date_Format(Min(borrower_debarments.updated), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_debarments.updated), "%Y - %m - %d") AS NEWEST
FROM borrower_debarments
UNION
SELECT
  Concat("borrower_files") AS TYPE,
  Concat("date_uploaded") AS Column1,
  Date_Format(Min(borrower_files.date_uploaded), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_files.date_uploaded), "%Y - %m - %d") AS NEWEST
FROM borrower_files
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(borrower_modifications.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.timestamp), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("dateofbirth") AS Column1,
  Date_Format(Min(borrower_modifications.dateofbirth), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.dateofbirth), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("dateenrolled") AS Column1,
  Date_Format(Min(borrower_modifications.dateenrolled), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.dateenrolled), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("dateexpiry") AS Column1,
  Date_Format(Min(borrower_modifications.dateexpiry), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.dateexpiry), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("date_renewed") AS Column1,
  Date_Format(Min(borrower_modifications.date_renewed), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.date_renewed), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("debarred") AS Column1,
  Date_Format(Min(borrower_modifications.debarred), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.debarred), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_modifications") AS TYPE,
  Concat("gdpr_proc_consent") AS Column1,
  Date_Format(Min(borrower_modifications.gdpr_proc_consent), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_modifications.gdpr_proc_consent), "%Y - %m - %d") AS NEWEST
FROM borrower_modifications
UNION
SELECT
  Concat("borrower_password_recovery") AS TYPE,
  Concat("valid_until") AS Column1,
  Date_Format(Min(borrower_password_recovery.valid_until), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrower_password_recovery.valid_until), "%Y - %m - %d") AS NEWEST
FROM borrower_password_recovery
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("dateofbirth") AS Column1,
  Date_Format(Min(borrowers.dateofbirth), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.dateofbirth), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("dateenrolled") AS Column1,
  Date_Format(Min(borrowers.dateenrolled), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.dateenrolled), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("dateexpiry") AS Column1,
  Date_Format(Min(borrowers.dateexpiry), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.dateexpiry), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("date_renewed") AS Column1,
  Date_Format(Min(borrowers.date_renewed), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.date_renewed), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("debarred") AS Column1,
  Date_Format(Min(borrowers.debarred), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.debarred), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("updated_on") AS Column1,
  Date_Format(Min(borrowers.updated_on), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.updated_on), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("borrowers") AS TYPE,
  Concat("lastseen") AS Column1,
  Date_Format(Min(borrowers.lastseen), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(borrowers.lastseen), "%Y - %m - %d") AS NEWEST
FROM borrowers
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("0") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("-BRANCHTRANSFERS-") AS Column1,
  Concat("-BRANCHTRANSFERS-") AS Column2,
  Concat("-BRANCHTRANSFERS-") AS Column3,
  Concat("-BRANCHTRANSFERS-") AS Column4
UNION
SELECT
  Concat("branchtransfers") AS TYPE,
  Concat("datesent") AS Column1,
  Date_Format(Min(branchtransfers.datesent), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(branchtransfers.datesent), "%Y - %m - %d") AS NEWEST
FROM branchtransfers
UNION
SELECT
  Concat("branchtransfers") AS TYPE,
  Concat("datearrived") AS Column1,
  Date_Format(Min(branchtransfers.datearrived), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(branchtransfers.datearrived), "%Y - %m - %d") AS NEWEST
FROM branchtransfers
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("*") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("cash_register_actions") AS TYPE,
  Concat("timestamp") AS Column1,
  Date_Format(Min(cash_register_actions.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(cash_register_actions.timestamp), "%Y - %m - %d") AS NEWEST
FROM cash_register_actions
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("**") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("course_items") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(course_items.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(course_items.timestamp), "%Y - %m - %d") AS NEWEST
FROM course_items
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("***") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("course_reserves") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(course_reserves.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(course_reserves.timestamp), "%Y - %m - %d") AS NEWEST
FROM course_reserves
UNION
SELECT
  Concat("-") AS Column1,
  Concat("-") AS Column2,
  Concat("****") AS Column3,
  Concat("-") AS Column4
UNION
SELECT
  Concat("statistics") AS TYPE,
  statistics.type AS type1,
  Date_Format(Min(statistics.datetime), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(statistics.datetime), "%Y - %m - %d") AS NEWEST
FROM statistics
GROUP BY statistics.type
UNION
SELECT
  Concat("old_issues") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(old_issues.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(old_issues.timestamp), "%Y - %m - %d") AS NEWEST
FROM old_issues
UNION
SELECT
  Concat("old_reserves") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(old_reserves.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(old_reserves.timestamp), "%Y - %m - %d") AS NEWEST
FROM old_reserves
UNION
SELECT
  Concat("deleted_biblio") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(deletedbiblio.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(deletedbiblio.timestamp), "%Y - %m - %d") AS NEWEST
FROM deletedbiblio
UNION
SELECT
  Concat("deleteditems") AS TYPE,
  Concat("") AS Column1,
  Date_Format(Min(deleteditems.timestamp), "%Y - %m - %d") AS OLDEST,
  Date_Format(Max(deleteditems.timestamp), "%Y - %m - %d") AS NEWEST
FROM deleteditems

























