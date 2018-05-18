component {

	public void function configure( required struct config ) {
		var settings = arguments.config.settings ?: {};

		_setupSideBar( settings );
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
	}

	private void function _setupPermissions( required struct settings ) {
		settings.adminPermissions = settings.adminPermissions ?: {};

		settings.adminPermissions.contentLibrary = [ "navigate", "add", "delete", "edit", "publish", "saveDraft" ];

		settings.adminRoles.contentadmin  = settings.adminRoles.contentadmin  ?: [];
		settings.adminRoles.contenteditor = settings.adminRoles.contenteditor ?: [];

		settings.adminRoles.contentadmin.append( "contentLibrary.*" );
		settings.adminRoles.contenteditor.append( "contentLibrary.*" );
		settings.adminRoles.contenteditor.append( "!contentLibrary.delete" );

	}

}
