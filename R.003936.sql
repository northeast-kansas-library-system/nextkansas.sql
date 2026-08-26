/*
R.003936

----------

Name: 0135 - Statistics test for executive board
Created by: George Williams

----------

Group: Statistics
     2025 beginning of month statistics

Created on: 2026-01-07 00:13:37
Modified on: 2026-01-30 17:42:27
Date last run: 2026-08-05 17:45:45

----------

Public: 0
Expiry: 300

----------

<div class="next_report_info next_noprint">

<style>

  .report_hidden {
    display:  none
  }

  .accordion .accordion-button {
    font-size:  1.1em !important;
    color:  #fff !important;
    font-weight:  900
  }

  .next_report_function .accordion-header * {
    background-color:  #df6320 !important;
    color:  #fff !important
  }

  .next_report_notes .accordion-header * {
    background-color:  #dfc220 !important;
    color:  #000 !important
  }

  .next_report_instructions .accordion-header * {
    background-color:  #3ddf20 !important;
    color:  #000 !important
  }

  .next_report_resources .accordion-header * {
    background-color:  #1f9bde !important;
    color:  #fff !important
  }

  .next_report_training .accordion-header * {
    background-color:  #6320df !important;
    color:  #fff !important
  }

  .accordion-collapse.collapse * {
    background-color:  #e6e6e6;
    color:  #000
  }

  .accordion-body h3 {
    font-size:  1.5em !important
  }

  .report_section {
    border:  2px solid #000;
    border-radius:  8px;
    margin:  10px;
    padding:  15px
  }

  .resources_btn, .training_btn, .direct_download_btn {
    padding:  10px;
    margin:  10px 0 0;
    display:  inline-block;
    font-weight:  650;
    line-height:  1.5;
    text-align:  center;
    vertical-align:  middle;
    white-space:  nowrap;
    color:  #000
  }

  .resources_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #dfc220 !important
  }

  .training_btn {
    border:  1px solid #555;
    border-radius:  4px;
    background:  #3ddf20 !important
  }

  .direct_download_btn {
    color:  #fff;
    border:  1px solid #555;
    border-radius:  4px;
    background:  indigo !important
  }
  .direct_download_btn:hover {
    color: #000000 !important;
    background: #D396FF !important;
  }

</style>

<!-- Overview -->

  <div class="next_report_summary">
    <br>

    <p id="report_id"><strong>Report number:</strong> 3936</p>

    <p id="report_name"><strong>Report name:</strong> Statistics test for executive board</p>

    <p id="report_author"><strong>Report author:</strong> GHW</p>

    <p id="report_summary"><strong>Report summary:</strong> Gathers monthly statistics for the NEKLS executive board</p>

  </div>

  <div class="accordion accordion-flush">

<!-- Function section -->
    <div id="accordion_3936-1" class="accordion-item next_report_function">

      <h2 class="accordion-header" id="panelsStay_3936Open-headingOne" >

        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#panelsStay_3936Open-collapseOne" aria-expanded="true"
          aria-controls="panelsStay_3936Open-collapseOne">

          Function:

        </button>

      </h2>

      <div id="panelsStay_3936Open-collapseOne" class="accordion-collapse collapse"
        aria-labelledby="panelsStay_3936Open-headingOne">
        <div class="accordion-body">

          <div id="function_section" class="report_section">


            <p>Gathers statistics for the NEKLS executive board report</p>
            <ul style="list-style-type:none">

              <li><strong>TIME FRAME:</strong> gathers data from the previous calendar month</li>

              <li><strong>AT:</strong> all Next Search Catalog libraries</li>

              <li><strong>GROUPED BY:</strong> library</li>

              <li><strong>SORTED BY:</strong> library</li>

            <span style="display: none;">
              <li><strong>CONTAINS LINKS:</strong> </li>
            </span>
            </ul>


            <span style="display: none;">
            <p> - </p>
            </span>

          </div>

        </div>
      </div>

    </div>

<!-- Direct download section -->
  <div class="next_report_direct_download ">
    <p><a href="/cgi-bin/koha/reports/guided_reports.pl?op=export&format=csv&id=3936" class="direct_download_btn">Download directly to a CSV file</a></p>
  </div>

<!-- Hashtag section -->
  <div class="next_report_hashtags" style="display: none;">
    <p>#monthly statistics</p>
    <p>#executive board</p>
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
  'Next statistics' As 'Library',
  Concat(Date_Format(AddDate(Last_Day(SubDate(Now(), Interval 2 Month)), 1), '%Y-%m-%d')) As 'Circulation',
  'through' As 'ILL loans',
  Concat(Date_Format(Last_Day(Current_Date() - Interval 1 Month), '%Y-%m-%d')) As 'ILL borrows'
UNION
Select
  'Library' As 'Library',
  'Circulation' As 'Circulation',
  'ILL loans' As 'ILL loans',
  'ILL borrows' As 'ILL borrows'
UNION
(
  Select
    branches.branchname As 'Library',
    Coalesce(circ_renew.count, 0) As 'Circulation',
    Coalesce(ill_loaned.count, 0) As 'ILL loans',
    Coalesce(ill_borrowed.count, 0) As 'ILL borrows'
  From
    branches Left Join
    (
      Select
        statistics.branch,
        Count(*) As count
      From
        statistics
      Where
        Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
        Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
        (
          statistics.type = 'issue' Or
          statistics.type = 'renew'
        )
      Group By
        statistics.branch
    ) circ_renew On circ_renew.branch = branches.branchcode Left Join
    (
      Select
        items.homebranch,
        COUNT(*) As count
      From
        branchtransfers Left Join
        items On branchtransfers.itemnumber = items.itemnumber
      Where
        items.homebranch <> branchtransfers.tobranch And
        Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
        Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
        branchtransfers.tobranch <> branchtransfers.frombranch And
        branchtransfers.comments Is Null And
        branchtransfers.reason = 'reserve'
      Group By
        items.homebranch
    ) ill_loaned On ill_loaned.homebranch = branches.branchcode Left Join
    (
      Select
        branchtransfers.tobranch,
        COUNT(*) As count
      From
        branchtransfers Left Join
        items On branchtransfers.itemnumber = items.itemnumber
      Where
        branchtransfers.tobranch <> items.homebranch And
        Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
        Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
        branchtransfers.frombranch <> branchtransfers.tobranch And
        branchtransfers.comments Is Null And
        branchtransfers.reason = 'reserve'
      Group By
        branchtransfers.tobranch
    ) ill_borrowed On ill_borrowed.tobranch = branches.branchcode
  Group By
    branches.branchcode
  Order By
    branches.branchname
)
Union
Select
  doni_circ_renew.Library As 'Library',
  doni_circ_renew.count As 'Circulation',
  doni_ill_loaned.count As 'ILL loans',
  doni_ill_borrowed.count As 'ILL borrows'
From
  (
    Select
      'Doniphan County Total' As 'Library',
      Count(*) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      ) And
      statistics.branch Like 'DONI%'
  ) doni_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch Like 'DONI%' And
      items.homebranch <> branchtransfers.tobranch And
      branchtransfers.tobranch Not Like 'DONI%' And
      branchtransfers.tobranch <> branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) doni_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch Like 'DONI%' And
      branchtransfers.tobranch <> items.homebranch And
      items.homebranch Not Like 'DONI%' And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch <> branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) doni_ill_borrowed
Union
Select
  ph_circ_renew.Library As 'Library',
  ph_circ_renew.count As 'Circulation',
  ph_ill_loaned.count As 'ILL loans',
  ph_ill_borrowed.count As 'ILL borrows'
From
  (
    Select
      'Prairie Hills total' As 'Library',
      Count(*) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      ) And
      statistics.branch Like 'PH%'
  ) ph_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch Like 'PH%' And
      items.homebranch <> branchtransfers.tobranch And
      branchtransfers.tobranch Not Like 'PH%' And
      branchtransfers.tobranch <> branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) ph_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch Like 'PH%' And
      branchtransfers.tobranch <> items.homebranch And
      items.homebranch Not Like 'PH%' And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch <> branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) ph_ill_borrowed
Union
Select
  total_circ_renew.Library As 'Library',
  total_circ_renew.count As 'Circulation',
  total_ill_loaned.count As 'ILL loans',
  total_ill_borrowed.count As 'ILL borrows'
From
  (Select
      'Total' As 'Library',
      Count(*) As count
    From
      statistics
    Where
      Year(statistics.datetime) = Year(Now() - Interval 1 Month) And
      Month(statistics.datetime) = Month(Now() - Interval 1 Month) And
      (
        statistics.type = 'issue' Or
        statistics.type = 'renew'
      )
  ) total_circ_renew,
  (
    Select
      items.homebranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      items.homebranch <> branchtransfers.tobranch And
      branchtransfers.tobranch <> branchtransfers.frombranch And
      Year(branchtransfers.datesent) = Year(Now() - Interval 1 Month) And
      Month(branchtransfers.datesent) = Month(Now() - Interval 1 Month) And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) total_ill_loaned,
  (
    Select
      branchtransfers.tobranch,
      COUNT(*) As count
    From
      branchtransfers Left Join
      items On branchtransfers.itemnumber = items.itemnumber
    Where
      branchtransfers.tobranch <> items.homebranch And
      Month(branchtransfers.datearrived) = Month(Now() - Interval 1 Month) And
      Year(branchtransfers.datearrived) = Year(Now() - Interval 1 Month) And
      branchtransfers.frombranch <> branchtransfers.tobranch And
      branchtransfers.comments Is Null And
      branchtransfers.reason = 'reserve'
  ) total_ill_borrowed
LIMIT 1000

























