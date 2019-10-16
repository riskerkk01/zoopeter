<#include "/layout/begin.ftl">

	<#assign pagetitle="관리자 관리 ">
	<#assign pagelink="admin">
	<#assign subtitle="수정">

	<#include "/layout/pagehead.ftl"> 

	<#if ADMIN??>
		<script type="text/javascript" language="javascript" src="<@spring.url '/scripts/sha256.js' />"></script>
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">수정하기 - ${ADMIN.name}</h3>
			</div>
			<div class="card-body">
				<form id="addform" name="addform" action="" method="post" class="form-horizontal admin-form" role="form">	
				<input type="hidden" name="passwd_sha256" id="passwd_sha256" value="">
				<div class="form-group">
					<label for="type" class="form-label">타입</label>
					<select name="type" class="form-control">
                        <option value="1" <#if ADMIN.type == 1>selected</#if> >관리자</option>
                        <option value="2" <#if ADMIN.type == 2>selected</#if>>매체</option>
                    </select>
				</div>
				<div class="form-group">
					<label for="type" class="form-label">매체선택(타입이 매체일때만)</label>
					<select name="publisherid" class="form-control">
						<option value="0" >선택하세요</option>
						<#if PUBLISHERLIST?has_content>
							<#list PUBLISHERLIST as PUBLISHER>
								<option value="${PUBLISHER.publisherid}" <#if PUBLISHER.publisherid == ADMIN.publisherid>selected</#if> >${PUBLISHER.name} - ${PUBLISHER.code}</option>
							</#list>
						</#if>
                    </select>
				</div>		
				<div class="form-group">
					<label for="state" class="form-label">상태</label>
					<select name="state" class="form-control">
                        <option value="0" <#if ADMIN.state != 1>selected</#if> >사용중</option>
                        <option value="1" <#if ADMIN.state == 1>selected</#if> >사용중지</option>
                    </select>
				</div>
				<div class="form-group">						 
					<label for="name" class="form-label">이름</label>
					<input type="text" class="form-control" id="name" name="name" placeholder="이름을 입력하여 주세요" value="${ADMIN.name}">
				</div>
				<div class="form-group">						 
					<label for="id" class="form-label">ID</label>
					<input type="text" class="form-control" id="id" name="id" placeholder="ID를 입력하여 주세요" value="${ADMIN.id}" readonly>
				</div>
				<div class="form-group">						 
					<label for="passwd" class="form-label">비밀번호</label>
					<input type="password" class="form-control" id="passwd" name="passwd" placeholder="비밀번호를 입력하여 주세요(변경시에만)" value="">
				</div>		


				<div class="form-group">						 
					<label for="description" class="form-label">설명</label>
					<input type="text" class="form-control" id="description" name="description" placeholder="설명을 입력하여 주세요" value="${ADMIN.description}">
				</div>
				
				</form>
			</div>
			<div class="card-footer text-center"> 
				<a href="<@spring.url '/admin/list' />" class="btn btn-primary">목록</a>
				<a href="javascript:AddAct()" class="btn btn-success">저장</a>
				<a href="javascript:DeleteAct()" class="btn btn-danger">삭제</a>
			</div>
		</div>
		<form id="deleteform" name="deleteform" action="<@spring.url '/admin/delete/' />${ADMIN.adminid}" method="post">
			<input type="hidden" name="adminid" value="${ADMIN.adminid}">
		</form>
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
			if( tf.passwd.value != '' ) 
			{
				$('#passwd_sha256').val( SHA256( $("#passwd").val() ) );
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
			<a href="<@spring.url '/admin/' />" class="btn btn-primary">목록으로</a>
		</div>
	</#if>
     
	<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">