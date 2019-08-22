<#include "/layout/begin.ftl">

		<#assign pagetitle="앱  관리">
		<#assign pagelink="appinfo">
		<#assign subtitle="">
		<#if APPINFOCOUNT??><#assign subtitle="( 총 : "+APPINFOCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
			<div class="well">
				<div class="row">
					<form action="" method="get" name="sform">
					<div class="col-xs-2">
						<select name="cust_id" class="form-control" onChange="document.sform.submit()">
						<OPTION value="">고객사를 선택하세요</OPTION>
						<#if CUSTINFOLIST?has_content>
							<#list CUSTINFOLIST as CUSTINFO>
								<option value="${CUSTINFO.cust_id}" <#if SAPPINFO.cust_id == CUSTINFO.cust_id>selected</#if> >${CUSTINFO.cust_nm}</option>
							</#list>
						</#if>
						</select>		
					</div>
					<div class="col-xs-7">
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="app_nm" <#if SAPPINFO.searchtype = "app_nm">selected</#if> >앱이름</option>
										<option value="app_id"  <#if SAPPINFO.searchtype = "app_id">selected</#if>>APP_ID</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SAPPINFO.searchkeyword??>${SAPPINFO.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary" value="검색">
								</span>
							</div><!-- /input-group -->

					</div>
					<div class="col-xs-3">
						<div class="text-right">
							<a href="create" class="btn btn-success">등록하기</a>
						</div>
					</div>
					</form>					
				</div>
			</div>
		
			<div class="panel panel-widget" id="p01" >
	           	<div class="panel-body" align="center">
					<table class="table  table-bordered table-striped">
						<cols>
							<col width="70px" />
							<col width="70px" /> 
							<col xwidth="100px" />
							<col width="80px" />
							<col width="80px" />
							<col width="250px" />
							<col width="100px" />
							<col width="140px" /> 
							<col width="80px" />
							<col width="90px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">APP_ID</th>
			    			<th class="text-center">Image</th>
			    			<th>앱 이름</th>
			    			<th class="text-center">앱 OS</th>
			    			<th class="text-center">앱 버전</th>
			    			<th class="text-center">앱 설명</th>
			    			<th class="text-center">등록일</th>
			    			<th class="text-center">고객사</th>
			    			<th class="text-center">테스트수</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if APPINFOLIST?has_content>
							<#list APPINFOLIST as APPINFO>
								<tr>
									<td class="text-center"><a href="update/${APPINFO.app_id}">${APPINFO.app_id}</a></td>
									<td class="text-center">
										<#if APPINFO.app_image != ''>
										<img src="<@spring.url '/downloader/' />${APPINFO.app_image}" class="thumbnail" width="50px" style="margin-bottom:0px;">
										</#if>
									</td>									
									<td><a href="update/${APPINFO.app_id}">${APPINFO.app_nm}</a></td>
									<td class="text-center">${APPINFO.app_os}</td>
									<td class="text-center">${APPINFO.app_ver}</td>
									<td class="text-left">${APPINFO.app_desc}</td>
									<td class="text-center">${APPINFO.app_regdate?datetime?string("yyyy-MM-dd")}</td>
									<td class="text-left">${APPINFO.cust_nm}</td>
									<td class="text-center">${APPINFO.test_cnt}</td>
									<td class="text-center">
										<a href="update/${APPINFO.app_id}" class="btn btn-warning btn-xs">수정 / 삭제</a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="10" class="text-center" style="margin-top:40px;padding-top:40px;">등록된 앱 정보가 없습니다</td>
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
					<input type="hidden" name="searchtype" value="${SAPPINFO.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SAPPINFO.searchkeyword}">
					</form>
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">