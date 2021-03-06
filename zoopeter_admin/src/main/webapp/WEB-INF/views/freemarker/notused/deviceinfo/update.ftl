<#include "/layout/begin.ftl">


		<#assign pagetitle="단말기 정보 수정 ">
		<#assign pagelink="deviceinfo">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">
		
			<#if DEVICEINFO??>
			
			<form id="deleteform" name="deleteform" action="<@spring.url '/deviceinfo/delete/' />${DEVICEINFO.device_id}" method="post">
				<input type="hidden" name="device_id" value="${DEVICEINFO.device_id}">
				
			</form>
			<form id="updateform" name="updateform" action="" method="post" class="form-horizontal" role="form">
			
			<input type="hidden" name="device_id" value="${DEVICEINFO.device_id}">
			<fieldset>
			
				<div class="panel panel-default">
					<div class="panel-heading">기본정보</div>
					<div class="panel-body">
	
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="device_nm" class="col-xs-2 control-label">단말기명 <em>*</em></label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="device_nm" name="device_nm" placeholder="단말기명을 입력하여 주세요" value="${DEVICEINFO.device_nm}">
									</div>
								</div>
							</div>					
							<div class="col-xs-12">
								<div class="form-group">
									<label for="device_type" class="col-xs-2 control-label">단말기 유형</label>
									<div class="col-xs-3">
										<SELECT id="device_type" name="device_type" class="form-control" >
											<OPTION value="">선택하세요</OPTION>
											<#if CODEINFOS?has_content>
												<#list CODEINFOS as CODEINFO>
													<#if CODEINFO.code_type == "deviceinfo_device_type">
														<#if CODEINFO.code_name == DEVICEINFO.device_type>
														<OPTION value="${CODEINFO.code_name}" selected>${CODEINFO.code_name}</OPTION>
														<#else>
														<OPTION value="${CODEINFO.code_name}" >${CODEINFO.code_name}</OPTION>
														</#if>
													</#if>
												</#list>
											</#if>
										</SELECT>
	
									</div>
								</div>
							</div>		
							<div class="col-xs-12">
								<div class="form-group">
									<label for="device_vendor" class="col-xs-2 control-label">단말기 제조사</label>
									<div class="col-xs-3">
										<SELECT id="device_vendor" name="device_vendor" class="form-control" >
											<OPTION value="">선택하세요</OPTION>
											<#if CODEINFOS?has_content>
												<#list CODEINFOS as CODEINFO>
													<#if CODEINFO.code_type == "deviceinfo_device_vendor">
														<#if CODEINFO.code_name == DEVICEINFO.device_vendor>
														<OPTION value="${CODEINFO.code_name}" selected>${CODEINFO.code_name}</OPTION>
														<#else>
														<OPTION value="${CODEINFO.code_name}" >${CODEINFO.code_name}</OPTION>
														</#if>
													</#if>
												</#list>
											</#if>
										</SELECT>
									</div>
								</div>
							</div>										
							<div class="col-xs-12">
								<div class="form-group">
									<label for="os_type" class="col-xs-2 control-label">OS 유형</label>
									<div class="col-xs-3">
										<SELECT id="os_type" name="os_type" class="form-control" >
											<OPTION value="">선택하세요</OPTION>
											<#if CODEINFOS?has_content>
												<#list CODEINFOS as CODEINFO>
													<#if CODEINFO.code_type == "deviceinfo_os_type">
														<#if CODEINFO.code_name == DEVICEINFO.os_type>
														<OPTION value="${CODEINFO.code_name}" selected>${CODEINFO.code_name}</OPTION>
														<#else>
														<OPTION value="${CODEINFO.code_name}" >${CODEINFO.code_name}</OPTION>
														</#if>
													</#if>
												</#list>
											</#if>
										</SELECT>
									</div>
								</div>
							</div>			
							<div class="col-xs-12">
								<div class="form-group">
									<label for="os_ver" class="col-xs-2 control-label">OS 버젼</label>
									<div class="col-xs-3">
										<SELECT id="os_ver" name="os_ver" class="form-control" >
											<OPTION value="">선택하세요</OPTION>
											<#if CODEINFOS?has_content>
												<#list CODEINFOS as CODEINFO>
													<#if CODEINFO.code_type == "deviceinfo_os_ver">
														<#if CODEINFO.code_name == DEVICEINFO.os_ver>
														<OPTION value="${CODEINFO.code_name}" selected>${CODEINFO.code_name}</OPTION>
														<#else>
														<OPTION value="${CODEINFO.code_name}" >${CODEINFO.code_name}</OPTION>
														</#if>
													</#if>
												</#list>
											</#if>
										</SELECT>
									</div>
								</div>
							</div>		
						</div>
					</div>
				</div>
	
				<div style='margin-top:10px' class="row">
					<div class="col-xs-12 text-center">
						<a href="<@spring.url '/deviceinfo/list' />" class="btn btn-default">목록</a>
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
				if( tf.device_nm.value == '' ) 
				{
					alert('단말기명을 입력하여 주세요.');
					tf.device_nm.focus();
					return;
				}
				if( confirm('저장하시겠습니까?') == false ) return;
				tf.submit();
			}
			$(function () {
			});
			</script>
			
			<#else>
				<div class="alert alert-danger" role="alert">  	
		  			분류코드 정보가 없습니다.		
				</div>	
				<div class="text-center">
					<a href="<@spring.url '/deviceinfo/' />" class="btn btn-default">목록으로</a>
				</div>
			</#if>
		
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">