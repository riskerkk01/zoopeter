<#include "/layout/begin.ftl">

		<#assign pagetitle="앱 정보 수정 ">
		<#assign pagelink="appinfo">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">

			<#if APPINFO??>
				<form id="deleteform" name="deleteform" action="<@spring.url '/appinfo/delete/' />${APPINFO.app_id}" method="post">
					<input type="hidden" name="app_id" value="${APPINFO.app_id}">
				</form>
				<div class="panel panel-default">
					<div class="panel-heading">기본정보</div>
					<div class="panel-body">
						<form id="updateform" name="updateform" action="" method="post" enctype="multipart/form-data" class="form-horizontal admin-form" role="form">
						<input type="hidden" name="app_id" value="${APPINFO.app_id}">
		
						<div class="row">
							<div class="col-xs-12">
								<div class="form-group">
									<label for="app_nm" class="col-xs-2 control-label">앱 이름</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="app_nm" name="app_nm" placeholder="앱 이름을 입력하여 주세요" value="${APPINFO.app_nm}">
									</div>
								</div>
							</div>


							<div class="col-xs-12">
								<div class="form-group">
									<label for="app_desc" class="col-xs-2 control-label">앱 설명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="app_desc" name="app_desc" placeholder="앱 설명을 입력하여 주세요" value="${APPINFO.app_desc}">
									</div>
								</div>
							</div>

							<div class="col-xs-12">
								<div class="form-group">
									<label for="app_ver" class="col-xs-2 control-label">앱 버젼</label>
									<div class="col-xs-4">
										<input type="text" class="form-control" id="app_ver" name="app_ver" placeholder="앱 버젼을 입력하여 주세요" value="${APPINFO.app_ver}">
									</div>
								</div>
							</div>
														
							<div class="col-xs-12">
								<div class="form-group">
									<label for="os_type" class="col-xs-2 control-label">앱 OS</label>
									<div class="col-xs-4">
										<SELECT id="app_os" name="app_os" class="form-control" >
											<OPTION value="">선택하세요</OPTION>
											<#if CODEINFOS?has_content>
												<#list CODEINFOS as CODEINFO>
													<#if CODEINFO.code_type == "deviceinfo_os_type">
												<OPTION value="${CODEINFO.code_name}" <#if CODEINFO.code_name == APPINFO.app_os>selected</#if> >${CODEINFO.code_name}</OPTION>
													</#if>
												</#list>
											</#if>
										</SELECT>
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="cust_id" class="col-xs-2 control-label">고객사</label>
									<div class="col-xs-4">
										<select name="cust_id" class="form-control">
										<option value="">고객사를 선택하세요</option>
										<#if CUSTINFOLIST?has_content>
											<#list CUSTINFOLIST as CUSTINFO>
												<option value="${CUSTINFO.cust_id}" <#if CUSTINFO.cust_id == APPINFO.cust_id>selected</#if> >${CUSTINFO.cust_nm}</option>
											</#list>
										</#if>
										</select>
									</div>
								</div>
							</div>			
							<div class="col-xs-12">
								<div class="form-group">
									<label for="uploadfile" class="col-xs-2 control-label">앱 아이콘 파일</label>
									<div class="col-xs-8">
										<label class="field prepend-icon file">
			                                <span class="button">파일 선택</span>
			                                <input type="file" class="gui-file" name="uploadfile" id="uploadfile" onChange="SetThumbnail(this.value);document.getElementById('uploadfile_t').value = this.value;">
			                                <input type="text" class="gui-input" id="uploadfile_t" placeholder="업로드 할 파일을 선택하세요. 변경시에만 선택하세요.">
			                                <label class="field-icon"><i class="fa fa-upload"></i></label>
			                            </label>
									</div>
								</div>
								<div class="form-group" id="thumb_layer" style="display:<#if APPINFO.app_image != ''>block<#else>none</#if>;">
									<div class="col-xs-2">&nbsp;</div>
									<div class="col-xs-8">
										<#if APPINFO.app_image != ''>
										<img id="thumb_image" src="<@spring.url '/downloader/' />${APPINFO.app_image}" class="thumbnail" xwidth="60px">
										<#else>
										<img id="thumb_image" src="" class="thumbnail" xwidth="60px">
										</#if>													
										
									</div>
								</div>
								
							</div>
							
							
	
						</div>
						</form>
					</div>
				</div>
		
				<div style='margin-top:10px' class="row">
					<div class="col-xs-12 text-center">
						<a href="<@spring.url '/appinfo/list' />" class="btn btn-default">목록</a>
						<a href="javascript:UpdateAct()" class="btn btn-success">저장</a>
						<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
						
					</div>
				</div>
					
				
				
			<script type='text/javascript'>
			function SetThumbnail(path)
			{
				$('#thumb_layer').hide();
				$('#thumb_image').attr( 'src', path );
				$('#thumb_layer').show();
			}				
			function DeleteAct()
			{
				if( confirm('삭제하시겠습니까?') == false ) return;
				document.deleteform.submit();
			}
			function UpdateAct()
			{
				var tf = document.updateform;
				if( tf.app_nm.value == '' ) 
				{
					alert('앱 이름을 입력하여 주세요.');
					tf.app_nm.focus();
					return;
				}
				if( tf.app_ver.value == '' ) 
				{
					alert('앱 버젼을 입력하여 주세요.');
					tf.app_ver.focus();
					return;
				}
				if( tf.app_desc.value == '' ) 
				{
					alert('앱 설명을 입력하여 주세요.');
					tf.app_desc.focus();
					return;
				}
				if( tf.app_os.selectedIndex == -1 )
				{
					alert('앱 OS를 선택하여 주세요.');
					tf.app_os.focus();
					return;				
				}
				if( tf.cust_id.selectedIndex == -1 )
				{
					alert('고객사를 선택하여 주세요.');
					tf.cust_id.focus();
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
		 		앱 정보가 없습니다.		
			</div>	
			<div class="text-center">
				<a href="<@spring.url '/appinfo/' />" class="btn btn-default">목록으로</a>
			</div>
		</#if>
      
        <#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">