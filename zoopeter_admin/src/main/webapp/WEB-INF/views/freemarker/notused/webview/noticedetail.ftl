<#include "/layout/begin.ftl">

		<#assign pagetitle="웹뷰 - 공지사항">
		<#assign pagelink="webview">
		<#assign subtitle="">

		<#include "/layout/pagehead.ftl">
		
		<div class="panel panel-default">
			<div class="panel-heading">웹뷰 - 공지사항</div>
			<div class="panel-body">
				
				<div style="margin-bottom:10px;">
					<a href="javascript:history.back()" class="btn btn-default">돌아가기</a>
				</div> 
				 
					<table class="table  table-bordered table-striped">
						<cols>
							<col width="70px" />
							<col xwidth="100px" />
						</cols>
			
					<#if POST??>
						<tr>
							<td class="text-center">${POST.postid}</td>
							<td><a href="<@spring.url '/' />webview/${GAME.gameurl}/notice/${POST.postid}">${POST.title}</a></td>
						</tr>
						<tr>
							<td colspan=2>
								${POST.contents}
							</td>
						</tr>
					<#else>
						<tr style="height:100px;">
							<td colspan="10" class="text-center" style="margin-top:40px;padding-top:40px;">등록된 게시글이 없습니다</td>
						</tr>
					</#if>
			  		</table>
					<a href="javascript:history.back()" class="btn btn-default">돌아가기</a>
				</div>
			</div>
			
		<#include "/layout/pagefooter.ftl">
      
<#include "/layout/end.ftl">