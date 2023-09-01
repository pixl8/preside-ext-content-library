component {

	property name="contentLibraryService" inject="contentLibraryService";

	private function index( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";

		if ( contentLibraryService.contentHasAlternatives( item ) ) {
			return renderViewlet( event="widgets.contentLibraryContent._nonCacheable", args=args );
		}

		return renderContent( "richeditor", contentLibraryService.getContent( item ) );
	}

	private function placeholder( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";
		var itemLabel = renderLabel( "content_library_content", item );

		return translateResource( uri="widgets.contentLibraryContent:placeholder", data=[ itemLabel ] );
	}

	/**
	 * @cacheable false
	 *
	 */
	private function _nonCacheable( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";

		return renderContent( "richeditor", contentLibraryService.getContent( item ) );
	}
}
