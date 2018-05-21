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
}