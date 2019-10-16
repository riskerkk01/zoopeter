<#include "/layout/begin.ftl">


		<#assign pagetitle="고객사 등록">
		<#assign pagelink="custinfo">
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
									<label for="cust_nm" class="col-xs-2 control-label">고객사명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="cust_nm" name="cust_nm" placeholder="고객사명을 입력하여 주세요" value="">
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="cust_mgr" class="col-xs-2 control-label">담당자명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="cust_mgr" name="cust_mgr" placeholder="담당자명을 입력하여 주세요" value="">
									</div>
								</div>
							</div>
							<div class="col-xs-12">
								<div class="form-group">
									<label for="igs_mgr" class="col-xs-2 control-label">IGS 담당자명</label>
									<div class="col-xs-8">
										<input type="text" class="form-control" id="igs_mgr" name="igs_mgr" placeholder="IGS 담당자명을 입력하여 주세요" value="">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
	
				<div style='margin-top:10px' class="row">
					<div class="col-xs-12 text-center">
						<a href="<@spring.url '/custinfo/list' />" class="btn btn-default">목록</a>
						<a href="javascript:AddAct()" class="btn btn-success">저장</a>
					</div>
				</div>
				
			</form>
			
			<script type='text/javascript'>
			function AddAct()
			{
				var tf = document.addform;
				if( tf.cust_nm.value == '' ) 
				{
					alert('고객사명을 입력하여 주세요.');
					tf.cust_nm.focus();
					return;
				}
				if( tf.cust_mgr.value == '' ) 
				{
					alert('담당자명을 입력하여 주세요.');
					tf.cust_mgr.focus();
					return;
				}
				if( tf.igs_mgr.value == '' ) 
				{
					alert('IGS 담당자명을 입력하여 주세요.');
					tf.igs_mgr.focus();
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