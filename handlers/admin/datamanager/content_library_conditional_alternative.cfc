component {

	property name="customizationService"  inject="dataManagerCustomizationService";
	property name="adminDataViewsService" inject="adminDataViewsService";


	private string function objectBreadcrumb() {
		var contentId = prc.record.content_library_content ?: ( rc.content_library_content ?: ( rc.contentId ?: "" ) );

		if ( !Len( Trim( contentId ) ) ) {
			setNextEvent( url=event.buildAdminLink( objectName="content_library_content" ) );
		}

		var args = {
			  objectName  = "content_library_content"
			, objectTitle = translateResource( "preside-objects.content_library_content:title" )
			, recordId    = contentId
			, recordLabel = renderLabel( "content_library_content", contentId )
		};

		customizationService.runCustomization(
			  objectName     = "content_library_content"
			, action         = "objectBreadcrumb"
			, defaultHandler = "admin.datamanager._objectBreadcrumb"
			, args           = args
		);

		customizationService.runCustomization(
			  objectName     = "content_library_content"
			, action         = "recordBreadcrumb"
			, defaultHandler = "admin.datamanager._recordBreadcrumb"
			, args           = args
		);

		event.addAdminBreadCrumb(
			  title = translateResource( "preside-objects.content_library_content:field.alternatives.title" )
			, link  = event.buildAdminLink( objectName="content_library_content", recordId=contentId )
		);
	}

	private string function buildListingLink() {
		var contentId = prc.record.content_library_content ?: ( rc.content_library_content ?: ( rc.contentId ?: "" ) );

		return event.buildAdminLink( objectName="content_library_content", recordId=contentId );
	}

	private string function preRenderCloneRecordForm( event, rc, prc, args={} ) {
		args.cloneableData.condition = "";

		return "";
	}

	private string function preRenderRecordLeftCol( event, rc, prc, args={} ) {
		args.renderedContent = adminDataViewsService.renderField(
			  objectName   = "content_library_conditional_alternative"
			, propertyName = "content"
			, recordId     = prc.recordId       ?: ""
			, value        = prc.record.content ?: ""
			, renderer     = "richeditor"
		);

		return renderView( view="/admin/datamanager/content_library_conditional_alternative/viewContent", args=args );
	}

	private string function getAdditionalQueryStringForBuildAjaxListingLink( event, rc, prc, args={} ) {
		var contentId = prc.recordId ?: "";

		return "content_library_content=#contentId#";
	}

	private void function preFetchRecordsForGridListing( event, rc, prc, args={} ) {
		var contentId = rc.content_library_content ?: "";

		if ( !IsEmpty( contentId ) ) {
			args.extraFilters = args.extraFilters ?: [];

			args.extraFilters.append( { filter={ content_library_content=contentId } } );
		}
	}
}