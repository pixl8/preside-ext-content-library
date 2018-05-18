component {

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
}