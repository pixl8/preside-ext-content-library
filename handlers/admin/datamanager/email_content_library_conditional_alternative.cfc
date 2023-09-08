component extends="preside.system.base.AdminHandler" {

	property name="customizationService"  inject="dataManagerCustomizationService";
	property name="adminDataViewsService" inject="adminDataViewsService";
	property name="dao"                   inject="presidecms:object:email_content_library_conditional_alternative";

// PUBLIC ACTIONS
	public void function sortRecords( event, rc, prc ) {
		if ( !hasCmsPermission( "contentLibrary.edit" ) ) {
			event.adminAccessDenied();
		}

		event.initializeDatamanagerPage( objectName="email_content_library_conditional_alternative" );

		var objectName        = rc.object = prc.objectName ?: "";
		var objectTitle       = prc.objectTitle            ?: "";
		var objectTitlePlural = prc.objectTitlePlural      ?: "";

		prc.records = dao.selectData(
			  selectFields = [ "id", "label", "sort_order" ]
			, orderby      = "sort_order"
			, filter       = { email_content_library_content=rc.email_content_library_content ?: "" }
		);

		event.addAdminBreadCrumb(
			  title = translateResource( uri="cms:datamanager.sortRecords.breadcrumb.title" )
			, link  = ""
		);
		prc.pageTitle = translateResource( uri="cms:datamanager.sortRecords.title", data=[ objectTitlePlural ] );
		prc.pageIcon  = "sort-amount-asc";

		event.include( "/js/admin/specific/datamanager/sortrecords/" );
		event.setView( "/admin/datamanager/sortRecords" );
	}

// CUSTOMIZATIONS
	private string function buildSortRecordsLink( event, rc, prc, args={} ) {
		return event.buildAdminLink(
			  linkto      = "datamanager.email_content_library_conditional_alternative.sortRecords"
			, queryString = "object=email_content_library_conditional_alternative&" & ( args.queryString ?: "" )
		);
	}


	private string function objectBreadcrumb() {
		var contentId = prc.record.email_content_library_content ?: ( rc.email_content_library_content ?: ( rc.contentId ?: "" ) );

		if ( !Len( Trim( contentId ) ) ) {
			setNextEvent( url=event.buildAdminLink( objectName="email_content_library_content" ) );
		}

		var args = {
			  objectName  = "email_content_library_content"
			, objectTitle = translateResource( "preside-objects.email_content_library_content:title" )
			, recordId    = contentId
			, recordLabel = renderLabel( "email_content_library_content", contentId )
		};

		customizationService.runCustomization(
			  objectName     = "email_content_library_content"
			, action         = "objectBreadcrumb"
			, defaultHandler = "admin.datamanager._objectBreadcrumb"
			, args           = args
		);

		customizationService.runCustomization(
			  objectName     = "email_content_library_content"
			, action         = "recordBreadcrumb"
			, defaultHandler = "admin.datamanager._recordBreadcrumb"
			, args           = args
		);

		event.addAdminBreadCrumb(
			  title = translateResource( "preside-objects.email_content_library_content:field.alternatives.title" )
			, link  = event.buildAdminLink( objectName="email_content_library_content", recordId=contentId )
		);
	}

	private string function buildListingLink() {
		var contentId = prc.record.email_content_library_content ?: ( rc.email_content_library_content ?: ( rc.contentId ?: "" ) );

		if ( !Len( Trim( contentId ) ) ) {
			if ( event.getCurrentAction() == "sortRecordsAction" ) {
				var record = dao.selectData( id=ListFirst( rc.ordered ?: "" ) );
				contentId = record.email_content_library_content ?: "";
			}
		}

		return event.buildAdminLink( objectName="email_content_library_content", recordId=contentId );
	}

	private string function preRenderCloneRecordForm( event, rc, prc, args={} ) {
		args.cloneableData.condition = "";

		return "";
	}

	private string function preRenderRecordLeftCol( event, rc, prc, args={} ) {
		args.renderedContent = adminDataViewsService.renderField(
			  objectName   = "email_content_library_conditional_alternative"
			, propertyName = "content"
			, recordId     = prc.recordId       ?: ""
			, value        = prc.record.content ?: ""
			, renderer     = "richeditor"
		);

		return renderView( view="/admin/datamanager/content_library_conditional_alternative/viewContent", args=args );
	}

	private string function getAdditionalQueryStringForBuildAjaxListingLink( event, rc, prc, args={} ) {
		var contentId = prc.recordId ?: "";

		return "email_content_library_content=#contentId#";
	}

	private void function preFetchRecordsForGridListing( event, rc, prc, args={} ) {
		var contentId = rc.email_content_library_content ?: "";

		if ( !IsEmpty( contentId ) ) {
			args.extraFilters = args.extraFilters ?: [];

			args.extraFilters.append( { filter={ email_content_library_content=contentId } } );
		}
	}

	public void function addRecordAction( event, rc, prc ) {
		var contentId    = rc.email_content_library_content ?: "";
		var addRecordUrl = event.buildAdminLink( linkTo="datamanager.addRecord", queryString="object=email_content_library_conditional_alternative&email_content_library_content=#contentId#" );

		runEvent(
			  event          = "admin.DataManager._addRecordAction"
			, prePostExempt  = true
			, private        = true
			, eventArguments = { audit=true, addAnotherUrl=addRecordUrl, errorUrl=addRecordUrl }
		);
	}
}