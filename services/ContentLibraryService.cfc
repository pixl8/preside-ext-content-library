/**
 * @presideService true
 * @singleton      true
 */
component {

// CONSTRUCTOR
	public any function init() {
		return this;
	}

// PUBLIC API METHODS
	public string function getContent( required string itemId ) {
		var record = $getPresideObject( "content_library_content" ).selectData(
			  id = arguments.itemId
			, selectFields = [ "content" ]
		);

		return record.content ?: "";
	}

}