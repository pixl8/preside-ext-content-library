component {

	property name="contentLibraryService" inject="contentLibraryService";

	private function index( event, rc, prc, args={} ) {
		var item    = args.content_item ?: "";
		var content = contentLibraryService.getContent( item );

		return renderContent( "richeditor", content );
	}

	private function placeholder( event, rc, prc, args={} ) {
		var item = args.content_item ?: "";
		var itemLabel = renderLabel( "content_library_content", item );

		return translateResource( uri="widgets.contentLibraryContent:placeholder", data=[ itemLabel ] );
	}
}
