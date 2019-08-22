<#include "/layout/begin.ftl">

	<#assign pagetitle="매체 관리 ">
	<#assign pagelink="contactus">
	<#assign subtitle="수정">

	<#include "/layout/pagehead.ftl"> 

	<#if PUBLISHER??>
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">수정하기 - ${PUBLISHER.name}</h3>
			</div>
			<div class="card-body">
				<form id="updateform" name="updateform" action="" method="post" class="form-horizontal publisher-form" role="form">	
				<div class="form-group">						 
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하여 주세요" value="${PUBLISHER.name}">
				</div>
				<div class="form-group">						 
					<label for="code" class="form-label">CODE</label>
					<input type="text" class="form-control" id="code" name="code" placeholder="CODE를 입력하여 주세요" value="${PUBLISHER.code}" readonly>
				</div>
				<div class="form-group">						 
					<label for="postback_url" class="form-label">Postback URL</label>
					<input type="text" class="form-control" id="postback_url" name="postback_url" placeholder="Postback URL을 입력하여 주세요" value="${PUBLISHER.postback_url}">
				</div>
				<div class="form-group">						 
					<label for="event_url" class="form-label">Event URL</label>
					<input type="text" class="form-control" id="event_url" name="event_url" placeholder="Event URL을 입력하여 주세요" value="${PUBLISHER.event_url}">
				</div>
				<div class="form-group">						 
					<label for="note" class="form-label">Note</label>
					<textarea name="note" id="note" class="form-control">${PUBLISHER.note}</textarea>
				</div>
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/publisher/list' />" class="btn btn-primary">목록</a>
				<a href="javascript:UpdateAct()" class="btn btn-success">저장</a>
				<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
			</div>
		</div>
		<form id="deleteform" name="deleteform" action="<@spring.url '/publisher/delete/' />${PUBLISHER.publisherid}" method="post">
			<input type="hidden" name="publisherid" value="${PUBLISHER.publisherid}">
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
			if( tf.name.value == '' ) 
			{
				alert('이름을 입력하여 주세요.');
				tf.name.focus();
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
			<a href="<@spring.url '/publisher/' />" class="btn btn-primary">목록으로</a>
		</div>
	</#if>
     
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">