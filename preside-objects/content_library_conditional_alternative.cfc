/**
 * @datamanagerEnabled true
 */
component  {
	property name="content_library_content" relationship="many-to-one" relatedto="content_library_content" required=true uniqueindexes="content|1" ondelete="cascade" cloneable=true;
	property name="condition"               relationship="many-to-one" relatedto="rules_engine_condition"  required=true uniqueindexes="content|2"                    cloneable=true;

	property name="content"    type="string"  dbtype="text" required=true;
	property name="sort_order" type="numeric" dbtype="int"  required=true default="method:getNextSortOrder";

	property name="label" formula="${prefix}condition.condition_name";

	public numeric function getNextSortOrder( required struct data ) {
		var max = this.selectData(
			  selectFields = [ "max( sort_order ) as sort_order" ]
			, filter={ content_library_content=data.content_library_content ?: "" }
		);

		return Val( max.sort_order ) + 1;
	}
}