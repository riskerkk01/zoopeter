<#include "/layout/begin.ftl">

		<#assign pagetitle="테스트 조회">
		<#assign pagelink="testmas">
		<#assign subtitle="">
		<#if TESTMASCOUNT??><#assign subtitle="( 총 : "+TESTMASCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
			
			<div class="well">
				<div class="row">
					<div class="col-xs-9">
						<form action="" method="get" name="sform">
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="test_nm" <#if STESTMAS.searchtype = "test_nm">selected</#if> >테스트명</option>
										<option value="test_id"  <#if STESTMAS.searchtype = "test_id">selected</#if>>테스트 ID</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if STESTMAS.searchkeyword??>${STESTMAS.searchkeyword}</#if>">
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

	            <div class="panel-body" align="center">
				    <table class="table  table-bordered table-striped">
						<cols>
							<col width="80px" />
							<col width="80px" />
							<col xwidth="100px" />
							<col width="150px" />
							<col width="110px" />
							<col width="60px" />
							<col width="60px" />
							<col width="170px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">테스트 ID</th>
			    			<th class="text-center">유형</th>
			    			<th class="text-center">테스트명</th>
			    			<th class="text-center">고객사</th>
			    			<th class="text-center">수행일자</th>
			    			<th class="text-center">수행시</th>
			    			<th class="text-center">상태</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if TESTMASLIST?has_content>
							<#list TESTMASLIST as TESTMAS>
								<tr>
									<td class="text-center">${TESTMAS.test_id}</td>
									<td class="text-center">
										<#if TESTMAS.test_type = "PF">성능</#if>
										<#if TESTMAS.test_type = "CO">호환성</#if>
									</td>
									<td >${TESTMAS.test_nm}</td>	
									<td >
										<#if CUSTINFOLIST?has_content>
											<#list CUSTINFOLIST as CUSTINFO>
												<#if CUSTINFO.cust_id = TESTMAS.cust_id>${CUSTINFO.cust_nm}</#if>
											</#list>
										</#if>
										${TESTMAS.cust_id}
									</td>
									<td class="text-center">${TESTMAS.test_dt}</td>					
									<td class="text-center">${TESTMAS.test_tm} 시</td>
									<td class="text-center">
										<#if TESTMAS.test_status = "I">등록중</#if>
										<#if TESTMAS.test_status = "W">대기</#if>
										<#if TESTMAS.test_status = "R">실행중</#if>
										<#if TESTMAS.test_status = "C">완료</#if>
										<#if TESTMAS.test_status = "E">오류</#if>
										
									</td>
									<td class="text-center">
										<!-- -->
										
										<a href="update/${TESTMAS.test_id}" class="btn btn-warning btn-xs">수정 / 삭제</a>
										
										<!-- 
										<a href="randomAdd/${TESTMAS.test_id}" class="btn btn-danger btn-xs">샘플들추가</a>
										 -->
										<#if TESTMAS.test_status == "C" >
										<a href="report/${TESTMAS.test_id}" class="btn btn-info btn-xs">리포트보기</a>
										</#if>
										<!-- -->
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:150px;">
							<td colspan="8" class="text-center" >테스트 정보가 없습니다</td>
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
					<input type="hidden" name="searchtype" value="${STESTMAS.searchtype}">
					<input type="hidden" name="searchkeyword" value="${STESTMAS.searchkeyword}">
					</form>
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">

      
<#include "/layout/end.ftl">
