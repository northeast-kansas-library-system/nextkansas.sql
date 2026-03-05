/*
R.003853

----------

Name: System Preference List
Created by: George Williams

----------

Group: -
     -

Created on: 2024-07-19 16:56:54
Modified on: 2024-07-19 16:56:54
Date last run: 2024-07-19 17:03:16

----------

Public: 0
Expiry: 300

----------



----------
*/



SELECT
  CASE
    WHEN
      userflags.bit = 2
    THEN
      'Staff access, allows viewing of catalogue in staff interface (catalogue)'
    WHEN
      userflags.bit = 3
    THEN 'Manage Koha system settings (Administration panel) (parameters)'
    WHEN
      userflags.bit = 4
    THEN 'Add, modify and view patron information (borrowers)'
    WHEN
      userflags.bit = 5
    THEN 'Set user permissions (permissions)'
    WHEN
      userflags.bit = 11
    THEN 'Acquisition management (acquisition)'
    WHEN
      userflags.bit = 12
    THEN 'Suggestions management (suggestions)'
    WHEN
      userflags.bit = 17
    THEN
      'Allow staff members to modify permissions, usernames, and passwords for other staff members (staffaccess)'
    WHEN
      userflags.bit = 22
    THEN Concat('C', 'reate and modify Interlibrary loan requests (ill)')
    WHEN
      userflags.bit = 26
    THEN 'OPAC problem reports management (problem_reports)'
    WHEN
      userflags.bit = 28
    THEN 'Manage the electronic resources module (erm)'
    WHEN
      userflags.bit = 29
    THEN Concat(userflags.flagdesc, ' (', userflags.flag, ')')
    WHEN
      userflags.bit = 30
    THEN 'Manage the preservation module (preservation)'
    ELSE Concat(userflags.flagdesc, ' (', userflags.flag, ')')
  END AS PERMISSION_GROUP,
  Concat('<br />', Group_Concat(CASE
    WHEN
      permissions.code = 'manage_curbside_pickups'
    THEN Concat('Manage curbside pickups (manage_curbside_pickups)')
    WHEN
      permissions.code = 'manage_additional_fields'
    THEN
      Concat('Manage additional fields (requires the corresponding permission, one of edit_subscription, order_manage, edit_invoices, or remaining_permissions under u', 'pdatecharges) (manage_additional_fields)')
    WHEN
      permissions.code = 'manage_auth_values'
    THEN
      Concat('Manage authorized value categories and authorized values (manage_auth_values)')
    WHEN
      permissions.code = 'manage_cash_registers'
    THEN Concat('Add, edit and archive cash registers (manage_cash_registers)')
    WHEN
      permissions.code = 'manage_circ_rules_from_any_libraries'
    THEN
      Concat('Manage circulation rules for any library. If not set the logged in user can only edit circulation rules for their own library (please note that manage_circ_rules is still required) (manage_circ_rules_from_any_libraries)')
    WHEN
      permissions.code = 'manage_classifications'
    THEN
      Concat('Manage classification sources and filing rules (manage_classifications)')
    WHEN
      permissions.code = 'manage_identity_providers'
    THEN Concat('Manage identity providers (manage_identity_providers)')
    WHEN
      permissions.code = 'manage_keyboard_shortcuts'
    THEN
      Concat('Manage keyboard shortcuts for the advanced cataloging editor (manage_keyboard_shortcuts)')
    WHEN
      permissions.code = 'manage_marc_frameworks'
    THEN
      Concat('Manage MARC bibliographic and authority frameworks and test them (manage_marc_frameworks)')
    WHEN
      permissions.code = 'override_renewals'
    THEN Concat('Override blocked renewals (override_renewals)')
    WHEN
      permissions.code = 'manage_search_filters'
    THEN Concat('Manage saved search filters (manage_search_filters)')
    WHEN
      permissions.code = 'manage_smtp_servers'
    THEN Concat('Manage SMTP servers (manage_smtp_servers)')
    WHEN
      permissions.code = 'parameters_remaining_permissions'
    THEN
      Concat('Remaining system parameters permissions (parameters_remaining_permissions)')
    WHEN
      permissions.code = 'delete_borrowers'
    THEN Concat('D', 'elete patrons (D', 'elete_borrowers)')
    WHEN
      permissions.code = 'view_borrower_infos_from_any_libraries'
    THEN
      Concat('View patron infos from any libraries. If not set the logged in user could only access patron infos from its own library or group of libraries. (view_borrower_infos_from_any_libraries)')
    WHEN
      permissions.code = 'place_holds'
    THEN Concat('Place holds for patrons (place_holds)')
    WHEN
      permissions.code = 'advanced_editor'
    THEN
      Concat('Use the advanced cataloging editor (requires edit_catalogue) (advanced_editor)')
    WHEN
      permissions.code = 'create_shared_macros'
    THEN Concat('C', 'reate shared macros (requires advanced_editor) (C',
      'reate_shared_macros)')
    WHEN
      permissions.code = 'delete_shared_macros'
    THEN Concat('D', 'elete shared macros (requires advanced_editor) (D',
      'elete_shared_macros)')
    WHEN
      permissions.code = 'edit_any_item'
    THEN
      Concat('Edit any item including items that would otherwise be restricted (edit_any_item)')
    WHEN
      permissions.code = 'edit_items'
    THEN
      Concat('Edit items (not including items restricted by library group) (edit_items)')
    WHEN
      permissions.code = 'manage_item_editor_templates'
    THEN Concat('C', 'reate, U', 'pdate and D',
      'elete item editor templates owned by others (manage_item_editor_templates)')
    WHEN
      permissions.code = 'manage_item_groups'
    THEN Concat('C', 'reate, U', 'pdate and D',
      'elete item groups, add or remove items from an item group (manage_item_groups)')
    WHEN
      permissions.code = 'set_record_sources'
    THEN Concat('Set record source (set_record_sources)')
    WHEN
      permissions.code = 'discount'
    THEN Concat('Discount debits for patrons (discount)')
    WHEN
      permissions.code = 'payout'
    THEN Concat('Payout credits to patrons (payout)')
    WHEN
      permissions.code = 'refund'
    THEN Concat('Refund payments to patrons (refund)')
    WHEN
      permissions.code = 'writeoff'
    THEN Concat('Write off fines and fees (writeoff)')
    WHEN
      permissions.code = 'order_manage'
    THEN Concat('Manage basket and order lines (order_manage)')
    WHEN
      permissions.code = 'vendors_manage'
    THEN Concat('Manage vendors (vendors_manage)')
    WHEN
      permissions.code = 'batch_upload_patron_images'
    THEN
      Concat('Upload patron images in a batch or one at a time (batch_upload_patron_images)')
    WHEN
      permissions.code = 'delete_anonymize_patrons'
    THEN Concat('D', 'elete old borrowers and anonymize circulation history (D',
      'eletes borrower checkout history) (D', 'elete_anonymize_patrons)')
    WHEN
      permissions.code = 'edit_additional_contents'
    THEN
      Concat('Write additional contents for the OPAC and staff interfaces (news and HTML customizations) (edit_additional_contents)')
    WHEN
      permissions.code = 'inventory'
    THEN Concat('Perform inventory of your catalog (inventory)')
    WHEN
      permissions.code = 'upload_manage'
    THEN
      Concat('Manage uploaded files (Useless without upload_general_files) (upload_manage)')
    WHEN
      permissions.code = 'view_system_logs'
    THEN Concat('Browse the system logs (view_system_logs)')
    WHEN
      permissions.code = 'superserials'
    THEN
      Concat('Manage subscriptions from any branch (only applies when IndependentBranches is used) (superserials)')
    WHEN
      permissions.code = 'execute_reports'
    THEN Concat('Execute SQL reports (execute_reports)')
    WHEN
      permissions.code = 'manage_courses'
    THEN Concat('Add, edit and D', 'elete courses (manage_courses)')
    WHEN
      permissions.code = 'tool'
    THEN Concat('Use tool plugins (tool)')
    WHEN
      permissions.code = 'edit_public_list_contents'
    THEN Concat('Edit public lists contents (edit_public_list_contents)')
    WHEN
      permissions.code = 'edit_public_lists'
    THEN
      Concat('Edit public lists (Name, settings, and permissions, but not explicitly contents) (edit_public_lists)')
    WHEN
      permissions.code = 'edit_clubs'
    THEN Concat('C', 'reate and edit clubs (edit_clubs)')
    WHEN
      permissions.code = 'edit_templates'
    THEN Concat('C', 'reate and edit club templates (edit_templates)')
    WHEN
      permissions.code = 'enroll'
    THEN Concat('Enroll patrons in clubs (enroll)')
    WHEN
      permissions.code = 'self_checkin_module'
    THEN
      Concat('Log into the self check-in module. Note: this permission prevents the patron from using any other OPAC functionality (self_checkin_module)')
    WHEN
      permissions.code = 'self_checkout_module'
    THEN
      Concat('Perform self checkout at the OPAC. It should be used for the patron matching the AutoSelfCheckID (self_checkout_module)')
    WHEN
      permissions.code = 'manage_rotas'
    THEN Concat('C', 'reate, edit and D', 'elete rotas (manage_rotas)')
    WHEN
      permissions.code = 'anonymous_refund'
    THEN Concat('Perform anonymous refund actions (anonymous_refund)')
    WHEN
      permissions.code = 'takepayment'
    THEN Concat('Access the point of sale page and take payments (takepayment)')
    WHEN
      permissions.code = 'manage_recalls'
    THEN Concat('Manage recalls for patrons (manage_recalls)')
    ELSE Concat(permissions.description, ' (', permissions.code, ')')
  END SEPARATOR '<br />')) AS GRANULAR_PERMISSION
FROM
  userflags LEFT JOIN
  permissions ON permissions.module_bit = userflags.bit
GROUP BY
  CASE
    WHEN
      userflags.bit = 2
    THEN
      'Staff access, allows viewing of catalogue in staff interface (catalogue)'
    WHEN
      userflags.bit = 3
    THEN 'Manage Koha system settings (Administration panel) (parameters)'
    WHEN
      userflags.bit = 4
    THEN 'Add, modify and view patron information (borrowers)'
    WHEN
      userflags.bit = 5
    THEN 'Set user permissions (permissions)'
    WHEN
      userflags.bit = 11
    THEN 'Acquisition management (acquisition)'
    WHEN
      userflags.bit = 12
    THEN 'Suggestions management (suggestions)'
    WHEN
      userflags.bit = 17
    THEN
      'Allow staff members to modify permissions, usernames, and passwords for other staff members (staffaccess)'
    WHEN
      userflags.bit = 22
    THEN Concat('C', 'reate and modify Interlibrary loan requests (ill)')
    WHEN
      userflags.bit = 26
    THEN 'OPAC problem reports management (problem_reports)'
    WHEN
      userflags.bit = 28
    THEN 'Manage the electronic resources module (erm)'
    WHEN
      userflags.bit = 29
    THEN Concat(userflags.flagdesc, ' (', userflags.flag, ')')
    WHEN
      userflags.bit = 30
    THEN 'Manage the preservation module (preservation)'
    ELSE Concat(userflags.flagdesc, ' (', userflags.flag, ')')
  END
ORDER BY
  userflags.bit

























