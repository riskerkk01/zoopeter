<#include "/layout/begin_app.ftl">
	<div style="margin:30px;margin-top:40px;" class="text-center">
	
		<#if SESSION_USERAUTH?exists>
		<p> user_id is ${SESSION_USERAUTH.user_id} </p>
		<p> user_nm is ${SESSION_USERAUTH.user_nm} </p>
		<p> auth_lvl is ${SESSION_USERAUTH.auth_lvl}</p>
		</#if>
		

	</div>
	<div class="text-center" style="margin-top:40px;">
			<a href="/logout_app" class="btn btn-danger">로그아웃</a>
	</div>
					
<#include "/layout/end_app.ftl">