<#include "/layout/begin.ftl">

		<#assign pagetitle="단말기 등록">
		<#assign pagelink="deviceinfo">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">

	
			<form id="addform" name="addform" action="" method="post" class="form-horizontal" role="form">
			
			<fieldset>
			
				<div class="panel panel-default">
					<div class="panel-heading">기본정보</div>
					<div class="panel-body">
	
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="device_nm" class="col-xs-2 control-label">단말기명 <em>*</em></label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="device_nm" name="device_nm" placeholder="단말기명을 입력하여 주세요" value="">
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
												<OPTION value="${CODEINFO.code_name}">${CODEINFO.code_name}</OPTION>
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
												<OPTION value="${CODEINFO.code_name}">${CODEINFO.code_name}</OPTION>
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
												<OPTION value="${CODEINFO.code_name}">${CODEINFO.code_name}</OPTION>
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
												<OPTION value="${CODEINFO.code_name}">${CODEINFO.code_name}</OPTION>
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
						<a href="javascript:AddAct()" class="btn btn-success">저장</a>
					</div>
				</div>
				
			</form>
			
			<script type='text/javascript'>
			function AddAct()
			{
				var tf = document.addform;
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
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">