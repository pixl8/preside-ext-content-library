/**
 * @dataManagerEnabled     true
 * @dataManagerAllowDrafts true
 */
component  {
	property name="label" uniqeindexes="contentlabel";
	property name="content" type="string" dbtype="text" required=true;
}