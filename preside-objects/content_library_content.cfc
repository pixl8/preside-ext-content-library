/**
 * @dataManagerEnabled     true
 * @dataManagerAllowDrafts true
 */
component  {
	property name="label" uniqeindexes="contentlabel";
	property name="content" type="string" dbtype="text" required=true;

	property name="id"           adminRenderer="none";
	property name="datecreated"  adminRenderer="none";
	property name="datemodified" adminRenderer="none";

	property name="alternatives" relationship="one-to-many" relatedTo="content_library_conditional_alternative" relationshipKey="content_library_content";
}