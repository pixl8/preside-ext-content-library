component {

	public void function configure( required struct config ) {
		var settings = arguments.config.settings ?: {};

		_setupFeatures( settings );
		_setupSideBar( settings );
		_setupAdminItems( settings );
		_setupPermissions( settings );
	}

	private void function _setupSideBar( required struct settings ) {
		settings.adminSideBarItems = settings.adminSideBarItems ?: [];
		var siteTreePos = settings.adminSideBarItems.find( "sitetree" );

		if ( siteTreePos ) {
			settings.adminSideBarItems.insertAt( siteTreePos+1, "contentLibrary" );

		} else {
			settings.adminSideBarItems.append( "contentLibrary" );
		}

		if(arrayFind(settings.adminSideBarItems, "emailCenter")){
			settings.adminSideBarItems.emailCenter.append("emailContentLibrary")
		}

	}

	private void function _setupAdminItems( required struct settings ) {

		settings.adminMenuItems = settings.adminMenuItems ?: {};

		if ( StructKeyExists( settings.adminMenuItems, "emailCenter" ) && StructKeyExists( settings.adminMenuItems.emailCenter, "subMenuItems" ) ) {
			ArrayAppend( settings.adminMenuItems.emailCenter.subMenuItems, "emailContentLibrary" );

			settings.adminMenuItems.emailContentLibrary = {
				  feature       = "emailContentLibrary"
				, permissionKey = "contentLibrary.navigate"
				, buildLinkArgs = { objectName="email_content_library_content" }
				, activeChecks = { datamanagerObject=[ "email_content_library_content", "email_content_library_conditional_alternative" ] }
			}
		}
	}

	private void function _setupPermissions( required struct settings ) {
		settings.adminPermissions = settings.adminPermissions ?: {};

		settings.adminPermissions.contentLibrary = [ "navigate", "read", "add", "delete", "edit",  "viewversions", "publish", "saveDraft", "clone" ];

		settings.adminRoles.contentadmin  = settings.adminRoles.contentadmin  ?: [];
		settings.adminRoles.contenteditor = settings.adminRoles.contenteditor ?: [];

		settings.adminRoles.contentadmin.append( "contentLibrary.*" );
		settings.adminRoles.contenteditor.append( "contentLibrary.*" );
		settings.adminRoles.contenteditor.append( "!contentLibrary.delete" );

	}

	private void function _setupFeatures( required struct settings ) {
		settings.features.emailContentLibrary                 = { enabled=true , siteTemplates=[ "*" ], widgets=["email_content_library"] };
	}

}
