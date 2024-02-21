/**
 * @datamanagerEnabled          true
 * @datamanagerGridFields       label,sort_order
 * @datamanagerDefaultSortOrder sort_order
 * @datamanagerSortable         true
 * @datamanagerSortField        sort_order
 * @feature                     emailContentLibrary
 */
component  {
	property name="email_content_library_content" relationship="many-to-one" relatedto="email_content_library_content" required=true uniqueindexes="content|1" ondelete="cascade" cloneable=true adminRenderer="none" batcheditable=false;
	property name="condition"               relationship="many-to-one" relatedto="rules_engine_condition"  required=true uniqueindexes="content|2"                    cloneable=true adminViewGroup="system" sortorder=0 batcheditable=false;

	property name="content"    type="string"  dbtype="text" required=true  adminRenderer="none" batcheditable=false widgetCategories="email" linkPickerCategory="email" toolbar="email";
	property name="sort_order" type="numeric" dbtype="int"  required=true default="method:getNextSortOrder"  adminRenderer="none" batcheditable=false;

	property name="label" formula="${prefix}condition.condition_name"  adminRenderer="none" batcheditable=false;

	public numeric function getNextSortOrder( required struct data ) {
		var max = this.selectData(
			  selectFields = [ "max( sort_order ) as sort_order" ]
			, filter={ email_content_library_content=data.email_content_library_content ?: "" }
		);

		return Val( max.sort_order ) + 1;
	}
}