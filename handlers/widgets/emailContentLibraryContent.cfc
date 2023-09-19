component {

	property name="contentLibraryService" inject="contentLibraryService";

	private function index( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";

		if ( contentLibraryService.emailContentHasAlternatives( item ) ) {
			return renderViewlet( event="widgets.emailContentLibraryContent._nonCacheable", args=args );
		}

		return renderContent( "richeditor", contentLibraryService.getEmailContent( item ) );
	}

	private function placeholder( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";
		var itemLabel = renderLabel( "email_content_library_content", item );

		return translateResource( uri="widgets.contentLibraryContent:placeholder", data=[ itemLabel ] );
	}

	/**
	 * @cacheable false
	 *
	 */
	private function _nonCacheable( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";

		return renderContent( "richeditor", contentLibraryService.getEmailContent( item ) );
	}
}
