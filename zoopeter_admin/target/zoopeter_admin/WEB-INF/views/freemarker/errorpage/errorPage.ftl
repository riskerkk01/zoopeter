<#include "/layout/begin.ftl">

		<#assign pagetitle="Error">
		<#assign pagelink="/">
		<#assign subtitle="">
		
		<#include "/layout/pagehead.ftl">


			<div class="alert alert-danger">
				<#if errorMsg??>
					${errorMsg}	
				</#if>      
			</div>
			<div class="text-center">
				<a href="javascript:history.back()" class="btn btn-primary">돌아가기</a>
			</div>
		
		<#include "/layout/pagefooter.ftl">
      
      
      
<#include "/layout/end.ftl">