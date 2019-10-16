<#include "/layout/begin.ftl">


		<#assign pagetitle="테스트 등록">
		<#assign pagelink="testmas">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">
		
			<script language="javascript">
	        $(function () {
	            $("input:text[name*=_dt]").datepicker({
	                dateFormat: 'yy-mm-dd',
	                prevText: '<i class="fa fa-chevron-left"></i>',
	                nextText: '<i class="fa fa-chevron-right"></i>',
	                showButtonPanel: false,
	                beforeShow: function(input, inst) {
	                    var newclass = 'admin-form';
	                    var themeClass = $(this).parents('.admin-form').attr('class');
	                    var smartpikr = inst.dpDiv.parent();
	                    if (!smartpikr.hasClass(themeClass)) {
	                        inst.dpDiv.wrap('<div class="' + themeClass + '"></div>');
	                    }
	                }
	            });
			});
			</script>
			
			
		
			<div class="panel">
				<div class="panel-heading">
					<ul class="nav panel-tabs-border panel-tabs panel-tabs-left">
						<li class="active" id="tab_baseinfo">
							<a  href="javascript:ChangeTab('baseinfo')" >기본 정보</a>
						</li>
						<li class="" id="tab_deviceinfo">
							<a  href="javascript:ChangeTab('deviceinfo')">대상 단말 정보</a>
						</li>
						<li class="" id="tab_testcase">
							<a  href="javascript:ChangeTab('testcase')">테스트 케이스</a>
						</li>
					</ul>
				</div>
				<div class="panel-body bg-light">
					<form id="addform" name="addform" action="" method="post" enctype="multipart/form-data" class="form-horizontal admin-form" role="form">
					
					<div class="tab-content pn br-n">
						<div class="tab-pane active" id="baseinfo">
						
							<div class="row ">
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_nm" class="col-xs-2 control-label">테스트 명</label>
										<div class="col-xs-8">
											<input type="text" class="form-control" id="test_nm" name="test_nm" placeholder="테스트명을 입력하여 주세요" value="">
										</div>
									</div>
								</div>	
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_dt" class="col-xs-2 control-label">수행일자 / 수행시 / 횟수</label>
										<div class="col-xs-3">
											<input type="text" id="test_dt" name="test_dt" class="form-control xinput-sm" value="" placeholder="수행일자">
										</div>
										<div class="col-xs-2">
											<select name="test_tm" class="form-control">
											<#list 0..23 as xtime>
											<option value="${xtime}">${xtime} 시</option>
											</#list>
											</select>
										</div>
										<div class="col-xs-2">
											<select name="test_cnt" class="form-control">
											<#list 1..100 as xtime>
											<option value="${xtime}">${xtime} 회</option>
											</#list>
											</select>
										</div>
									</div>
								</div>
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_nm" class="col-xs-2 control-label">고객사</label>
										<div class="col-xs-4">
											<select name="cust_id" class="form-control">
											<#if CUSTINFOLIST?has_content>
												<#list CUSTINFOLIST as CUSTINFO>
													<option value="${CUSTINFO.cust_id}">${CUSTINFO.cust_nm}</option>
												</#list>
											</#if>
											</select>
										</div>
									</div>
								</div>
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_type" class="col-xs-2 control-label">테스트 유형</label>
										<div class="col-xs-4">
											<select name="test_type" class="form-control">
											<option value="PF">성능</option>
											<option value="CO">호환성</option>
											</select>
										</div>
									</div>
								</div>														
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_measuer" class="col-xs-2 control-label">측정항목</label>
										<div class="col-xs-8 " >
		                          			<div class="checkbox-custom mt10 mb5" style="float:left;margin-right:20px;">
												<input id="measure1" type="checkbox" name="measure" value="CPU" >
												<label for="measure1" style="padding-top:3px;">CPU사용률</label>
											</div>
		                          			<div class="checkbox-custom mt10 mb5" style="float:left;margin-right:20px;">
												<input id="measure2" type="checkbox" name="measure" value="RAM" >
												<label for="measure2"  style="padding-top:3px;">RAM사용률</label>
											</div>
		                          			<div class="checkbox-custom mt10 mb5" style="float:left;margin-right:20px;">
												<input id="measure3" type="checkbox" name="measure" value="TMP" >
												<label for="measure3"  style="padding-top:2px;">발열량</label>
											</div>																						
			               		                
										</div>
									</div>
								</div>
		
								<div class="col-xs-12">
									<div class="form-group">
										<label for="code_val" class="col-xs-2 control-label">앱 실행파일</label>
										<div class="col-xs-8">
											<label class="field prepend-icon file">
				                                <span class="button">파일 선택</span>
				                                <input type="file" class="gui-file" name="uploadfile" id="uploadfile" onChange="document.getElementById('uploadfile_t').value = this.value;">
				                                <input type="text" class="gui-input" id="uploadfile_t" placeholder="업로드 할 파일을 선택하세요">
				                                <label class="field-icon"><i class="fa fa-upload"></i></label>
				                            </label>
										</div>
									</div>
								</div>
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_desc" class="col-xs-2 control-label">설명</label>
										<div class="col-xs-8">
											<textarea name="test_desc" id="test_desc" class="form-control" style="height:150px;"></textarea>
										</div>
									</div>
								</div>
								<div class="col-xs-12">
									<div class="form-group">
										<label for="test_type" class="col-xs-2 control-label">테스트 상태</label>
										<div class="col-xs-2">
											<select name="test_status" class="form-control">
											<option value="I">등록중</option>
											<!--<option value="W">대기</option>-->
											</select>
										</div>
									</div>
								</div>	
																					
							</div>
						</div>
						<div class="tab-pane" id="deviceinfo">
							<#if VENDORLIST?has_content>
								<#list VENDORLIST as VENDOR>
								<div class="row">
									<div class="form-group">
										<label for="test_nm" class="col-xs-2 control-label">${VENDOR.device_vendor}</label>
										<div class="col-xs-10">

											<#if DEVICEINFOLIST?has_content>
												<#list DEVICEINFOLIST as DEVICEINFO>
													<#if DEVICEINFO.device_vendor = VENDOR.device_vendor>
				                          			<div class="col-xs-2 checkbox-custom mt10 mb5" style="float:left;margin-right:20px;">
														<input id="deviceinfo_${DEVICEINFO.device_id}" type="checkbox" name="deviceinfos" value="${DEVICEINFO.device_id}" class="devicecheckbox">
														<label for="deviceinfo_${DEVICEINFO.device_id}"  style="padding-top:2px;">${DEVICEINFO.device_nm}</label>
													</div>
													</#if>
												</#list>
											</#if>
										</div>
									</div>
								</div>
								<hr class="short alt">
								</#list>
							</#if>
					
						</div>
						<div class="tab-pane" id="testcase">
						수정페이지에서 처리하는게 좋을듯.
						</div>						
					</div>
				</div>
			</div>

			<div style='margin-top:10px' class="row">
				<div class="col-xs-12 text-center">
					<a href="<@spring.url '/testmas/list' />" class="btn btn-default">목록</a>
					<a href="javascript:AddAct()" class="btn btn-success">저장</a>
				</div>
			</div>
			
			</form>
		
		
			<script type='text/javascript'>
			function AddAct()
			{
				var tf = document.addform;
				if( tf.test_nm.value == '' ) 
				{
					ChangeTab('baseinfo');
					alert('테스트명을 입력하여 주세요.');
					tf.test_nm.focus();
					return;
				}			
				if( tf.test_dt.value == '' ) 
				{
					ChangeTab('baseinfo');
					alert('수행일자를 입력하여 주세요.');
					tf.test_dt.focus();
					return;
				}

				var is_cpu = tf.measure[0].checked;
				var is_ram = tf.measure[1].checked;
				var is_tmp = tf.measure[2].checked;
				if( is_cpu == false && is_ram == false && is_tmp == false )
				{
					ChangeTab('baseinfo');
					alert( '측정항목을 선택하여 주세요' );
					return;
				}
				if( tf.uploadfile.value == '' )
				{
					ChangeTab('baseinfo');
					alert('앱실행파일을 입력하여 주세요.');
					tf.uploadfile.focus();
					return;
				}
				
				if( tf.test_desc.value == '' ) 
				{
					ChangeTab('baseinfo');
					alert('설명을 입력하여 주세요.');
					tf.test_desc.focus();
					return;
				}			
				
				var devicecheckbox = $('.devicecheckbox:checkbox:checked').map( function() { return this.value; } ).get().join(',');
				if( devicecheckbox == '' )
				{
					ChangeTab('deviceinfo');
					alert('테스트 대상 단말을 선택하여 주세요');
					return ;
				}
				
				if( confirm('저장하시겠습니까?') == false ) return;
				tf.submit();
			}
			function ChangeTab( tabname )
			{
				$('#baseinfo').hide();
				$('#deviceinfo').hide();
				$('#testcase').hide();
				
				$('#'+tabname).show();
				
				$('#tab_baseinfo').removeClass('active');
				$('#tab_deviceinfo').removeClass('active');
				$('#tab_testcase').removeClass('active');
				
				$('#tab_'+tabname).addClass('active');
			}
			$(function () {
			});
			</script>
			
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">