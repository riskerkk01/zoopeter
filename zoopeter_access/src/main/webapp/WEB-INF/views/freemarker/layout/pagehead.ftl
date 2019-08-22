	<!-- Page Heading -->
	<div class="page-header">
		<h1 class="page-title">
			<#if pagelink == '/'>
				<a href="<@spring.url '${pagelink}' />">${pagetitle}</a>
			<#else>
				<a href="<@spring.url '/${pagelink}/' />">${pagetitle}</a>
			</#if>
			<#if subtitle??><#if subtitle != ''>&nbsp;&nbsp;<small>${subtitle}</small></#if></#if>
		</h1>
	</div>
