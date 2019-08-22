<#include "/layout/begin.ftl">

		<#assign pagetitle="웹뷰 - 공지사항">
		<#assign pagelink="webview">
		<#assign subtitle="">
		<#if POSTCOUNT??><#assign subtitle="( 총 : "+POSTCOUNT+" )"></#if>
		<#include "/layout/pagehead.ftl">
		
		<div class="panel panel-default">
			<div class="panel-heading">웹뷰 - 공지사항 ( ${POSTCOUNT} )</div>
			<div class="panel-body">
					<a href="javascript:history.back()" class="btn btn-default">돌아가기</a> 
					
					<table class="table  table-bordered table-striped">
						<cols>
							<col width="70px" />
							<col xwidth="100px" />
							<col width="80px" />
						</cols>
			    		<tr class="info">
			    			<th class="text-center">POSTID</th>
			    			<th>제목</th>
			    			<th class="text-center">비고</th>
			    		</tr>
			
						<#if POSTLIST?has_content>
							<#list POSTLIST as POST>
								<tr>
									<td class="text-center">${POST.postid}</td>
									<td><a href="<@spring.url '/' />webview/${GAME.gameurl}/notice/${POST.postid}">${POST.title}</a></td>
									<td class="text-center">
										<a href="<@spring.url '/' />webview/${GAME.gameurl}/notice/${POST.postid}" class="btn btn-warning btn-xs">보기</a>
									</td>
								</tr>
							</#list>
						<#else>
						<tr style="height:100px;">
							<td colspan="10" class="text-center" style="margin-top:40px;padding-top:40px;">등록된 게시글이 없습니다</td>
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
					<input type="hidden" name="searchtype" value="${SPOST.searchtype}">
					<input type="hidden" name="searchkeyword" value="${SPOST.searchkeyword}">
					</form>
					
					<a href="javascript:history.back()" class="btn btn-default">돌아가기</a> 
				</div>
			</div>
			
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">