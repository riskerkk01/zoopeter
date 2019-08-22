<#include "/layout/begin.ftl">

		<#assign pagetitle="사용자 권한 관리">
		<#assign pagelink="userauth">
		<#assign subtitle="">
		<#if USERAUTHCOUNT??><#assign subtitle="( 총 : "+USERAUTHCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
	
			<div class="well">
				<div class="row">
					<div class="col-xs-9">
						<form action="" method="get" name="sform">
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="user_nm" <#if SUSERAUTH.searchtype = "user_nm">selected</#if> >사용자명</option>
										<option value="user_no"  <#if SUSERAUTH.searchtype = "user_no">selected</#if> >USER NO</option>
										<option value="user_id"  <#if SUSERAUTH.searchtype = "user_id">selected</#if> >USER ID</option>
										<option value="email"  <#if SUSERAUTH.searchtype = "email">selected</#if> >이메일</option>
										<option value="dept_nm"  <#if SUSERAUTH.searchtype = "dept_nm">selected</#if> >부서명</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SUSERAUTH.searchkeyword??>${SUSERAUTH.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary" value="검색">
								</span>
							</div><!-- /input-group -->
						</form>
					</div>
					<div class="col-xs-3">
						<!--
						<div class="text-right">
							<a href="create" class="btn btn-success">등록하기</a>
						</div>
						-->
					</div>
				</div>
			</div>		
			
			<div class="panel panel-widget" id="p01" >
				<!--
	            <div class="panel-heading">
	                <i class="fa fa-edit"></i><span class="panel-title">내가 보고한 일일 업무 보고</span>
					<div class="pull-right">
						<a href="dailyreport.php?cmd=addform" class="btn btn-danger ">일일 업무 보고 작성하기</a>
					</div>
	            </div>
	           	-->
	            <div class="panel-body" align="center">
            
					<table class="table  table-bordered table-striped">
						<cols>
							<col width="160px" />
							<col xwidth="100px" />
							<col width="150px" />
							<col width="250px" />
							<col width="150px" />
							<col width="120px" />
							<col width="100px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">USER NO</th>
			    			<th>사용자명</th>
			    			<th class="text-center">USER ID</th>
			    			<th class="text-center">이메일주소</th>
			    			<th class="text-center">부서명</th>
			    			<th class="text-center">사용가능여부</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if USERAUTHLIST?has_content>
							<#list USERAUTHLIST as USERAUTH>
								<tr>
									<td class="text-center"><a href="update/${USERAUTH.user_no}">${USERAUTH.user_no}</a></td>
									<td><a href="update/${USERAUTH.user_no}">${USERAUTH.user_nm}</a></td>
									<td class="text-center"><a href="update/${USERAUTH.user_no}">${USERAUTH.user_id}</a></td>
									<td class="text-center"><a href="update/${USERAUTH.user_no}">${USERAUTH.email}</a></td>
									<td class="text-center">${USERAUTH.dept_nm}</td>
									<td class="text-center">
										<#if USERAUTH.auth_lvl == 0 >권한없음<#elseif USERAUTH.auth_lvl == 2>관리자<#else>일반사용자</#if>
									</td>
									<td class="text-center">
										<a href="update/${USERAUTH.user_no}" class="btn btn-warning btn-xs">수정 / 삭제</a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="7" class="text-center" style="margin-top:40px;padding-top:40px;">사용자 정보가 없습니다</td>
						</tr>
						</#if>
						
			  		</table>
			
			  		<nav class="text-center">
					  <ul class="pagination">
						  <#if paging.minPageNumber != 0 && paging.maxPageNumber != 0> <#if
						  paging.prevPageNumber != 0>
						  <li><a href="javascript:goPage(${paging.prevPageNumber})" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li> </#if>
						  <#list paging.minPageNumber..paging.maxPageNumber as i> <#if i = paging.pageNumber>
						  <li class="active"><#else>
						  <li></#if><a href="javascript:goPage(${i})">${i}</a></li> </#list> <#if
						  paging.nextPageNumber != 0>
						  <li><a href="javascript:goPage(${paging.nextPageNumber})" aria-label="Next"><span aria-hidden="true">&raquo;</span></a></li> </#if>
						  </#if>
					  </ul>
					</nav>
					<script language="javascript">
					function goPage(pageno)
					{
						document.pageform.pageno.value= pageno;
						document.pageform.submit();
					}
					</script>
					<form name="pageform" method="get">
					<input type="hidden" name="pageno" value="${paging.pageNumber}">
					<input type="hidden" name="searchtype" value="${SUSERAUTH.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SUSERAUTH.searchkeyword}">
					</form>
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">
		
<#include "/layout/end.ftl">