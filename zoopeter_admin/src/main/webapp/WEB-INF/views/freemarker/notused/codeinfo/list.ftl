<#include "/layout/begin.ftl">

		<#assign pagetitle="분류코드 관리">
		<#assign pagelink="codeinfo">
		<#assign subtitle="">
		<#if CODEINFOCOUNT??><#assign subtitle="( 총 : "+CODEINFOCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
			
			<div class="well">
				<div class="row">
					<div class="col-xs-9">
						<form action="" method="get" name="sform">
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="code_name" <#if SCODEINFO.searchtype = "code_name">selected</#if> >분류명</option>
										<option value="code_id"  <#if SCODEINFO.searchtype = "code_id">selected</#if>>CODE ID</option>
										<option value="code_type"  <#if SCODEINFO.searchtype = "code_type">selected</#if>>분류코드</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SCODEINFO.searchkeyword??>${SCODEINFO.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary" value="검색">
								</span>
							</div><!-- /input-group -->
						</form>
					</div>
					<div class="col-xs-3">
						<div class="text-right">
							<a href="create" class="btn btn-success">등록하기</a>
						</div>
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
							<col width="100px" />
							<col width="200px" />
							<col width="200px" />
							<col xwidth="100px" />
							<col width="100px" />
							<col width="100px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">CODE_ID</th>
			    			<th class="text-center">분류코드</th>
			    			<th>분류명</th>
			    			<th class="text-center">분류설명</th>
			    			<th class="text-center">노출순서</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if CODEINFOLIST?has_content>
							<#list CODEINFOLIST as CODEINFO>
								<tr>
									<td class="text-center"><a href="update/${CODEINFO.code_id}">${CODEINFO.code_id}</a></td> 
									<td >${CODEINFO.code_type}</td>
									<td ><a href="update/${CODEINFO.code_id}">${CODEINFO.code_name}</a></td>	
									<td >${CODEINFO.code_val}</td>
									<td class="text-center">${CODEINFO.view_seq}</td>					
									<td class="text-center">
										<a href="update/${CODEINFO.code_id}" class="btn btn-warning btn-xs">수정 / 삭제</a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="5" class="text-center" style="margin-top:40px;padding-top:40px;">분류코드 정보가 없습니다</td>
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
					<input type="hidden" name="searchtype" value="${SCODEINFO.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SCODEINFO.searchkeyword}">
					</form>
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">

      
<#include "/layout/end.ftl">