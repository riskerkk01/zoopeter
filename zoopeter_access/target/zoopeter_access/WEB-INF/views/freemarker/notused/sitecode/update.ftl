<#include "/layout/begin.ftl">

	<#assign pagetitle="사이트코드 관리 ">
	<#assign pagelink="sitecode">
	<#assign subtitle="수정">

	<#include "/layout/pagehead.ftl"> 

	<#if SITECODE??>
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">수정하기 - ${SITECODE.code}</h3>
			</div>
			<div class="card-body"> 
				<form id="updateform" name="updateform" action="" method="post" class="form-horizontal sitecode-form" role="form">	
				<div class="form-group">						 
					<label for="name" class="form-label">카테고리</label>
					<select name="category" class="form-control xform-control-sm" onChange="document.sform.submit()"> 
						<option value="trackersite" <#if SITECODE.category = 'trackersite'>selected</#if> >trackersite</option>
						<option value="gamecode" <#if SITECODE.category = 'gamecode'>selected</#if>>gamecode</option>
					</select>					
				</div>
				<div class="form-group">						 
					<label for="code" class="form-label">CODE</label>
					<input type="text" class="form-control" id="code" name="code" placeholder="CODE를 입력하여 주세요" value="${SITECODE.code}" >
				</div>
				<div class="form-group">						 
					<label for="value" class="form-label">값</label>
					<input type="text" class="form-control" id="value" name="value" placeholder="값을 입력하여 주세요" value="${SITECODE.value}" >
				</div>  
				<div class="form-group">						 
					<label for="sorder" class="form-label">순서</label>
					<input type="text" class="form-control" id="sorder" name="sorder" placeholder="순서를 입력하여 주세요" value="${SITECODE.sorder}" >
				</div>  				
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/sitecode/list' />" class="btn btn-primary">목록</a>
				<a href="javascript:UpdateAct()" class="btn btn-success">저장</a>
				<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
			</div>
		</div>
		<form id="deleteform" name="deleteform" action="<@spring.url '/sitecode/delete/' />${SITECODE.seq}" method="post">
			<input type="hidden" name="seq" value="${SITECODE.seq}">
		</form>
		<script type='text/javascript'>
		function UpdateAct()
		{
			var tf = document.updateform;
			
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
		function DeleteAct()
		{
			if( confirm('삭제하시겠습니까?') == false ) return;
			document.deleteform.submit();
		}		
		</script>
		
	<#else>
		<div class="alert alert-danger" role="alert">  	
			정보가 없습니다.		
		</div>	
		<div class="text-center">
			<a href="<@spring.url '/sitecode/' />" class="btn btn-primary">목록으로</a>
		</div>
	</#if>
     
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">