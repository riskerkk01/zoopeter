<#include "/layout/begin.ftl">

		<#assign pagetitle="사용자 정보 수정">
		<#assign pagelink="userauth">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">
		
		<#if USERAUTH??>
			<form id="deleteform" name="deleteform" action="<@spring.url '/userauth/delete/' />${USERAUTH.user_no}" method="post">
				<input type="hidden" name="user_no" value="${USERAUTH.user_no}">
				
			</form>
			<form id="updateform" name="updateform" action="" method="post" class="form-horizontal" role="form">
			<input type="hidden" name="user_no" value="${USERAUTH.user_no}">
			
			<fieldset>
			
				<div class="panel panel-default">
					<div class="panel-heading">기본정보</div>
					<div class="panel-body">
	
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="user_nm" class="col-xs-3 control-label">사용자명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="user_nm" name="user_nm" placeholder="사용자명을 입력하여 주세요" value="${USERAUTH.user_nm}" readonly>
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="user_id" class="col-xs-3 control-label">사용자ID</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="user_id" name="user_id" placeholder="사용자ID를 입력하여 주세요" value="${USERAUTH.user_id}" readonly>
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="email" class="col-xs-3 control-label">이메일주소</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="email" name="email" placeholder="이메일주소를 입력하여 주세요" value="${USERAUTH.email}" readonly>
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="dept_nm" class="col-xs-3 control-label">부서명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="dept_nm" name="dept_nm" placeholder="부서명을 입력하여 주세요" value="${USERAUTH.dept_nm}" readonly>
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="phone_no" class="col-xs-3 control-label">모바일</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="phone_no" name="phone_no" placeholder="부서명을 입력하여 주세요" value="${USERAUTH.phone_no}" readonly>
									</div>
								</div>
							</div>	
							<div class="col-xs-12">
								<div class="form-group">
									<label for="auth_lvl" class="col-xs-3 control-label">사용가능여부</label>
									<div class="col-xs-8">
										<#assign xxx = USERAUTH.auth_lvl>
										<select class="form-control" name="auth_lvl">
											<OPTION value="0" <#if xxx == 0>selected</#if> >권한없음</OPTOIN>
											<OPTION value="1" <#if xxx == 1>selected</#if> >일반사용자</OPTOIN>
											<OPTION value="2" <#if xxx == 2>selected</#if> >관리자</OPTOIN>
										</select>
										
									</div>
								</div>
							</div>						
							
						</div>
					</div>
				</div>
	
				<div style='margin-top:10px' class="row">
					<div class="col-xs-12 text-center">
						<a href="<@spring.url '/userauth/list' />" class="btn btn-default">목록</a>
						<a href="javascript:UpdateAct()" class="btn btn-success">저장</a>
						<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
					</div>
				</div>
				
			</form>
			
			<script type='text/javascript'>
			function DeleteAct()
			{
				if( confirm('삭제하시겠습니까?') == false ) return;
				document.deleteform.submit();
			}
			function UpdateAct()
			{
				var tf = document.updateform;
				if( confirm('저장하시겠습니까?') == false ) return;
				tf.submit();
			}
			$(function () {
			});
			</script>
		<#else>
			<div class="alert alert-danger" role="alert">  	
	  			사용자 정보가 없습니다.		
			</div>	
			<div class="text-center">
				<a href="<@spring.url '/userauth/' />" class="btn btn-default">목록으로</a>
			</div>
		</#if>
		
		<#include "/layout/pagefooter.ftl">
				      
<#include "/layout/end.ftl">