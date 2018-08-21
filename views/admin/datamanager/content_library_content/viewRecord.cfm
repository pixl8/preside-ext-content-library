<cfoutput>
	<div class="row">
		<div class="col-md-6">
			<div class="widget-box">
				<div class="widget-header">
					<h4 class="widget-title lighter smaller">
						<i class="fa fa-fw fa-align-left"></i>
						#( prc.objectTitle ?: '' )#
					</h4>
				</div>

				<div class="widget-body">
					<div class="widget-main padding-20">
						#( args.renderedContent ?: "" )#
					</div>
				</div>
			</div>
		</div>
		<div class="col-md-6">
			<div class="widget-box">
				<div class="widget-header">
					<h4 class="widget-title lighter smaller">
						<i class="fa fa-fw fa-map-signs"></i>
						#translateResource( "preside-objects.content_library_content:field.alternatives.title" )#
					</h4>
					<div class="widget-toolbar">
						<a href="#args.addAlternativeLink#" title="#HtmlEditFormat( translateResource( "preside-objects.content_library_content:add.alternative.button" ) )#">
							<i class="fa fa-fw fa-plus"></i>
						</a>
						<a href="#args.sortAlternativesLink#" title="#HtmlEditFormat( translateResource( "preside-objects.content_library_content:sort.alternatives.button" ) )#">
							<i class="fa fa-fw fa-sort-amount-asc"></i>
						</a>
					</div>
				</div>

				<div class="widget-body">
					<div class="widget-main padding-20">
						#( args.alternativesTable ?: "" )#

						<div class="clearfix">
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</cfoutput>