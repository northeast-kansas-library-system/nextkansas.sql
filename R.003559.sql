/*
R.003559

----------

Name: GHW - All Koha date fields with oldest and newest dates
Created by: George H Williams

----------

Group: -
     -

Created on: 2021-09-13 20:55:02
Modified on: 2021-09-17 17:01:37
Date last run: 2021-10-26 13:47:22

----------

Public: 0
Expiry: 300

----------

<div id=reportinfo class=noprint>
<p>Lists every date and timestamp field in every table in Koha and shows the oldest and newest dates.</p>
<p>Some dates are further grouped by other field values.</p>
<p>Used at the koha-US 2021 conference</p>
</div>

----------
*/



SELECT
  Concat('Borrower fees') AS _GROUP_,
  Concat('====================') AS TABLE_NAME,
  Concat('====================') AS SUBFIELD,
  Concat('====================') AS TYPE,
  Concat('====================') AS OLDEST,
  Concat('====================') AS NEWEST
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('account_offsets') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  account_offsets.type AS TYPE,
  Date_Format(Min(account_offsets.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(account_offsets.created_on), '%Y - %m - %d') AS NEWEST
FROM
  account_offsets
GROUP BY
  account_offsets.type
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('accountlines') AS TABLE_NAME,
  Concat('date') AS SUBFIELD,
  accountlines.credit_type_code AS TYPE,
  Date_Format(Min(accountlines.date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(accountlines.date), '%Y - %m - %d') AS NEWEST
FROM
  accountlines
GROUP BY
  accountlines.credit_type_code
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('accountlines') AS TABLE_NAME,
  Concat('date') AS SUBFIELD,
  accountlines.debit_type_code AS TYPE,
  Date_Format(Min(accountlines.date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(accountlines.date), '%Y - %m - %d') AS NEWEST
FROM
  accountlines
GROUP BY
  accountlines.debit_type_code
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('accountlines') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  accountlines.credit_type_code AS TYPE,
  Date_Format(Min(accountlines.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(accountlines.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  accountlines
GROUP BY
  accountlines.credit_type_code
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('accountlines') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  accountlines.debit_type_code AS TYPE,
  Date_Format(Min(accountlines.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(accountlines.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  accountlines
GROUP BY
  accountlines.debit_type_code
UNION
SELECT
  Concat('Action logs') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('action_logs') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  action_logs.module AS TYPE,
  Date_Format(Min(action_logs.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(action_logs.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  action_logs
GROUP BY
  action_logs.module
UNION
SELECT
  Concat('Acquisitions') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqbasket') AS TABLE_NAME,
  Concat('closedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqbasket.closedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqbasket.closedate), '%Y - %m - %d') AS NEWEST
FROM
  aqbasket
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqbasket') AS TABLE_NAME,
  Concat('creationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqbasket.creationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqbasket.creationdate), '%Y - %m - %d') AS NEWEST
FROM
  aqbasket
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqbudgetperiods') AS TABLE_NAME,
  Concat('budget_period_enddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqbudgetperiods.budget_period_enddate), '%Y - %m - %d') AS
  OLDEST,
  Date_Format(Max(aqbudgetperiods.budget_period_enddate), '%Y - %m - %d') AS
  NEWEST
FROM
  aqbudgetperiods
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqbudgetperiods') AS TABLE_NAME,
  Concat('budget_period_startdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqbudgetperiods.budget_period_startdate), '%Y - %m - %d') AS
  OLDEST,
  Date_Format(Max(aqbudgetperiods.budget_period_startdate), '%Y - %m - %d') AS
  NEWEST
FROM
  aqbudgetperiods
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqbudgets') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqbudgets.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqbudgets.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  aqbudgets
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqcontract') AS TABLE_NAME,
  Concat('contractenddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqcontract.contractenddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqcontract.contractenddate), '%Y - %m - %d') AS NEWEST
FROM
  aqcontract
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqcontract') AS TABLE_NAME,
  Concat('contractstartdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqcontract.contractstartdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqcontract.contractstartdate), '%Y - %m - %d') AS NEWEST
FROM
  aqcontract
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqinvoice_adjustments') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqinvoice_adjustments.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqinvoice_adjustments.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  aqinvoice_adjustments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqinvoices') AS TABLE_NAME,
  Concat('billingdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqinvoices.billingdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqinvoices.billingdate), '%Y - %m - %d') AS NEWEST
FROM
  aqinvoices
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqinvoices') AS TABLE_NAME,
  Concat('closedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqinvoices.closedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqinvoices.closedate), '%Y - %m - %d') AS NEWEST
FROM
  aqinvoices
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqinvoices') AS TABLE_NAME,
  Concat('shipmentdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqinvoices.shipmentdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqinvoices.shipmentdate), '%Y - %m - %d') AS NEWEST
FROM
  aqinvoices
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders') AS TABLE_NAME,
  Concat('budgetdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders.budgetdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders.budgetdate), '%Y - %m - %d') AS NEWEST
FROM
  aqorders
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders') AS TABLE_NAME,
  Concat('datecancellationprinted') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders.datecancellationprinted), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders.datecancellationprinted), '%Y - %m - %d') AS NEWEST
FROM
  aqorders
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders') AS TABLE_NAME,
  Concat('datereceived') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders.datereceived), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders.datereceived), '%Y - %m - %d') AS NEWEST
FROM
  aqorders
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders') AS TABLE_NAME,
  Concat('entrydate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders.entrydate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders.entrydate), '%Y - %m - %d') AS NEWEST
FROM
  aqorders
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  aqorders
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders_claims') AS TABLE_NAME,
  Concat('claimed_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders_claims.claimed_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders_claims.claimed_on), '%Y - %m - %d') AS NEWEST
FROM
  aqorders_claims
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders_items') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders_items.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders_items.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  aqorders_items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('aqorders_transfers') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(aqorders_transfers.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(aqorders_transfers.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  aqorders_transfers
UNION
SELECT
  Concat('Article requests') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('article_requests') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(article_requests.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(article_requests.created_on), '%Y - %m - %d') AS NEWEST
FROM
  article_requests
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('article_requests') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(article_requests.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(article_requests.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  article_requests
UNION
SELECT
  Concat('Authorities') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('auth_header') AS TABLE_NAME,
  Concat('datecreated') AS SUBFIELD,
  auth_header.authtypecode AS TYPE,
  Date_Format(Min(auth_header.datecreated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(auth_header.datecreated), '%Y - %m - %d') AS NEWEST
FROM
  auth_header
GROUP BY
  auth_header.authtypecode
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('auth_header') AS TABLE_NAME,
  Concat('modification_time') AS SUBFIELD,
  auth_header.authtypecode AS TYPE,
  Date_Format(Min(auth_header.modification_time), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(auth_header.modification_time), '%Y - %m - %d') AS NEWEST
FROM
  auth_header
GROUP BY
  auth_header.authtypecode
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('need_merge_authorities') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(need_merge_authorities.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(need_merge_authorities.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  need_merge_authorities
UNION
SELECT
  Concat('Biblios') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblio') AS TABLE_NAME,
  Concat('datecreated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblio.datecreated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblio.datecreated), '%Y - %m - %d') AS NEWEST
FROM
  biblio
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblio') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblio.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblio.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  biblio
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblio_metadata') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblio_metadata.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblio_metadata.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  biblio_metadata
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblioimages') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblioimages.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblioimages.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  biblioimages
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblioitems') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblioitems.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblioitems.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  biblioitems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('biblioitems') AS TABLE_NAME,
  Concat('volumedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(biblioitems.volumedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(biblioitems.volumedate), '%Y - %m - %d') AS NEWEST
FROM
  biblioitems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedbiblio') AS TABLE_NAME,
  Concat('datecreated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedbiblio.datecreated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedbiblio.datecreated), '%Y - %m - %d') AS NEWEST
FROM
  deletedbiblio
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedbiblio') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedbiblio.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedbiblio.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  deletedbiblio
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedbiblio_metadata') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedbiblio_metadata.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedbiblio_metadata.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  deletedbiblio_metadata
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedbiblioitems') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedbiblioitems.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedbiblioitems.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  deletedbiblioitems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedbiblioitems') AS TABLE_NAME,
  Concat('volumedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedbiblioitems.volumedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedbiblioitems.volumedate), '%Y - %m - %d') AS NEWEST
FROM
  deletedbiblioitems
UNION
SELECT
  Concat('Borrowers') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_debarments') AS TABLE_NAME,
  Concat('created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_debarments.created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_debarments.created), '%Y - %m - %d') AS NEWEST
FROM
  borrower_debarments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_debarments') AS TABLE_NAME,
  Concat('expiration') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_debarments.expiration), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_debarments.expiration), '%Y - %m - %d') AS NEWEST
FROM
  borrower_debarments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_debarments') AS TABLE_NAME,
  Concat('updated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_debarments.updated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_debarments.updated), '%Y - %m - %d') AS NEWEST
FROM
  borrower_debarments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_files') AS TABLE_NAME,
  Concat('date_uploaded') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_files.date_uploaded), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_files.date_uploaded), '%Y - %m - %d') AS NEWEST
FROM
  borrower_files
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('date_renewed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.date_renewed), '%Y - %m - %d') AS
  OLDEST,
  Date_Format(Max(borrower_modifications.date_renewed), '%Y - %m - %d') AS
  NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('dateenrolled') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.dateenrolled), '%Y - %m - %d') AS
  OLDEST,
  Date_Format(Max(borrower_modifications.dateenrolled), '%Y - %m - %d') AS
  NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('dateexpiry') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.dateexpiry), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_modifications.dateexpiry), '%Y - %m - %d') AS NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('dateofbirth') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.dateofbirth), '%Y - %m - %d')
  AS OLDEST,
  Date_Format(Max(borrower_modifications.dateofbirth), '%Y - %m - %d') AS NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('debarred') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.debarred), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_modifications.debarred), '%Y - %m - %d') AS NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('gdpr_proc_consent') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.gdpr_proc_consent), '%Y - %m - %d') AS
  OLDEST,
  Date_Format(Max(borrower_modifications.gdpr_proc_consent), '%Y - %m - %d') AS
  NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_modifications') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_modifications.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_modifications.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  borrower_modifications
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrower_password_recovery') AS TABLE_NAME,
  Concat('valid_until') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrower_password_recovery.valid_until), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrower_password_recovery.valid_until), '%Y - %m - %d') AS NEWEST
FROM
  borrower_password_recovery
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('date_renewed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.date_renewed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.date_renewed), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('dateenrolled') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.dateenrolled), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.dateenrolled), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('dateexpiry') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.dateexpiry), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.dateexpiry), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('dateofbirth') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.dateofbirth), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.dateofbirth), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('debarred') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.debarred), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.debarred), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('lastseen') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.lastseen), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.lastseen), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('borrowers') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(borrowers.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(borrowers.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  borrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('date_renewed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.date_renewed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.date_renewed), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('dateenrolled') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.dateenrolled), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.dateenrolled), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('dateexpiry') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.dateexpiry), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.dateexpiry), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('dateofbirth') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.dateofbirth), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.dateofbirth), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('debarred') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.debarred), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.debarred), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('lastseen') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.lastseen), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.lastseen), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deletedborrowers') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deletedborrowers.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deletedborrowers.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  deletedborrowers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('messages') AS TABLE_NAME,
  Concat('message_date') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(messages.message_date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(messages.message_date), '%Y - %m - %d') AS NEWEST
FROM
  messages
UNION
SELECT
  Concat('Transfers') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('branchtransfers') AS TABLE_NAME,
  Concat('datearrived') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(branchtransfers.datearrived), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(branchtransfers.datearrived), '%Y - %m - %d') AS NEWEST
FROM
  branchtransfers
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('branchtransfers') AS TABLE_NAME,
  Concat('datesent') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(branchtransfers.datesent), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(branchtransfers.datesent), '%Y - %m - %d') AS NEWEST
FROM
  branchtransfers
UNION
SELECT
  Concat('Cash register') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('cash_register_actions') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(cash_register_actions.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(cash_register_actions.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  cash_register_actions
UNION
SELECT
  Concat('Borrower categories') AS _GROUP_,
  Concat(''),
  Concat(''),
  Concat(''),
  Concat(''),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('categories') AS TABLE_NAME,
  Concat('enrolmentperioddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(categories.enrolmentperioddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(categories.enrolmentperioddate), '%Y - %m - %d') AS NEWEST
FROM
  categories
UNION
SELECT
  Concat('Clubs') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_enrollments') AS TABLE_NAME,
  Concat('date_canceled') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_enrollments.date_canceled), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_enrollments.date_canceled), '%Y - %m - %d') AS NEWEST
FROM
  club_enrollments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_enrollments') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_enrollments.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_enrollments.date_created), '%Y - %m - %d') AS NEWEST
FROM
  club_enrollments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_enrollments') AS TABLE_NAME,
  Concat('date_enrolled') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_enrollments.date_enrolled), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_enrollments.date_enrolled), '%Y - %m - %d') AS NEWEST
FROM
  club_enrollments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_enrollments') AS TABLE_NAME,
  Concat('date_updated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_enrollments.date_updated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_enrollments.date_updated), '%Y - %m - %d') AS NEWEST
FROM
  club_enrollments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_holds') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_holds.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_holds.date_created), '%Y - %m - %d') AS NEWEST
FROM
  club_holds
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_templates') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_templates.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_templates.date_created), '%Y - %m - %d') AS NEWEST
FROM
  club_templates
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('club_templates') AS TABLE_NAME,
  Concat('date_updated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(club_templates.date_updated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(club_templates.date_updated), '%Y - %m - %d') AS NEWEST
FROM
  club_templates
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('clubs') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(clubs.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(clubs.date_created), '%Y - %m - %d') AS NEWEST
FROM
  clubs
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('clubs') AS TABLE_NAME,
  Concat('date_end') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(clubs.date_end), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(clubs.date_end), '%Y - %m - %d') AS NEWEST
FROM
  clubs
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('clubs') AS TABLE_NAME,
  Concat('date_start') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(clubs.date_start), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(clubs.date_start), '%Y - %m - %d') AS NEWEST
FROM
  clubs
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('clubs') AS TABLE_NAME,
  Concat('date_updated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(clubs.date_updated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(clubs.date_updated), '%Y - %m - %d') AS NEWEST
FROM
  clubs
UNION
SELECT
  Concat('Course reserves') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('course_items') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(course_items.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(course_items.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  course_items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('course_reserves') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(course_reserves.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(course_reserves.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  course_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('courses') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(courses.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(courses.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  courses
UNION
SELECT
  Concat('Label and card creator') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('creator_batches') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(creator_batches.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(creator_batches.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  creator_batches
UNION
SELECT
  Concat('Currency') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('currency') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(currency.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(currency.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  currency
UNION
SELECT
  Concat('Items') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('damaged_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.damaged_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.damaged_on), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('dateaccessioned') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.dateaccessioned), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.dateaccessioned), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('datelastborrowed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.datelastborrowed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.datelastborrowed), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('datelastseen') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.datelastseen), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.datelastseen), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('itemlost_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.itemlost_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.itemlost_on), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('onloan') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.onloan), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.onloan), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('replacementpricedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.replacementpricedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.replacementpricedate), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items') AS TABLE_NAME,
  Concat('withdrawn_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items.withdrawn_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items.withdrawn_on), '%Y - %m - %d') AS NEWEST
FROM
  items
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('damaged_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.damaged_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.damaged_on), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('dateaccessioned') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.dateaccessioned), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.dateaccessioned), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('datelastborrowed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.datelastborrowed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.datelastborrowed), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('datelastseen') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.datelastseen), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.datelastseen), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('itemlost_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.itemlost_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.itemlost_on), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('onloan') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.onloan), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.onloan), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('replacementpricedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.replacementpricedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.replacementpricedate), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('deleteditems') AS TABLE_NAME,
  Concat('withdrawn_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(deleteditems.withdrawn_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(deleteditems.withdrawn_on), '%Y - %m - %d') AS NEWEST
FROM
  deleteditems
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('items_last_borrower') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(items_last_borrower.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(items_last_borrower.created_on), '%Y - %m - %d') AS NEWEST
FROM
  items_last_borrower
UNION
SELECT
  Concat('Discharges') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('discharges') AS TABLE_NAME,
  Concat('needed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(discharges.needed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(discharges.needed), '%Y - %m - %d') AS NEWEST
FROM
  discharges
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('discharges') AS TABLE_NAME,
  Concat('validated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(discharges.validated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(discharges.validated), '%Y - %m - %d') AS NEWEST
FROM
  discharges
UNION
SELECT
  Concat('EDI messages') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('edifact_messages') AS TABLE_NAME,
  Concat('transfer_date') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(edifact_messages.transfer_date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(edifact_messages.transfer_date), '%Y - %m - %d') AS NEWEST
FROM
  edifact_messages
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('vendor_edi_accounts') AS TABLE_NAME,
  Concat('last_activity') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(vendor_edi_accounts.last_activity), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(vendor_edi_accounts.last_activity), '%Y - %m - %d') AS NEWEST
FROM
  vendor_edi_accounts
UNION
SELECT
  Concat('Housebound module') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('housebound_visit') AS TABLE_NAME,
  Concat('appointment_date') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(housebound_visit.appointment_date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(housebound_visit.appointment_date), '%Y - %m - %d') AS NEWEST
FROM
  housebound_visit
UNION
SELECT
  Concat('ILL module') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('illcomments') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(illcomments.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(illcomments.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  illcomments
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('illrequests') AS TABLE_NAME,
  Concat('completed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(illrequests.completed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(illrequests.completed), '%Y - %m - %d') AS NEWEST
FROM
  illrequests
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('illrequests') AS TABLE_NAME,
  Concat('placed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(illrequests.placed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(illrequests.placed), '%Y - %m - %d') AS NEWEST
FROM
  illrequests
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('illrequests') AS TABLE_NAME,
  Concat('replied') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(illrequests.replied), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(illrequests.replied), '%Y - %m - %d') AS NEWEST
FROM
  illrequests
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('illrequests') AS TABLE_NAME,
  Concat('updated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(illrequests.updated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(illrequests.updated), '%Y - %m - %d') AS NEWEST
FROM
  illrequests
UNION
SELECT
  Concat('Cataloging') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('import_batches') AS TABLE_NAME,
  Concat('upload_timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(import_batches.upload_timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(import_batches.upload_timestamp), '%Y - %m - %d') AS NEWEST
FROM
  import_batches
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('import_records') AS TABLE_NAME,
  Concat('import_date') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(import_records.import_date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(import_records.import_date), '%Y - %m - %d') AS NEWEST
FROM
  import_records
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('import_records') AS TABLE_NAME,
  Concat('upload_timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(import_records.upload_timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(import_records.upload_timestamp), '%Y - %m - %d') AS NEWEST
FROM
  import_records
UNION
SELECT
  Concat('Circulation') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('statistics') AS TABLE_NAME,
  Concat('datetime') AS SUBFIELD,
  statistics.type AS TYPE,
  Date_Format(Min(statistics.datetime), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(statistics.datetime), '%Y - %m - %d') AS NEWEST
FROM
  statistics
GROUP BY
  statistics.type
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('date_due') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.date_due), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.date_due), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('issuedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.issuedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.issuedate), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('lastreneweddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.lastreneweddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.lastreneweddate), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('notedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.notedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.notedate), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('returndate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.returndate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.returndate), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('issues') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(issues.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(issues.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('date_due') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.date_due), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.date_due), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('issuedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.issuedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.issuedate), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('lastreneweddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.lastreneweddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.lastreneweddate), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('notedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.notedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.notedate), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('returndate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.returndate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.returndate), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_issues') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_issues.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_issues.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  old_issues
UNION
SELECT
  Concat('Language') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('language_subtag_registry') AS TABLE_NAME,
  Concat('added') AS SUBFIELD,
  language_subtag_registry.type AS TYPE,
  Date_Format(Min(language_subtag_registry.added), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(language_subtag_registry.added), '%Y - %m - %d') AS NEWEST
FROM
  language_subtag_registry
GROUP BY
  language_subtag_registry.type
UNION
SELECT
  Concat('Library groups') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('library_groups') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(library_groups.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(library_groups.created_on), '%Y - %m - %d') AS NEWEST
FROM
  library_groups
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('library_groups') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(library_groups.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(library_groups.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  library_groups
UNION
SELECT
  Concat('Link tracker') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('linktracker') AS TABLE_NAME,
  Concat('timeclicked') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(linktracker.timeclicked), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(linktracker.timeclicked), '%Y - %m - %d') AS NEWEST
FROM
  linktracker
UNION
SELECT
  Concat('Letters and e-mail') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('message_queue') AS TABLE_NAME,
  Concat('time_queued') AS SUBFIELD,
  message_queue.letter_code AS TYPE,
  Date_Format(Min(message_queue.time_queued), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(message_queue.time_queued), '%Y - %m - %d') AS NEWEST
FROM
  message_queue
GROUP BY
  message_queue.letter_code
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('message_queue') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  message_queue.letter_code AS TYPE,
  Date_Format(Min(message_queue.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(message_queue.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  message_queue
GROUP BY
  message_queue.letter_code
UNION
SELECT
  Concat('Files') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('misc_files') AS TABLE_NAME,
  Concat('date_uploaded') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(misc_files.date_uploaded), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(misc_files.date_uploaded), '%Y - %m - %d') AS NEWEST
FROM
  misc_files
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('uploaded_files') AS TABLE_NAME,
  Concat('dtcreated') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(uploaded_files.dtcreated), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(uploaded_files.dtcreated), '%Y - %m - %d') AS NEWEST
FROM
  uploaded_files
UNION
SELECT
  Concat('Requests') AS _GROUP_,
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('===================='),
  Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('tmp_holdsqueue') AS TABLE_NAME,
  Concat('reservedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(tmp_holdsqueue.reservedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(tmp_holdsqueue.reservedate), '%Y - %m - %d') AS NEWEST
FROM
  tmp_holdsqueue
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('cancellationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.cancellationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.cancellationdate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('expirationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.expirationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.expirationdate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('notificationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.notificationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.notificationdate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('reminderdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.reminderdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.reminderdate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('reservedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.reservedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.reservedate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('suspend_until') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.suspend_until), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.suspend_until), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reserves') AS TABLE_NAME,
  Concat('waitingdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reserves.waitingdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reserves.waitingdate), '%Y - %m - %d') AS NEWEST
FROM
  reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('cancellationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.cancellationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.cancellationdate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('expirationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.expirationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.expirationdate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('notificationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.notificationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.notificationdate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('reminderdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.reminderdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.reminderdate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('reservedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.reservedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.reservedate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('suspend_until') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.suspend_until), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.suspend_until), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('old_reserves') AS TABLE_NAME,
  Concat('waitingdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(old_reserves.waitingdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(old_reserves.waitingdate), '%Y - %m - %d') AS NEWEST
FROM
  old_reserves
UNION
  SELECT
    Concat('Opac news') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('opac_news') AS TABLE_NAME,
  Concat('expirationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(opac_news.expirationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(opac_news.expirationdate), '%Y - %m - %d') AS NEWEST
FROM
  opac_news
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('opac_news') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(opac_news.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(opac_news.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  opac_news
UNION
  SELECT
    Concat('Privacy') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('patron_consent') AS TABLE_NAME,
  Concat('given_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(patron_consent.given_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(patron_consent.given_on), '%Y - %m - %d') AS NEWEST
FROM
  patron_consent
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('patron_consent') AS TABLE_NAME,
  Concat('refused_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(patron_consent.refused_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(patron_consent.refused_on), '%Y - %m - %d') AS NEWEST
FROM
  patron_consent
UNION
  SELECT
    Concat('Offline transactions') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('pending_offline_operations') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  pending_offline_operations.action AS TYPE,
  Date_Format(Min(pending_offline_operations.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(pending_offline_operations.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  pending_offline_operations
GROUP BY
  pending_offline_operations.action
UNION
  SELECT
    Concat('Problem reports') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('problem_reports') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  problem_reports.status AS TYPE,
  Date_Format(Min(problem_reports.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(problem_reports.created_on), '%Y - %m - %d') AS NEWEST
FROM
  problem_reports
GROUP BY
  problem_reports.status
UNION
  SELECT
    Concat('Quote of the day') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('quotes') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(quotes.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(quotes.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  quotes
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('quotes') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(quotes.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(quotes.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  quotes
UNION
  SELECT
    Concat('OPAC Ratings, reviews, and tags') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('ratings') AS TABLE_NAME,
  Concat('timestamp') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(ratings.timestamp), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(ratings.timestamp), '%Y - %m - %d') AS NEWEST
FROM
  ratings
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reviews') AS TABLE_NAME,
  Concat('datereviewed') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(reviews.datereviewed), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reviews.datereviewed), '%Y - %m - %d') AS NEWEST
FROM
  reviews
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('tags_all') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(tags_all.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(tags_all.date_created), '%Y - %m - %d') AS NEWEST
FROM
  tags_all
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('tags_approval') AS TABLE_NAME,
  Concat('date_approved') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(tags_approval.date_approved), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(tags_approval.date_approved), '%Y - %m - %d') AS NEWEST
FROM
  tags_approval
UNION
  SELECT
    Concat('Reports') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reports_dictionary') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  reports_dictionary.report_area AS TYPE,
  Date_Format(Min(reports_dictionary.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reports_dictionary.date_created), '%Y - %m - %d') AS NEWEST
FROM
  reports_dictionary
GROUP BY
  reports_dictionary.report_area
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('reports_dictionary') AS TABLE_NAME,
  Concat('date_modified') AS SUBFIELD,
  reports_dictionary.report_area AS TYPE,
  Date_Format(Min(reports_dictionary.date_modified), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(reports_dictionary.date_modified), '%Y - %m - %d') AS NEWEST
FROM
  reports_dictionary
GROUP BY
  reports_dictionary.report_area
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('saved_reports') AS TABLE_NAME,
  Concat('date_run') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(saved_reports.date_run), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(saved_reports.date_run), '%Y - %m - %d') AS NEWEST
FROM
  saved_reports
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('saved_sql') AS TABLE_NAME,
  Concat('date_created') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(saved_sql.date_created), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(saved_sql.date_created), '%Y - %m - %d') AS NEWEST
FROM
  saved_sql
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('saved_sql') AS TABLE_NAME,
  Concat('last_modified') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(saved_sql.last_modified), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(saved_sql.last_modified), '%Y - %m - %d') AS NEWEST
FROM
  saved_sql
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('saved_sql') AS TABLE_NAME,
  Concat('last_run') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(saved_sql.last_run), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(saved_sql.last_run), '%Y - %m - %d') AS NEWEST
FROM
  saved_sql
UNION
  SELECT
    Concat('Claims returned') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('return_claims') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(return_claims.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(return_claims.created_on), '%Y - %m - %d') AS NEWEST
FROM
  return_claims
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('return_claims') AS TABLE_NAME,
  Concat('resolved_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(return_claims.resolved_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(return_claims.resolved_on), '%Y - %m - %d') AS NEWEST
FROM
  return_claims
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('return_claims') AS TABLE_NAME,
  Concat('updated_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(return_claims.updated_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(return_claims.updated_on), '%Y - %m - %d') AS NEWEST
FROM
  return_claims
UNION
  SELECT
    Concat('OPAC search history') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('search_history') AS TABLE_NAME,
  Concat('time') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(search_history.time), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(search_history.time), '%Y - %m - %d') AS NEWEST
FROM
  search_history
UNION
  SELECT
    Concat('Serials') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('serial') AS TABLE_NAME,
  Concat('claimdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(serial.claimdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(serial.claimdate), '%Y - %m - %d') AS NEWEST
FROM
  serial
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('serial') AS TABLE_NAME,
  Concat('planneddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(serial.planneddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(serial.planneddate), '%Y - %m - %d') AS NEWEST
FROM
  serial
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('serial') AS TABLE_NAME,
  Concat('publisheddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(serial.publisheddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(serial.publisheddate), '%Y - %m - %d') AS NEWEST
FROM
  serial
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscription') AS TABLE_NAME,
  Concat('enddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscription.enddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscription.enddate), '%Y - %m - %d') AS NEWEST
FROM
  subscription
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscription') AS TABLE_NAME,
  Concat('firstacquidate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscription.firstacquidate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscription.firstacquidate), '%Y - %m - %d') AS NEWEST
FROM
  subscription
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscription') AS TABLE_NAME,
  Concat('reneweddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscription.reneweddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscription.reneweddate), '%Y - %m - %d') AS NEWEST
FROM
  subscription
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscription') AS TABLE_NAME,
  Concat('startdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscription.startdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscription.startdate), '%Y - %m - %d') AS NEWEST
FROM
  subscription
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscriptionhistory') AS TABLE_NAME,
  Concat('histenddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscriptionhistory.histenddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscriptionhistory.histenddate), '%Y - %m - %d') AS NEWEST
FROM
  subscriptionhistory
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('subscriptionhistory') AS TABLE_NAME,
  Concat('histstartdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(subscriptionhistory.histstartdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(subscriptionhistory.histstartdate), '%Y - %m - %d') AS NEWEST
FROM
  subscriptionhistory
UNION
  SELECT
    Concat('Purchase suggestions') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('accepteddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.accepteddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.accepteddate), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('date') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.date), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.date), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('lastmodificationdate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.lastmodificationdate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.lastmodificationdate), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('manageddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.manageddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.manageddate), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('rejecteddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.rejecteddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.rejecteddate), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('suggestions') AS TABLE_NAME,
  Concat('suggesteddate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(suggestions.suggesteddate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(suggestions.suggesteddate), '%Y - %m - %d') AS NEWEST
FROM
  suggestions
UNION
  SELECT
    Concat('Lists') AS _GROUP_,
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('===================='),
    Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('virtualshelfcontents') AS TABLE_NAME,
  Concat('dateadded') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(virtualshelfcontents.dateadded), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(virtualshelfcontents.dateadded), '%Y - %m - %d') AS NEWEST
FROM
  virtualshelfcontents
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('virtualshelfshares') AS TABLE_NAME,
  Concat('sharedate') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(virtualshelfshares.sharedate), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(virtualshelfshares.sharedate), '%Y - %m - %d') AS NEWEST
FROM
  virtualshelfshares
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('virtualshelves') AS TABLE_NAME,
  Concat('created_on') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(virtualshelves.created_on), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(virtualshelves.created_on), '%Y - %m - %d') AS NEWEST
FROM
  virtualshelves
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('virtualshelves') AS TABLE_NAME,
  Concat('lastmodified') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(virtualshelves.lastmodified), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(virtualshelves.lastmodified), '%Y - %m - %d') AS NEWEST
FROM
  virtualshelves
  UNION
    SELECT
      Concat('Zebra') AS _GROUP_,
      Concat('===================='),
      Concat('===================='),
      Concat('===================='),
      Concat('===================='),
      Concat('====================')
UNION
SELECT
  Concat('') AS _GROUP_,
  Concat('zebraqueue') AS TABLE_NAME,
  Concat('time') AS SUBFIELD,
  Concat('') AS TYPE,
  Date_Format(Min(zebraqueue.time), '%Y - %m - %d') AS OLDEST,
  Date_Format(Max(zebraqueue.time), '%Y - %m - %d') AS NEWEST
FROM
  zebraqueue

















