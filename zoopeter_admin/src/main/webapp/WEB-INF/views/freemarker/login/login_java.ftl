<#include "/layout/begin.ftl">

	<div style="display:none">
		<form name="frm" action="j_spring_security_check" method="post">
		<input type="text" name="username" placeholder="ID" required value="${SESSION_USERAUTH.user_no}">
		<input type="text" name="password" placeholder="PASSWORD" required value="${SESSION_USERAUTH.user_id}"></li>
		<input type="submit" value="로그인" onclick="document.frm.submit()"/>
		<input id = "remember_me" name ="_spring_security_remember_me" type = "checkbox"/>Remember me
		
		</form>
	</div>
	<script language="">
	document.frm.submit();
	</script>
	
<#include "/layout/end.ftl">