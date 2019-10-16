<#include "/layout/begin_frame.ftl">

	<#assign pagetitle="로그인">
	<#assign pagelink="login">
	<#assign subtitle="">

	<script type="text/javascript" language="javascript" src="<@spring.url '/scripts/sha256.js' />"></script>
	<script type="text/javascript">
	function Login()
	{
		if( $("#id").val() == "" ) 
		{
			alert("ID를 입력하여 주세요.");
			$("#id").focus();
			return false;
		}

		if( $("#passwd").val() == "" ) 
		{
			//alert("비밀번호를 입력하여 주세요.");
			$("#passwd").focus();
			return false;
		}
	
		$('#passwd_sha256').val( SHA256( $("#passwd").val() ) );
		$("#passwd").val('');
		//$("#loginform").action = "";
		return true;
		//$("#loginform").submit();
	}

	
	$(document).ready( function() {
		if( $("#id").val() == "" ) $("#id").focus();
		else $("#passwd").focus();
	});
	
	</script>
	<!-- Outer Row -->
	<div class="container">

	  	<div class="row">
            <div class="col col-login mx-auto">
              	<div class="text-center mb-6">
					Admin - zoopeter		
              	</div>
	
			
			<#if errmsg??>
			<div class="alert alert-danger" role="alert">  	
		  		${errmsg}
			</div>	
			</#if>
		
			<form id="loginform" name="loginform" class="card" action="loginact" onsubmit="return Login()" method="post">
				<input type="hidden" name="cmd" value="login">
				<input type="hidden" name="passwd_sha256" id="passwd_sha256" value="">
				<input type="hidden" name="returl" value="">
                <div class="card-body p-6">
					<div class="form-group">
                    	<label class="form-label">ID</label>
                    	<input type="text" class="form-control" id="id" name="id" aria-describedby="" placeholder="Enter ID" tabindex="1" >
                  	</div>
                  	<div class="form-group">
                    	<label class="form-label">
                      	Password
						<!--
                      	<a href="./forgot-password.html" class="float-right small">I forgot password</a>
						-->
                    	</label>
                    	<input type="password" class="form-control" id="passwd" name="passwd" placeholder="Password" tabindex="2" >
                  	</div>
                  	<div class="form-group">
                    	<label class="custom-control custom-checkbox">
                      	<input type="checkbox" class="custom-control-input" id="id_save" name="id_save" value="1"   tabindex="3" />
                      	<span class="custom-control-label">Remember me</span>
                    	</label>
                  	</div>
                  	<div class="form-footer">
                    	<button type="submit" class="btn btn-primary btn-block" tabindex="4">Sign in</button>
                  	</div>
                </div>
           </form>
		

				
<#include "/layout/end_frame.ftl">