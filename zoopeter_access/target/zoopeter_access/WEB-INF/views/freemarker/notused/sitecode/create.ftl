<#include "/layout/begin.ftl">

	<#assign pagetitle="사이트코드 관리"> 
	<#assign pagelink="sitecode">
	<#assign subtitle="등록">

	<#include "/layout/pagehead.ftl">
		
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">등록하기</h3>
			</div>
			<div class="card-body">
				<form id="addform" name="addform" action="" method="post" class="form-horizontal sitecode-form" role="form">	
				<div class="form-group">						 
					<label for="name" class="form-label">카테고리</label>
					<select name="category" class="form-control xform-control-sm"> 
						<option value="trackersite"  >trackersite</option>
						<option value="gamecode" >gamecode</option>
					</select>
				</div>
				<div class="form-group">						 
					<label for="code" class="form-label">ID</label>
					<input type="text" class="form-control" id="code" name="code" placeholder="CODE를 입력하여 주세요" value="">
				</div>
				<div class="form-group">						 
					<label for="value" class="form-label">값</label>
					<input type="text" class="form-control" id="value" name="value" placeholder="값을 입력하여 주세요" value="">
				</div>		
				<div class="form-group">						 
					<label for="sorder" class="form-label">순서</label>
					<input type="text" class="form-control" id="sorder" name="sorder" placeholder="순서를 입력하여 주세요" value="">
				</div>		
			
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/sitecode/list' />" class="btn btn-primary">목록</a>
				<a href="javascript:AddAct()" class="btn btn-success">저장</a>
			</div>
		</div>
		
		<script type='text/javascript'>
		function AddAct()
		{
			var tf = document.addform;
			if( tf.code.value == '' ) 
			{
				alert('CODE를 입력하여 주세요.');
				tf.code.focus();
				return;
			}				
			if( tf.value.value == '' ) 
			{
				alert('값을 입력하여 주세요.');
				tf.value.focus();
				return;
			}
			
			if( confirm('저장하시겠습니까?') == false ) return;

			tf.submit();
		}
		</script>
		
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">