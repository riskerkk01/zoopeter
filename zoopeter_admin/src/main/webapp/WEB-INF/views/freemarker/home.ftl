<#include "/layout/begin.ftl">

	<#assign pagetitle="HOME">
	<#assign pagelink="/">
	<#assign subtitle="">
		
	<#include "/layout/pagehead.ftl">

		<div class="well">
				
			<#if serverTime?exists>
			<p> The time on the server is ${serverTime}. </p>
			</#if>
				
			<#if SESSION_USERAUTH?exists>
			<p> adminid is <#if SESSION_USERAUTH.adminid??>${SESSION_USERAUTH.adminid}</#if> </p>
			<p> id is <#if SESSION_USERAUTH.id??>${SESSION_USERAUTH.id}</#if> </p>
			<p> name is <#if SESSION_USERAUTH.name??>${SESSION_USERAUTH.name}</#if> </p>
			<p> description is <#if SESSION_USERAUTH.description??>${SESSION_USERAUTH.description}</#if></p>
			<p> publisherid is <#if SESSION_USERAUTH.description??>${SESSION_USERAUTH.publisherid}</#if></p>
			<p> type is <#if SESSION_USERAUTH.type??>${SESSION_USERAUTH.type}</#if> </p>
			<p> state is <#if SESSION_USERAUTH.state??>${SESSION_USERAUTH.state}</#if> </p>
			</#if>
				      
		</div>
	
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">