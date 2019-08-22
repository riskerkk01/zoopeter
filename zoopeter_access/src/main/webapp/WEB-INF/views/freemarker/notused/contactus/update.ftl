<#include "/layout/begin.ftl">

	<#assign pagetitle="Contactus 관리 ">
	<#assign pagelink="contactus">
	<#assign subtitle="수정">

	<#include "/layout/pagehead.ftl"> 

	<#if CONTACTUS??>
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">수정하기 - ${CONTACTUS.name}</h3>
			</div>
			<div class="card-body">
				<form id="updateform" name="updateform" action="" method="post" class="form-horizontal contactus-form" role="form">	
				<div class="form-group">						 
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하여 주세요" value="${CONTACTUS.name}" readonly>
				</div>
				<div class="form-group">						 
					<label for="email" class="form-label">CODE</label>
					<input type="text" class="form-control" id="email" name="email" placeholder="CODE를 입력하여 주세요" value="${CONTACTUS.email}" readonly>
				</div>
				<div class="form-group">						 
					<label for="subject" class="form-label">제목</label>
					<input type="text" class="form-control" id="subject" name="subject" placeholder="제목을 입력하여 주세요" value="${CONTACTUS.subject}" readonly>
				</div>  
				<div class="form-group">						 
					<label for="message" class="form-label">Message</label>
					<textarea name="message" id="message" class="form-control" readonly>${CONTACTUS.message}</textarea>
				</div>
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/contactus/list' />" class="btn btn-primary">목록</a>
				<!--<a href="javascript:UpdateAct()" class="btn btn-success">저장</a>-->
				<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
			</div>
		</div>
		<form id="deleteform" name="deleteform" action="<@spring.url '/contactus/delete/' />${CONTACTUS.seq}" method="post">
			<input type="hidden" name="seq" value="${CONTACTUS.seq}">
		</form>
		<script type='text/javascript'>
		function UpdateAct()
		{
			var tf = document.updateform;
			/*
			if( tf.code.value == '' ) 
			{
				alert('CODE를 입력하여 주세요.');
				tf.code.focus();
				return;
			}	
			*/			
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
			<a href="<@spring.url '/contactus/' />" class="btn btn-primary">목록으로</a>
		</div>
	</#if>
     
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">