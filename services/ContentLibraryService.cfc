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

	public string function getEmailContent( required string itemId ) {
		var conditionService        = _getRulesEngineConditionService();
		var conditionalAlternatives = $getPresideObject( "email_content_library_conditional_alternative" ).selectData(
			  filter       = { email_content_library_content = arguments.itemId }
			, selectFields = [ "condition", "content" ]
			, orderBy      = "sort_order"
		);

		for( var alternative in conditionalAlternatives ) {
			if ( conditionService.evaluateCondition( alternative.condition, "webrequest" ) ) {
				return alternative.content;
			}
		}

		var record = $getPresideObject( "email_content_library_content" ).selectData(
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

	public boolean function emailContentHasAlternatives( required string itemId ) {
		return $getPresideObject( "email_content_library_conditional_alternative" ).dataExists(
			filter = { email_content_library_content = arguments.itemId }
		);
	}

	public void function validateRichContent(
		  required string recordId
		, required string richContent
		, required any    validationResult
	) {
		var widgetPattern = "\{\{widget:contentLibraryContent:(.*?):widget\}\}";
		var regexMatched  = ReFind( widgetPattern, arguments.richContent, 1, true, "all" );

		if ( Len( Trim( arguments.recordId ) ) && ArrayLen( regexMatched ) ) {
			for ( var matched in regexMatched ) {
				for ( var item in matched.match ?: [] ) {
					var contentItem = UrlDecode( item );

					if ( IsJSON( contentItem ) ) {
						contentItem = DeserializeJSON( contentItem );
						contentItem = contentItem.content_item ?: "";

						if ( contentItem == arguments.recordId ) {
							arguments.validationResult.addError(
								  fieldName = "content"
								, message   = "preside-objects.content_library_content:field.content.selected.self.error"
							);
							return;
						}
					}
				}
			}
		}
	}

// private getters and setter
	private any function _getRulesEngineConditionService() {
		return _rulesEngineConditionService;
	}
	private void function _setRulesEngineConditionService( required any rulesEngineConditionService ) {
		_rulesEngineConditionService = arguments.rulesEngineConditionService;
	}

}