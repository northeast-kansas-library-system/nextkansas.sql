/*
R.002930

----------

Name: GHW - Patrons with unpaid fees based on fee-creating branch
Created by: George Williams

----------

Group: -
     -

Created on: 2017-04-26 12:32:24
Modified on: 2025-12-18 00:42:47
Date last run: 2026-04-21 15:03:39

----------

Public: 0
Expiry: 0

----------

<div class="next_report_info next_noprint">

  <style>

       .page-section .next_report_info {
      font-size: 120% !important;
    }

        .report_hidden {
          display: none;
        }

        .accordion .accordion-button {
          font-size: 1.1em !important;
          color: white !important;
          font-weight: 900;
        }

        .next_report_function .accordion-header * {
          background-color: #DF6320 !important;
          color: #ffffff !important;
        }

        .next_report_notes .accordion-header * {
          background-color: #DFC220 !important;
          color: #000000 !important;
        }

        .next_report_instructions .accordion-header * {
          background-color: #3DDF20 !important;
          color: #000000 !important;
        }

        .next_report_resources .accordion-header * {
          background-color: #1f9bde !important;
          color: #ffffff !important;
        }

        .next_report_training .accordion-header * {
          background-color: #6320DF !important;
          color: #ffffff !important;
        }

        .accordion-collapse.collapse * {
          background-color: #e6e6e6;
          color: #000000;
        }

        .accordion-body h3 {
          font-size: 1.5em !important;
        }

        .report_section {
          border: 2px solid black;
          border-radius: 8px;
          margin: 10px;
          padding: 15px;
        }

        .resources_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #DFC220 none !important;
          color: #000000;
          !important;
        }

        .resources_btn:hover {
          background: #F2E6A5 none !important;
          color: #000000;
          !important;
        }

        .training_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #3DDF20 none !important;
          color: #000000;
          !important;
        }

        .training_btn:hover {
          background: #B1F2A5 none !important;
          color: #000000;
          !important;
        }

        .direct_download_btn {
          padding: 10px;
          margin: 10px 0px 0px 0px;
          border: 1px solid #555;
          border-radius: 4px;
          display: inline-block;
          font-weight: 650;
          line-height: 1.5;
          text-align: center;
          vertical-align: middle;
          white-space: nowrap;
          background: #C220DF none !important;
          color: #ffffff;
          !important;
        }

        .direct_download_btn:hover {
          background: #E6A5F2 none !important;
          color: #000000;
          !important;
        }

  </style>



<!-- Overview -->
  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 2930</p>

    <p id="report_name"><strong>Report name:</strong> GHW - Patrons with unpaid fees based on fee-creating branch</p>

    <span style="display: none;">
      <p id="report_author"><strong>Report author/source:</strong> - </p>
    </span>

    <p id="report_summary"><strong>Report summary:</strong> Generates report of borrowers owing fees to the library you specify</p>

  </div>

  <div class="accordion accordion-flush">



<!-- Function section -->
    <div id="accordion_2930-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_2930Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_2930Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_2930Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_2930Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_2930Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Generates report of borrowers owing fees to the library you specify</p>
            <ul>

              <li>Shows all unpaid fees</li>

              <li>Shows fees due to the library you specify regardless of the borrower's or item's home library</li>

              <li>Grouped by library name, borrowernumber, and accountline id</li>

              <li>Sorted by fee creating library and borrower number</li>

            <span style="display: none;">
              <li></li>            </span>
            </ul>


            <p>These are the fees that your library "owns"</p>

          </div>

        </div>
      </div>

    </div>



<!-- Notes section -->
    <div id="accordion_REPORTID-2" class="accordion-item next_report_notes ">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingTwo">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseTwo" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseTwo">

          Notes:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseTwo" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingTwo">
        <div class="accordion-body">

          <div id="notes_1" class="report_section">
            <h4>Determining the fee creating library</h4>
            <p><ul><br><li>If a fee was manually created, the fee creating library is the library where the fee was created</li><br><li>If an item is still checked out to the borrower, the fee creating library is determined by the issues table</li><br><li>If an item was returned within the previous 13 months, the fee creating library is determined by the oldissues table</li><br><li>If an item was returned more than 13 months ago, the fee creating library is assumed to be the item's owning library</li><br><li>If an item was returned more than 13 months ago and the fee creating library cannot be determined any other way, the fee creating library is assumed to be the borrower's home library</li><br></ul><br></p>
          </div>

          <div id="notes_2" class="report_section report_hidden">
            <h4> NOTE_TWO_TITLE </h4>
            <p> NOTE_TWO_CONTENT </p>
          </div>

          <div id="notes_3" class="report_section report_hidden">
            <h4> NOTE_THREE_TITLE </h4>
            <p> NOTE_THREE_CONTENT </p>
          </div>

          <div id="notes_4" class="report_section report_hidden">
            <h4> NOTE_FOUR_TITLE </h4>
            <p> NOTE_FOUR_CONTENT </p>
          </div>

          <div id="notes_5" class="report_section report_hidden">
            <h4> NOTE_FIVE_TITLE </h4>
            <p> NOTE_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>




<!-- Instructions section -->
    <div id="accordion_REPORTID-3" class="accordion-item next_report_instructions report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingThree">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseThree" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseThree">

          Instructions:

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseThree" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingThree">
        <div class="accordion-body">

          <div id="instructions_1" class="report_section report_hidden">
            <h4> INSTRUCTION_1_TITLE </h4>
            <p> INSTRUCTION_1_CONTENT </p>
          </div>

          <div id="instructions_2" class="report_section report_hidden">
            <h4> INSTRUCTION_TWO_TITLE </h4>
            <p> INSTRUCTION_TWO_CONTENT </p>
          </div>

          <div id="instructions_3" class="report_section report_hidden">
            <h4> INSTRUCTION_THREE_TITLE </h4>
            <p> INSTRUCTION_THREE_CONTENT </p>
          </div>

          <div id="instructions_4" class="report_section report_hidden">
            <h4> INSTRUCTION_FOUR_TITLE </h4>
            <p> INSTRUCTION_FOUR_CONTENT </p>
          </div>

          <div id="instructions_5" class="report_section report_hidden">
            <h4> INSTRUCTION_FIVE_TITLE </h4>
            <p> INSTRUCTION_FIVE_CONTENT </p>
          </div>

        </div>
      </div>

    </div>



<!-- Resources section -->
    <div id="accordion_REPORTID-4" class="accordion-item next_report_resources report_hidden " style="">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFour">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFour" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFour">
          Resources:
        </button>
      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFour" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFour">

        <div class="accordion-body">

          <div id="resources_1" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_ONE_URL " target="_blank" class="resources_btn"> RESOURCE_ONE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_ONE_NOTE </p>
            </div>          </div>


          <div id="resources_2" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_TWO_URL " target="_blank" class="resources_btn"> RESOURCE_TWO_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_TWO_NOTE </p>
            </div>          </div>


          <div id="resources_3" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_THREE_URL " target="_blank" class="resources_btn"> RESOURCE_THREE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_THREE_NOTE </p>
            </div>          </div>


          <div id="resources_4" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FOUR_URL " target="_blank" class="resources_btn"> RESOURCE_FOUR_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FOUR_NOTE </p>
            </div>          </div>


          <div id="resources_5" class="row report_section report_hidden">
            <div class="col col-md-2">
              <p><a href=" RESOURCE_FIVE_URL " target="_blank" class="resources_btn"> RESOURCE_FIVE_TITLE </a></p>
            </div>            <div class="col col-md-8">
              <p> RESOURCE_FIVE_NOTE </p>
            </div>          </div>

        </div>

      </div>

    </div>


<!-- Training section -->
    <div id="accordion_REPORTID-5" class="accordion-item next_report_training report_hidden">

      <h2 class="accordion-header" id="panelsStay_REPORTIDOpen-headingFive">

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_REPORTIDOpen-collapseFive" aria-expanded="false"
          aria-controls="panelsStay_REPORTIDOpen-collapseFive">

          Training available

        </button>

      </h2>

      <div id="panelsStay_REPORTIDOpen-collapseFive" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_REPORTIDOpen-headingFive" style="color: white !important;">
        <div class="accordion-body">

          <div class="container text-center">
            <div class="row">


              <div id="training_link" class="col-md-3 report_hidden">
                <p><a href=" TRAINING_LINK_URL " target="_blank" class="training_btn">Online training</a></p>
              </div>


              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Training handout</a></p>
              </div>

              <div id="training_link" class="col-md-3">
                <p><a href="" target="_blank" class="training_btn">Video training</a></p>
              </div>

            </div>
          </div>
        </div>
      </div>

    </div>

  </div>

<!-- Direct download section -->
  <div class="next_report_direct_download report_hidden">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=2930" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>



<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#fees</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
    <p>#</p>
  </div>

</div>

----------
*/



Select
  branches.branchname As TRANSACTING_LIBRARY,
  borrowers.borrowernumber,
  borrowers.cardnumber,
  categories.description As BORROWER_CATEGORY,
  Concat_Ws(' \n ', 
    Concat_Ws(' / ', 
      borrowers.firstname, 
      borrowers.surname
    ), 
    borrowers.address, 
    Concat(
      borrowers.city, 
      ', ', 
      borrowers.state, 
      ' ', 
      borrowers.zipcode
    )
  ) As CONTACT_INFO,
  borrowers.dateexpiry,
  expired_attributes.lib As EXPIRED_ATTRIBUTE,
  borrowers.email,
  borrowers.phone,
  borrowers.branchcode As BORROWER_HOME_LIBRARY,
  outstanding_fees.date As DATE_OF_FEE,
  outstanding_fees.amount As AMOUNT_OF_FEE,
  outstanding_fees.amountoutstanding As UNPAID_BALANCE,
  outstanding_fees.description As DESCRIPTION,
  outstanding_fees.NOTE As NOTE,
  account_debit_types.description As DEBIT_TYPE,
  fee_status.lib As FEE_STATUS,
  interface.lib AS FEE_CREATED_BY,
  outstanding_fees.FEE_BRANCH As FEE_OWNED_BY,
  outstanding_fees.accountlines_id
From
  borrowers Join
  (
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, issues.branchcode) As FEE_BRANCH
    From
      accountlines Join
      issues On accountlines.issue_id = issues.issue_id
    Where
      accountlines.issue_id Is Not Null And
      accountlines.amountoutstanding > 0
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, old_issues.branchcode) As FEE_BRANCH
    From
      accountlines Join
      old_issues On accountlines.old_issue_id = old_issues.issue_id
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Not Null
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, items.homebranch) As FEE_BRANCH
    From
      accountlines Left Join
      items On accountlines.itemnumber = items.itemnumber
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Null And
      accountlines.issue_id Is Null And
      accountlines.itemnumber Is Not Null
    Union
    Select
      accountlines.accountlines_id,
      accountlines.issue_id,
      accountlines.old_issue_id,
      accountlines.borrowernumber,
      accountlines.itemnumber,
      accountlines.date,
      accountlines.amount,
      accountlines.amountoutstanding,
      accountlines.description,
      Trim(Replace(Replace(accountlines.note, Char(10), ' '), Char(13), ' ')) As NOTE,
      Coalesce(accountlines.debit_type_code, 'FINE') As debit_type_code,
      accountlines.status,
      accountlines.manager_id,
      Coalesce(accountlines.interface, ' ') As interface,
      If(accountlines.branchcode Is Not Null, accountlines.branchcode, borrowers.branchcode) As FEE_BRANCH
    From
      accountlines Left Join
      borrowers On accountlines.borrowernumber = borrowers.borrowernumber
    Where
      accountlines.amountoutstanding > 0 And
      accountlines.old_issue_id Is Null And
      accountlines.issue_id Is Null And
      accountlines.itemnumber Is Null
    ) outstanding_fees 
      On outstanding_fees.borrowernumber = borrowers.borrowernumber
  Join branches 
    On outstanding_fees.FEE_BRANCH = branches.branchcode 
  Left Join categories 
    On borrowers.categorycode = categories.categorycode 
  Left Join account_debit_types 
    On account_debit_types.code = outstanding_fees.debit_type_code 
  Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'Z_FEE_STATUS'
  ) fee_status 
    On fee_status.authorised_value = outstanding_fees.status
  Left Join
  (
    Select
      authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From
      authorised_values
    Where
      authorised_values.category = 'Z_INTERFACE'
  ) interface 
    On interface.authorised_value = outstanding_fees.interface
  Left Join
  (
    Select
      borrower_attributes.borrowernumber,
      borrower_attributes.code,
      borrower_attributes.attribute,
      authorised_values.lib,
      authorised_values.category
    From
      borrower_attributes Join
      authorised_values On borrower_attributes.attribute = authorised_values.authorised_value
    Where
      borrower_attributes.code = 'expired' And
      authorised_values.category = 'expired'
  ) expired_attributes 
    On expired_attributes.borrowernumber = outstanding_fees.borrowernumber
Where
  branches.branchcode Like <<Choose your library|LBRANCH>> And
  borrowers.categorycode Like  <<Borrower category|categorycode:all>>  And
  outstanding_fees.debit_type_code Like  <<Debit type|debit_types:all>>  And
  outstanding_fees.interface Like <<Free created by|Z_INTERFACE>> And
  Coalesce(expired_attributes.attribute, '-') Like <<Expired attribute|EXPIRED:all>> And
  borrowers.cardnumber Like Concat('%', <<Enter a library card number or a % symbol>>, '%')
Group By
  branches.branchname,
  borrowers.borrowernumber,
  outstanding_fees.accountlines_id
Order By
  TRANSACTING_LIBRARY,
  borrowers.borrowernumber

























