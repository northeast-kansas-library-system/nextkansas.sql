/*
R.003772

----------

Name: GHW - Bibliographic records created during a specific date range
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-16 17:47:06
Modified on: 2024-01-17 11:17:12
Date last run: 2024-08-28 08:33:18

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
 
  &lt;div class="reportInfoContent"&gt; 
 
    &lt;p&gt;Lists bibliographic records&lt;/p&gt; 
 
    &lt;ul&gt; 
      &lt;li&gt;created during the date range you specify&lt;/li&gt; 
      &lt;li&gt;by staff at the library you specify&lt;/li&gt; 
      &lt;li&gt;grouped by biblio number and action logs ID&lt;/li&gt; 
      &lt;li&gt;sorted by:
      &lt;ol&gt;
        &lt;li&gt;the library that created the record&lt;/li&gt;
        &lt;li&gt;bibliographic shelving location (942$c)&lt;/li&gt;
        &lt;li&gt;bibliographic item type (942$e)&lt;/li&gt;
        &lt;li&gt;bibliographic collection code (942$h)&lt;/li&gt;
      &lt;/ol&gt;
    &lt;/li&gt;
    &lt;li&gt;links to the bibliographic record&lt;/li&gt;
    &lt;/ul&gt; 
 
  &lt;/div&gt; 
 
  &lt;div class="reportInfoNotes"&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
    &lt;p&gt; 
      If a bibliographic record is created and then deleted in the period specified, you will be unable to link to the record.
    &lt;/p&gt; 
 
    &lt;p&gt; 
 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoLinks"&gt; 
 
  &lt;/div&gt; 
 
  &lt;div id="reportInfoTags"&gt; 
 
    &lt;p style="display: none;"&gt; 
      #bibliographic record 
      #by library 
    &lt;/p&gt; 
 
  &lt;/div&gt; 
 
  &lt;!-- html notes rendered on guided_reports.pl by jquery at https://wiki.koha-community.org/wiki/JQuery_Library#Render_patron_messages_as_HTML_and_in_Report_notes --&gt; 
 
&lt;/div&gt; 

----------
*/



Select 
  branches.branchname,
  LOCS.lib AS LOCATION,
  itemtypes.description AS ITEM_TYPE,
  ccodes.lib AS COLLECTION_CODE,
  biblios.author,
  Concat_Ws('', biblios.title, biblios.subtitle) AS TITLE,
  biblios.frameworkcode,
  biblios.LINK
From action_logs
  Left Join borrowers On borrowers.borrowernumber = action_logs.user
  Left Join (
    Select 
      Concat(
        '',
        'Go to biblio'
      ) AS LINK,
      biblio.biblionumber,
      biblioitems.agerestriction,
      biblioitems.itemtype,
      biblioitems.cn_class,
      biblio.author,
      biblio.title,
      biblio.subtitle,
      biblio.frameworkcode
    From biblio
      Join biblioitems On biblioitems.biblionumber = biblio.biblionumber
    Where 
      biblio.datecreated Between &lt;&gt; and (&lt;&gt; + Interval 1 Day)
    Group By biblio.biblionumber
    Union
    Select 
      Concat('Deleted on ', deletedbiblio.timestamp) AS BIBLIOS,
      deletedbiblio.biblionumber,
      deletedbiblioitems.agerestriction,
      deletedbiblioitems.itemtype,
      deletedbiblioitems.cn_class,
      deletedbiblio.author,
      deletedbiblio.title,
      deletedbiblio.subtitle,
      deletedbiblio.frameworkcode
    From deletedbiblio
      Join deletedbiblioitems On deletedbiblioitems.biblionumber = deletedbiblio.biblionumber
    Where 
      deletedbiblio.datecreated Between &lt;&gt; and (&lt;&gt; + Interval 1 Day)
    Group By deletedbiblio.biblionumber
  ) biblios 
    On biblios.biblionumber = action_logs.object
  Join branches On borrowers.branchcode = branches.branchcode
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'LOC'
  ) LOCS 
    On LOCS.authorised_value = biblios.agerestriction
  Left Join itemtypes 
    On itemtypes.itemtype = biblios.itemtype
  Left Join (
    Select authorised_values.category,
      authorised_values.authorised_value,
      authorised_values.lib,
      authorised_values.lib_opac
    From authorised_values
    Where authorised_values.category = 'CCODE'
  ) ccodes 
    On ccodes.authorised_value = biblios.cn_class
Where 
  action_logs.module = 'CATALOGUING'
  And action_logs.action = 'ADD'
  And action_logs.info = 'biblio'
  And branches.branchcode Like &lt;&gt;
  And biblios.agerestriction Like &lt;&gt;
  And biblios.itemtype Like &lt;&gt;
  And biblios.cn_class Like &lt;&gt;
  And action_logs.timestamp Between &lt;&gt; and (&lt;&gt; + Interval 1 Day)
Group By 
  action_logs.action_id,
  biblios.biblionumber  
Order By 
  branches.branchname,
  LOCATION,
  ITEM_TYPE,
  COLLECTION_CODE,
  biblios.author,
  TITLE,
  biblios.LINK

























