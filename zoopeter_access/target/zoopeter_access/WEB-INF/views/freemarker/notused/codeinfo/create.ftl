<#include "/layout/begin.ftl">


		<#assign pagetitle="분류코드 등록">
		<#assign pagelink="codeinfo">
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
								<label for="code_type" class="col-xs-2 control-label">분류코드</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="code_type" name="code_type" placeholder="분류코드를 입력하여 주세요" value="">
								</div>
							</div>
						</div>					
						<div class="col-xs-12">
							<div class="form-group">
								<label for="code_name" class="col-xs-2 control-label">분류명</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="code_name" name="code_name" placeholder="분류명을 입력하여 주세요" value="">
								</div>
							</div>
						</div>

						<div class="col-xs-12">
							<div class="form-group">
								<label for="code_val" class="col-xs-2 control-label">분류설명</label>
								<div class="col-xs-8">
									<input type="text" class="form-control" id="code_val" name="code_val" placeholder="분류 설명을 입력하여 주세요" value="">
								</div>
							</div>
						</div>
						<div class="col-xs-12">
							<div class="form-group">
								<label for="view_seq" class="col-xs-2 control-label">노출순서</label>
								<div class="col-xs-2">
									<input type="text" class="form-control" id="view_seq" name="view_seq" placeholder="노출순서를 입력하여 주세요" value="">
								</div>
							</div>
						</div>
												
					</div>
				</div>
			</div>

			<div style='margin-top:10px' class="row">
				<div class="col-xs-12 text-center">
					<a href="<@spring.url '/codeinfo/list' />" class="btn btn-default">목록</a>
					<a href="javascript:AddAct()" class="btn btn-success">저장</a>
				</div>
			</div>
			
			</form>
		
			<script type='text/javascript'>
			function AddAct()
			{
				var tf = document.addform;
				if( tf.code_type.value == '' ) 
				{
					alert('분류코드를 입력하여 주세요.');
					tf.code_type.focus();
					return;
				}			
				if( tf.code_name.value == '' ) 
				{
					alert('분류명을 입력하여 주세요.');
					tf.code_name.focus();
					return;
				}
	
				if( tf.code_val.value == '' ) 
				{
					alert('분류셜명을 입력하여 주세요.');
					tf.code_val.focus();
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