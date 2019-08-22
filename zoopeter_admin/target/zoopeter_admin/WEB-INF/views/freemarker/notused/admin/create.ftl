<#include "/layout/begin.ftl">

	<#assign pagetitle="관리자 관리"> 
	<#assign pagelink="admin">
	<#assign subtitle="등록">

	<#include "/layout/pagehead.ftl">
		
		<script type="text/javascript" language="javascript" src="<@spring.url '/scripts/sha256.js' />"></script>
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">등록하기</h3>
			</div>
			<div class="card-body">
				<form id="addform" name="addform" action="" method="post" class="form-horizontal admin-form" role="form">	
				<input type="hidden" name="passwd_sha256" id="passwd_sha256" value="">
				<div class="form-group">
					<label for="type" class="form-label">타입</label>
					<select name="type" class="form-control">
                        <option value="1" >관리자</option>
                        <option value="2" >매체</option>
                    </select>
				</div>
				<div class="form-group">
					<label for="type" class="form-label">매체선택(타입이 매체일때만)</label>
					<select name="publisherid" class="form-control">
						<option value="0" >선택하세요</option>
						<#if PUBLISHERLIST?has_content>
							<#list PUBLISHERLIST as PUBLISHER>
								<option value="${PUBLISHER.publisherid}">${PUBLISHER.name} - ${PUBLISHER.code}</option>
							</#list>
						</#if>
                    </select>
                    
				</div>		
		
				<div class="form-group">						 
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하여 주세요" value="">
				</div>
				<div class="form-group">						 
					<label for="id" class="form-label">ID</label>
					<input type="text" class="form-control" id="id" name="id" placeholder="ID를 입력하여 주세요" value="">
				</div>
				<div class="form-group">						 
					<label for="passwd" class="form-label">비밀번호</label>
					<input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호를 입력하여 주세요" value="">
				</div>		


				<div class="form-group">						 
					<label for="description" class="form-label">설명</label>
					<input type="text" class="form-control" id="description" name="description" placeholder="설명을 입력하여 주세요" value="">
				</div>
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/admin/list' />" class="btn btn-primary">목록</a>
				<a href="javascript:AddAct()" class="btn btn-success">저장</a>
			</div>
		</div>
		
		<script type='text/javascript'>
		function AddAct()
		{
			var tf = document.addform;
			if( tf.id.value == '' ) 
			{
				alert('ID를 입력하여 주세요.');
				tf.id.focus();
				return;
			}				
			if( tf.name.value == '' ) 
			{
				alert('이름을 입력하여 주세요.');
				tf.name.focus();
				return;
			}
			if( tf.passwd.value == '' ) 
			{
				alert('비밀번호를 입력하여 주세요.');
				tf.passwd.focus();
				return;
			}
			
			if( confirm('저장하시겠습니까?') == false ) return;
			
			$('#passwd_sha256').val( SHA256( $("#passwd").val() ) );
			tf.submit();
		}
		</script>
		
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">