/**
 * @presideService true
 * @singleton      true
 */
component {

// CONSTRUCTOR
	/**
	 * @rulesEngineConditionService.inject rulesEngineConditionService
	 *
	 */
	public any function init( required any rulesEngineConditionService ) {
		_setRulesEngineConditionService( arguments.rulesEngineConditionService );

		return this;
	}

// PUBLIC API METHODS
	public string function getContent( required string itemId ) {
		var conditionService        = _getRulesEngineConditionService();
		var conditionalAlternatives = $getPresideObject( "content_library_conditional_alternative" ).selectData(
			  filter       = { content_library_content = arguments.itemId }
			, selectFields = [ "condition", "content" ]
			, orderBy      = "sort_order"
		);

		for( var alternative in conditionalAlternatives ) {
			if ( conditionService.evaluateCondition( alternative.condition, "webrequest" ) ) {
				return alternative.content;
			}
		}

		var record = $getPresideObject( "content_library_content" ).selectData(
			  id = arguments.itemId
			, selectFields = [ "content" ]
		);
		return record.content ?: "";
	}

	public boolean function contentHasAlternatives( required string itemId ) {
		return $getPresideObject( "content_library_conditional_alternative" ).dataExists(
			filter = { content_library_content = arguments.itemId }
		);
	}

// private getters and setter
	private any function _getRulesEngineConditionService() {
		return _rulesEngineConditionService;
	}
	private void function _setRulesEngineConditionService( required any rulesEngineConditionService ) {
		_rulesEngineConditionService = arguments.rulesEngineConditionService;
	}

}