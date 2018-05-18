<cfscript>
  if ( hasCmsPermission( "contentLibrary.navigate" ) ) {
    Echo( renderView(
          view = "/admin/layout/sidebar/_menuItem"
        , args = {
              active  = ( event.getCurrentHandler() == "datamanager" ) && ( prc.objectName ?: "" ) == "content_library_content"
            , link    = event.buildAdminLink( objectName="content_library_content" )
            , gotoKey = "c"
            , icon    = "fa-align-left"
            , title   = translateResource( 'contentLibrary:menu.title' )
          }
    ) );
}
</cfscript>