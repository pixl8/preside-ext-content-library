<cfoutput>

	<div class="widget-box">
		<div class="widget-header">
			<h4 class="widget-title lighter smaller">
				<i class="fa fa-fw fa-align-left"></i>
				#( prc.recordLabel ?: '' )#
			</h4>
		</div>

		<div class="widget-body">
			<div class="widget-main padding-20">
				#( args.renderedContent ?: "" )#
			</div>
		</div>
	</div>
</cfoutput>