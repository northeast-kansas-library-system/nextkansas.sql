/*
R.003767

----------

Name: GHW - Bibliographic records created in the previous caleandar month
Created by: George Williams

----------

Group: -
     -

Created on: 2023-10-13 14:44:44
Modified on: 2024-01-29 16:39:35
Date last run: 2024-08-28 08:33:43

----------

Public: 0
Expiry: 300

----------

&lt;div class="reportinfo noprint"&gt; 
  &lt;p&gt;Generates a list of the bibliographic records created during the previous calendar month&lt;/p&gt;
  &lt;ul&gt;
    &lt;li&gt;Lists all bibliographic records created in the previous calendar month&lt;/li&gt;
    &lt;li&gt;at the library you specify&lt;/li&gt;
    &lt;li&gt;With the bibliographic shelving location, bibliographic item type, and bibliographic collection code you specify&lt;/li&gt;
    &lt;li&gt;grouped by item barcode number&lt;/li&gt;
    &lt;li&gt;sorted by:
      &lt;ul&gt;
        &lt;li&gt;the library that created the record&lt;/li&gt;
        &lt;li&gt;bibliographic shelving location (942$c)&lt;/li&gt;
        &lt;li&gt;bibliographic item type (942$e)&lt;/li&gt;
        &lt;li&gt;bibliographic collection code (942$h)&lt;/li&gt;
      &lt;/ul&gt;
    &lt;/li&gt;
    &lt;li&gt;links to the bibliographic record&lt;/li&gt;
  &lt;/ul&gt;&lt;br /&gt;
  &lt;p&gt;&lt;ins&gt;Notes:&lt;/ins&gt;&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p&gt;Notes go here.&lt;/p&gt;
  &lt;p&gt;&lt;/p&gt;
  &lt;p class= "notetags" style="display: none;"&gt;#statistics tab; #bibliographic records&lt;/p&gt;
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
    Where Year(biblio.datecreated) = Year(Now() - Interval 1 Month)
      And Month(biblio.datecreated) = Month(Now() - Interval 1 Month)
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
    Where Year(deletedbiblio.datecreated) = Year(Now() - Interval 1 Month)
      And Month(deletedbiblio.datecreated) = Month(Now() - Interval 1 Month)
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
  And Year(action_logs.timestamp) = Year(Now() - Interval 1 Month)
  And Month(action_logs.timestamp) = Month(Now() - Interval 1 Month)
  And branches.branchcode Like &lt;&gt;
  And biblios.agerestriction Like &lt;&gt;
  And biblios.itemtype Like &lt;&gt;
  And biblios.cn_class Like &lt;&gt;
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

























