component {

	property name="adminDataViewsService" inject="adminDataViewsService";

	private boolean function checkPermission( event, rc, prc, args={} ) {
		var keysAlwaysNotPermitted = [ "manageContextPerms" ]

		if ( keysAlwaysNotPermitted.findNoCase( args.key ?: "" ) ) {
			return false;
		}

		var key           = "contentLibrary.#( args.key ?: "" )#";
		var hasPermission = hasCmsPermission( key );

		if ( !hasPermission && IsTrue( args.throwOnError ?: "" ) ) {
			event.adminAccessDenied();
		}

		return hasPermission;
	}

	private string function renderRecord( event, rc, prc, args={} ) {
		args.renderedContent = adminDataViewsService.renderField(
			  objectName   = "content_library_content"
			, propertyName = "content"
			, recordId     = prc.recordId       ?: ""
			, value        = prc.record.content ?: ""
		);
		args.alternativesTable = objectDataTable( objectName="content_library_conditional_alternative", args={
			  allowSearch         = false
			, allowFilter         = false
			, allowDataExport     = false
			, compact             = true
			, useMultiActions     = true
		} );
		args.addAlternativeLink = event.buildAdminLink( objectName="content_library_conditional_alternative", operation="addRecord", queryString="content_library_content=#prc.recordId#" );

		return renderView( view="/admin/datamanager/content_library_content/viewRecord", args=args );
	}
}