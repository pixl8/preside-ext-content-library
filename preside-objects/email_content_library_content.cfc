/**
 * @dataManagerEnabled     true
 * @dataManagerAllowDrafts true
 * @feature                emailContentLibrary
 */
component  {
	property name="label" uniqueindexes="contentlabel";
	property name="content" type="string" dbtype="text" required=true widgetCategories="email" linkPickerCategory="email" toolbar="email";

	property name="id"           adminRenderer="none";
	property name="datecreated"  adminRenderer="none";
	property name="datemodified" adminRenderer="none";

	property name="alternatives" relationship="one-to-many" relatedTo="email_content_library_conditional_alternative" relationshipKey="email_content_library_content" cloneable=true;
}