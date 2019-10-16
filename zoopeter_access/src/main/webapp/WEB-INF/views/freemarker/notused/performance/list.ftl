<#include "/layout/begin.ftl">

	<#macro convert_sec sec><#compress>
		<#if sec &gt; 60>
			<#assign xx1=sec/60>
			<#assign xx2=sec%60>
			${xx1?floor}m ${xx2?floor}s
		<#else>
			${sec}s
		</#if>
	</#compress></#macro>
	
		<#assign pagetitle="성능 테스트 조회">
		<#assign pagelink="testmas">
		<#assign subtitle="">
		<#if PERFORMANCECOUNT??><#assign subtitle="( 총 : "+PERFORMANCECOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
			<form action="" method="get" name="sform">
			<div class="well">
				<div class="row">
					<div class="col-xs-2">
						<select name="performance_app_id" class="form-control" onChange="document.sform.submit()">
						<OPTION value="">앱 선택하세요</OPTION>
						<#if APPINFOLIST?has_content>
							<#list APPINFOLIST as APPINFO>
								<option value="${APPINFO.app_id}" <#if SPERFORMANCE.performance_app_id == APPINFO.app_id>selected</#if> >${APPINFO.app_nm}</option>
							</#list>
						</#if>
						</select>		
					</div>				
					<div class="col-xs-7">
						
							<div class="input-group">
								<div class="input-group-btn" style="width:140px;">
									<select name="searchtype" class="form-control" style="width:140px:">
										<option value="performance_memo" <#if SPERFORMANCE.searchtype = "performance_memo">selected</#if> >메모</option>
										<option value="performance_id"  <#if SPERFORMANCE.searchtype = "performance_id">selected</#if>>No.</option>
									</select>
								</div>
								<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="searchkeyword" value="<#if SPERFORMANCE.searchkeyword??>${SPERFORMANCE.searchkeyword}</#if>">
								<span class="input-group-btn">
									<input type="submit" class="btn btn-primary" value="검색">
								</span>
							</div><!-- /input-group -->
						
					</div>
					<div class="col-xs-3">
						<div class="text-right">
							<!--<a href="create" class="btn btn-success">등록하기</a>-->
						</div>
					</div>
				</div>
			</div>
			</form>
			
			<div class="panel panel-widget" id="p01" >

	            <div class="panel-body" align="center">
				    <table class="table  table-bordered table-striped">
						<cols>
							<col width="80px" />
							<col width="70px" />
							<col xwidth="150px" />
							<col width="70px" />
							<col width="70px" />
							<col width="100px" />
							<col width="70px" />
							<col width="200px" />
							<col width="90px" />
							<col width="80px" />
							<col width="100px" />
							<col width="120px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">No.</th> 
			    			<th class="text-center">아이콘</th>
			    			<th class="text-center">앱 이름</th>
			    			<th class="text-center">버젼</th>
			    			<th class="text-center">차수</th>
			    			<th class="text-center">기기</th>
			    			<th class="text-center">OS Ver.</th>
			    			<th class="text-center">메모</th>
			    			<th class="text-center">수행일</th>
			    			<th class="text-center">진행시간</th>
			    			<th class="text-center">진행자</th>
			    			<th class="text-center">상태</th>
			    		</tr>
			
						<#if PERFORMANCELIST?has_content>
							<#list PERFORMANCELIST as PERFORMANCE>
								<#assign t_app_image="">
								<#assign t_app_nm="">
								<#assign t_app_ver="">
								<#if APPINFOLIST?has_content>
									<#list APPINFOLIST as APPINFO>
										<#if APPINFO.app_id = PERFORMANCE.performance_app_id>
											<#assign t_app_image=APPINFO.app_image>
											<#assign t_app_nm=APPINFO.app_nm>
											<#assign t_app_ver=APPINFO.app_ver>
										</#if>
									</#list>
								</#if>								
								<tr>
									<td class="text-center">${PERFORMANCE.performance_id}</td>
									<td class="text-center">
										<#if t_app_image != ''>
											<img src="<@spring.url '/downloader/' />${t_app_image}" class="thumbnail" width="50px" style="margin-bottom:0px;">
										</#if>
									</td>
									<td class="text-left">${t_app_nm}</td>
									<td class="text-center">${t_app_ver}</td>
									<td class="text-center">${PERFORMANCE.performance_cnt}</td>
									<td class="text-center">${PERFORMANCE.performance_device_name}</td>	
									<td class="text-center">${PERFORMANCE.performance_device_version}</td>
									<td class="text-left">${PERFORMANCE.performance_memo}</td>
									<td class="text-center">${PERFORMANCE.performance_date?substring(0,19)}</td>
									<td class="text-center">
										<@convert_sec PERFORMANCE.performance_runtime />
									</td>					
									<td class="text-center">${PERFORMANCE.performance_user_id}</td>
									<td class="text-center">
										<#if PERFORMANCE.performance_state = 0>
											<a class="btn btn-info btn-xs"><span class="fa fa-cloud-upload"></span></a>
											<a href="randomAdd/${PERFORMANCE.performance_id}" class="btn btn-info btn-xs" title="샘플추가"><span class="fa fa-plus-square"></span></a>
										</#if>
										<#if PERFORMANCE.performance_state = 1>
											<a href="report/${PERFORMANCE.performance_id}" class="btn btn-success btn-xs"><span class="fa fa-bar-chart-o"></span></a>
											<a href="randomAdd/${PERFORMANCE.performance_id}" class="btn btn-info btn-xs" title="샘플추가"><span class="fa fa-plus-square"></span></a>
										</#if>
										<a href="javascript:Delete(${PERFORMANCE.performance_id})" class="btn btn-danger btn-xs" title="삭제">삭제</a>
									</td> 
								</tr>
							</#list>
						<#else>
						<tr style="height:150px;">
							<td colspan="12" class="text-center" >테스트 정보가 없습니다</td>
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
					function Delete(performance_id)
					{
						if( confirm('삭제하시면 데이타는 복구할 수 없습니다. 삭제하시겠습니까?') == false ) {
							return;
						}
						document.deleteform.action="delete/"+performance_id;
						document.deleteform.submit();
					}
					function goPage(pageno)
					{
						document.pageform.pageno.value= pageno;
						document.pageform.submit();
					}
					</script>
					<form name="pageform" method="get" >
					<input type="hidden" name="pageno" value="${paging.pageNumber}">
					<input type="hidden" name="searchtype" value="${SPERFORMANCE.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SPERFORMANCE.searchkeyword}">
					</form>
					<form name="deleteform" method="post">
					</form>					
				</div>
			</div>
		<#include "/layout/pagefooter.ftl">

      
<#include "/layout/end.ftl">
