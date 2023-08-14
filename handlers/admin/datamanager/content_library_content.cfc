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
			, useMultiActions     = false
		} );
		args.addAlternativeLink = event.buildAdminLink( objectName="content_library_conditional_alternative", operation="addRecord", queryString="content_library_content=#prc.recordId#" );
		args.sortAlternativesLink = event.buildAdminLink( objectName="content_library_conditional_alternative", operation="sortRecords", queryString="content_library_content=#prc.recordId#" );

		return renderView( view="/admin/datamanager/content_library_content/viewRecord", args=args );
	}

	private void function preEditRecordAction( event, rc, prc, args={} ) {
		var recordId      = args.recordId    ?: "";
		var formData      = args.formData    ?: {};
		var contentData   = formData.content ?: "";
		var widgetPattern = "\{\{widget:contentLibraryContent:(.*?):widget\}\}";
		var regexMatched  = ReFind( widgetPattern, contentData, 1, true );
		    regexMatched  = regexMatched.match ?: [];

		if ( Len( Trim( recordId ) ) && ArrayLen( regexMatched ) ) {
			var contentItem = UrlDecode( ArrayLast( regexMatched ) );

			if ( IsJSON( contentItem ) ) {
				contentItem = DeserializeJSON( contentItem );
				contentItem = contentItem.content_item ?: "";

				if ( contentItem == recordId ) {
					args.validationResult.addError( fieldName="content", message="preside-objects.content_library_content:field.content.selected.self.error" );
				}
			}
		}
	}
}