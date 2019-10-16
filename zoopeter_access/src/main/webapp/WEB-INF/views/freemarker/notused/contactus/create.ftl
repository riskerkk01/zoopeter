<#include "/layout/begin.ftl">

	<#assign pagetitle="Contactus 관리"> 
	<#assign pagelink="contactus">
	<#assign subtitle="등록">

	<#include "/layout/pagehead.ftl">
		
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">등록하기</h3>
			</div>
			<div class="card-body">
				<form id="addform" name="addform" action="" method="post" class="form-horizontal contactus-form" role="form">	
				<div class="form-group">						 
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하여 주세요" value="">
				</div>
				<div class="form-group">						 
					<label for="code" class="form-label">ID</label>
					<input type="text" class="form-control" id="code" name="code" placeholder="CODE를 입력하여 주세요" value="">
				</div>
				<div class="form-group">						 
					<label for="postback_url" class="form-label">Postback URL</label>
					<input type="text" class="form-control" id="postback_url" name="postback_url" placeholder="postback_url을 입력하여 주세요" value="">
				</div>		
				<div class="form-group">						 
					<label for="event_url" class="form-label">Event URL</label>
					<input type="text" class="form-control" id="event_url" name="event_url" placeholder="event_url을 입력하여 주세요" value="">
				</div>		


				<div class="form-group">						 
					<label for="note" class="form-label">Note</label>
					<textarea name="note" id="note" class="form-control"></textarea>
				</div>
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/contactus/list' />" class="btn btn-primary">목록</a>
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
			if( tf.name.value == '' ) 
			{
				alert('이름을 입력하여 주세요.');
				tf.name.focus();
				return;
			}
			
			if( confirm('저장하시겠습니까?') == false ) return;

			tf.submit();
		}
		</script>
		
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">