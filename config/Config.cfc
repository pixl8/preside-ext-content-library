component {

	public void function configure( required struct config ) {
		var settings = arguments.config.settings ?: {};

		_setupFeatures( settings );
		_setupSideBar( settings );
		_setupPermissions( settings );
	}

	private void function _setupSideBar( required struct settings ) {
		settings.adminSideBarItems = settings.adminSideBarItems ?: [];
		var siteTreePos = settings.adminSideBarItems.find( "sitetree" );

		if ( siteTreePos ) {
			settings.adminSideBarItems.insertAt( siteTreePos+1, "contentLibrary" );
			settings.adminSideBarItems.insertAt( siteTreePos+2, "emailContentLibrary" );

		} else {
			settings.adminSideBarItems.append( "contentLibrary" );
			settings.adminSideBarItems.append( "emailContentLibrary" );
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
		settings.features.emailContentLibrary                 = { enabled=false , siteTemplates=[ "*" ], widgets=["email_content_library"] };
	}

}
